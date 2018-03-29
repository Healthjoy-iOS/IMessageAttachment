//
//  IMessageCollectionView.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/11/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import "IMessageCollectionView.h"
#import "IMessageViewControllerDelegate.h"
#import "IMConstants.h"
#import "IMCollectionViewCellProtocol.h"
#import "IMControlCameraCollectionViewCell.h"
#import "IMControlPhotoLibraryCollectionViewCell.h"
#import "IMStreamCollectionViewCell.h"
#import "IMPhotoCollectionViewCell.h"

#import "IMImagePickerManager.h"
#import "IMCaptureSessionManager.h"
#import "IMPhotoAssetsManager.h"

#import "IMessageCollectionViewHelper.h"

@interface IMessageCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) IMImagePickerManager *imagePickerManager;
@property (nonatomic, strong) IMPhotoAssetsManager *photoAssetsManager;
@property (nonatomic, strong) IMCaptureSessionManager *captureSessionManager;
@property (nonatomic, strong) IMessageCollectionViewHelper *collectionViewHelper;

@end


@implementation IMessageCollectionView {
    
    BOOL _isCaptureSessionInterrupted;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupLayouts];
    [self setupNotifications];
}

- (void)setupManagers {
    self.delegate = self;
    self.dataSource = self;
    
    _isCaptureSessionInterrupted = NO;
    
    self.imagePickerManager = [IMImagePickerManager new];
    self.imagePickerManager.delegate = self.VCDelegate;
    self.captureSessionManager = [IMCaptureSessionManager new];
    self.photoAssetsManager = [[IMPhotoAssetsManager alloc] initWithCollectionView:self];
    [self.photoAssetsManager fetchAssets];
    
    [self updateCollectionView];
}

- (void)requestCameraAccessPermission {
    __weak IMessageCollectionView *wSelf = self;
    
    NSString *mediaType = AVMediaTypeVideo;
    [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
        IMessageCollectionView *sSelf = wSelf;
        if(granted) {
            dispatch_async(dispatch_get_main_queue(), ^void() {
                [sSelf updateCollectionView];
                [sSelf.captureSessionManager startRunning];
            });
        }
    }];
}

- (void)setupFirstRun {
    [self setupManagers];
    [self requestCameraAccessPermission];
}

- (void)setupNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tookImageFromCaptureSession:)
                                                 name:kIMTookImageFromCaptureSession
                                               object:nil];
    
    if (@available(iOS 9.0, *)) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(captureSessionInterrupted)
                                                     name:AVCaptureSessionInterruptionReasonKey
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(captureSessionInterruptionEnded)
                                                     name:AVCaptureSessionInterruptionEndedNotification
                                                   object:nil];
    }
    
}

- (void)setupLayouts {
    self.collectionViewHelper = [IMessageCollectionViewHelper new];
    
    self.backgroundColor = [UIColor colorWithRed: 209 / 255.f
                                           green: 212 / 255.f
                                            blue: 217 / 255.f
                                           alpha: 1];
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = YES;
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 0, 1, 0);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionViewLayout = flowLayout;
    
    [self registerClass:[IMControlCameraCollectionViewCell class]
forCellWithReuseIdentifier:kIMControlCameraCollectionViewCell];
    [self registerClass:[IMControlPhotoLibraryCollectionViewCell class]
forCellWithReuseIdentifier:kIMControlPhotoLibraryCollectionViewCell];
    [self registerClass:[IMStreamCollectionViewCell class]
forCellWithReuseIdentifier:kIMStreamCollectionViewCell];
    [self registerClass:[IMPhotoCollectionViewCell class]
forCellWithReuseIdentifier:kIMPhotoCollectionViewCell];
}

- (void)setVCDelegate:(id<IMessageViewControllerDelegate>)VCDelegate {
    _VCDelegate = VCDelegate;
}

- (void)startRunningStream {
    if(self.imagePickerManager == nil) {
        [self setupFirstRun];
        return;
    }
    
    [self.captureSessionManager startRunning];
}

- (void)stopRunningStream {
    [self.captureSessionManager stopRunning];
}

