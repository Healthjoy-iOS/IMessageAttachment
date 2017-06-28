//
//  ViewController.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 3/30/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import "IMessageViewController.h"
#import "IMessageCollectionView.h"
#import "IMessageViewControllerDelegate.h"

@interface IMessageViewController ()<IMessageViewControllerDelegate>

@property (nonatomic, weak) IBOutlet IMessageCollectionView *attachmentCollectionView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (nonatomic, strong) NSMutableArray<UIImage*> *attachmentContent;

@end

@implementation IMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupProperties];
    [self setupNotifications];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupProperties {
    self.attachmentCollectionView.VCDelegate = self;
    self.attachmentContent = [NSMutableArray array];
}

- (void)setupNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateAttachmentHeight:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

- (IBAction)startOrStopStreamButtonDidSelect:(id)sender {
    if(![self.attachmentCollectionView isStreamRunning])
        [self.attachmentCollectionView startRunningStream];
    else
        [self.attachmentCollectionView stopRunningStream];
}

#pragma mark - Notifications

- (void)updateAttachmentHeight:(NSNotification*)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGFloat height = [keyboardFrameBegin CGRectValue].size.height;
    
    self.collectionViewHeightConstraint.constant = height;
    [self.attachmentCollectionView updateCollectionViewHeight:height];
}

#pragma mark - IMessageViewControllerProtocol

- (void)pickedAttachmentImage:(UIImage *)attachmentImage {
    [self.attachmentContent addObject:attachmentImage];
}

@end
