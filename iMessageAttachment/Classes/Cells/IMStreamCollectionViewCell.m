//
//  IMStreamCollectionViewCell.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 3/31/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import "IMStreamCollectionViewCell.h"
#import "IMBundleLocator.h"
#import "IMConstants.h"

@interface IMStreamCollectionViewCell ()

@property (nonatomic, strong) UIView *streamView;
@property (nonatomic, strong) UIButton *switchCameraButton;
@property (nonatomic, strong) UIImageView *shotImageView;

@property (nonatomic, weak, readonly) IMCaptureSessionManager *captureSessionManager;

@end

@implementation IMStreamCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self == nil)
        return nil;

    self.streamView = [UIView new];
    [self.streamView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.streamView];
    
    self.switchCameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.switchCameraButton setImage:[UIImage imageNamed:@"ic_switch_camera"
                                                 inBundle:[IMBundleLocator resourcesBundle]
                            compatibleWithTraitCollection:nil]
                             forState:UIControlStateNormal];
    [self.switchCameraButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.switchCameraButton addTarget:self
                                action:@selector(switchCameraButtonTapped:)
                      forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.switchCameraButton];
    
    self.shotImageView = [UIImageView new];
    self.shotImageView.image = [UIImage imageNamed:@"ic_takephoto"
                                          inBundle:[IMBundleLocator resourcesBundle]
                     compatibleWithTraitCollection:nil];
    [self.shotImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.shotImageView];
    
    [self setupLayouts];
    [self setupConstraints];
    
    return self;
}

- (void)setCaptureSessionManager:(IMCaptureSessionManager *)captureSessionManager {
    if(captureSessionManager == _captureSessionManager)
        return;
    _captureSessionManager = captureSessionManager;
    
    [self.captureSessionManager previewLayer:self.frame completion:^(AVCaptureVideoPreviewLayer *previewLayer) {
        dispatch_async(dispatch_get_main_queue(), ^void() {
            [self.streamView.layer addSublayer:previewLayer];
        });
    }];
}

#pragma mark - Private

- (void)switchCameraButtonTapped:(id)sender {
    [self.captureSessionManager switchCamera];
}

- (void)shotButtonTapped {
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
        return;
    
    [self.captureSessionManager takePhoto:^(UIImage *image) {
        if(image)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kIMTookImageFromCaptureSession
                                                                object:self
                                                              userInfo:@{@"image" : image}];
        }
    }];
    
    [self animationShot];
}

- (void)animationShot {
    [UIView animateWithDuration:0.1f animations:^{
        self.streamView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f animations:^{
            self.streamView.alpha = 1.f;
        } completion:nil];
    }];
}


- (void)setupLayouts {
    self.contentView.backgroundColor = [UIColor clearColor];
    self.streamView.backgroundColor = [UIColor blackColor];
}

- (void)setupConstraints {
    
    {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.streamView
                                                                     attribute: NSLayoutAttributeWidth
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.contentView
                                                                     attribute: NSLayoutAttributeWidth
                                                                    multiplier: 1.0
                                                                      constant: -5.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.streamView
                                                                     attribute: NSLayoutAttributeHeight
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.contentView
                                                                     attribute: NSLayoutAttributeHeight
                                                                    multiplier: 1.0
                                                                      constant: 0.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.streamView
                                                                     attribute: NSLayoutAttributeCenterX
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.contentView
                                                                     attribute: NSLayoutAttributeCenterX
                                                                    multiplier: 1.0
                                                                      constant: -5.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.streamView
                                                                     attribute: NSLayoutAttributeCenterY
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.contentView
                                                                     attribute: NSLayoutAttributeCenterY
                                                                    multiplier: 1.0
                                                                      constant: 0.0f]];
    }
    
    {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.switchCameraButton
                                                                     attribute: NSLayoutAttributeTop
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.streamView
                                                                     attribute: NSLayoutAttributeTop
                                                                    multiplier: 1.0
                                                                      constant: 10.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.switchCameraButton
                                                                     attribute: NSLayoutAttributeTrailing
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.streamView
                                                                     attribute: NSLayoutAttributeTrailing
                                                                    multiplier: 1.0
                                                                      constant: -10.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.switchCameraButton
                                                                     attribute: NSLayoutAttributeWidth
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: nil
                                                                     attribute: NSLayoutAttributeNotAnAttribute
                                                                    multiplier: 1.0
                                                                      constant: 24.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.switchCameraButton
                                                                     attribute: NSLayoutAttributeHeight
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: nil
                                                                     attribute: NSLayoutAttributeNotAnAttribute
                                                                    multiplier: 1.0
                                                                      constant: 24.0f]];
    }
    
    {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.shotImageView
                                                                     attribute: NSLayoutAttributeBottom
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.contentView
                                                                     attribute: NSLayoutAttributeBottom
                                                                    multiplier: 1.0
                                                                      constant: -10.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.shotImageView
                                                                     attribute: NSLayoutAttributeCenterX
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.contentView
                                                                     attribute: NSLayoutAttributeCenterX
                                                                    multiplier: 1.0
                                                                      constant: -5.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.shotImageView
                                                                     attribute: NSLayoutAttributeWidth
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: nil
                                                                     attribute: NSLayoutAttributeNotAnAttribute
                                                                    multiplier: 1.0
                                                                      constant: 24.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.shotImageView
                                                                     attribute: NSLayoutAttributeHeight
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: nil
                                                                     attribute: NSLayoutAttributeNotAnAttribute
                                                                    multiplier: 1.0
                                                                      constant: 24.0f]];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