- (BOOL)isStreamRunning {
    return [self.captureSessionManager isRunning];
}

- (void)updateCollectionViewHeight:(CGFloat)height {
    [self.collectionViewHelper setKeyboardHeight:height];
    
    [self updateCollectionView];
}

#pragma mark - Notifications

- (void)captureSessionInterrupted {
    _isCaptureSessionInterrupted = YES;
}

- (void)captureSessionInterruptionEnded {
    _isCaptureSessionInterrupted = NO;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self sizeForItemAtIndexPath:indexPath];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger photoCount = self.photoAssetsManager.photoCount;
    return kIMStaticControlAmount + photoCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<IMCollectionViewCellProtocol> cell = (id<IMCollectionViewCellProtocol>)
    [collectionView dequeueReusableCellWithReuseIdentifier:[self cellIDForItemAtIndexPath:indexPath] forIndexPath:indexPath];
    NSParameterAssert(cell != nil);
    
    if(indexPath.row == IMSteamCell) {
        IMStreamCollectionViewCell *streamCell = (IMStreamCollectionViewCell *)cell;
        [streamCell setCaptureSessionManager:self.captureSessionManager];
    }
    else if(indexPath.row >= IMPhotoCell) {
        NSIndexPath *photoIndexPath = [NSIndexPath indexPathForRow:indexPath.item - kIMStaticControlAmount inSection:indexPath.section];
        IMPhotoCollectionViewCell *photoCell = (IMPhotoCollectionViewCell *)cell;
        [self.photoAssetsManager photoAtIndexPath:photoIndexPath
                                       targetSize:self.collectionViewHelper.targetSize
                                       completion:^(UIImage *image) {
                                           photoCell.photoImageView.image = image;
                                       }];
    }
    
    return (UICollectionViewCell *)cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == IMControlCameraCell)
    {
        [self.imagePickerManager takeAttachmentFromSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else if(indexPath.row == IMControlPhotoLibraryCell)
    {
        [self.imagePickerManager takeAttachmentFromSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else if(indexPath.row == IMSteamCell)
    {
        if(_isCaptureSessionInterrupted) {
            return;
        }
        
        IMStreamCollectionViewCell *streamCell = (IMStreamCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [streamCell shotButtonTapped];
    }
    else if(indexPath.row >= IMPhotoCell)
    {
        NSIndexPath *photoIndexPath = [NSIndexPath indexPathForRow:indexPath.item - kIMStaticControlAmount inSection:indexPath.section];
        [self.photoAssetsManager photoAtIndexPath:photoIndexPath
                                       targetSize:CGSizeZero
                                       completion:^(UIImage *image) {
                                           [self.VCDelegate pickedAttachmentImage:image];
                                       }];
    }
}

#pragma mark - Notifications

- (void)tookImageFromCaptureSession:(NSNotification *)notification {
    UIImage *image = notification.userInfo[@"image"];
    [self.VCDelegate pickedAttachmentImage:image];
}

#pragma mark - Utilities

- (void)updateCollectionView {
    [self layoutIfNeeded];
    [self reloadData];
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize cellSize = CGSizeMake(0, 0);
    if(indexPath.row == IMControlCameraCell || indexPath.row == IMControlPhotoLibraryCell)
        cellSize = self.collectionViewHelper.controlCameraCellSize;
    if(indexPath.row == IMSteamCell)
        cellSize = self.collectionViewHelper.streamCellSize;
    if(indexPath.row >= IMPhotoCell)
        cellSize = self.collectionViewHelper.photoCellSize;
    
    return cellSize;
}

- (NSString *)cellIDForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = [NSString string];
    if(indexPath.row == IMControlCameraCell)
        cellID = kIMControlCameraCollectionViewCell;
    if(indexPath.row == IMControlPhotoLibraryCell)
        cellID = kIMControlPhotoLibraryCollectionViewCell;
    if(indexPath.row == IMSteamCell)
        cellID = kIMStreamCollectionViewCell;
    if(indexPath.row >= IMPhotoCell)
        cellID = kIMPhotoCollectionViewCell;
    
    return cellID;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

