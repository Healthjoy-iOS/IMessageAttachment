//
//  IMPhotoCollectionViewCell.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 3/31/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import "IMPhotoCollectionViewCell.h"

@interface IMPhotoCollectionViewCell ()

@end

@implementation IMPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self == nil)
        return nil;
    
    _photoImageView = [UIImageView new];
    [self.photoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.photoImageView];
    
    [self setupLayouts];
    [self setupConstraints];
    
    return self;
}

- (void)setupLayouts {
}

- (void)setupConstraints {
    
    {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.photoImageView
                                                                     attribute: NSLayoutAttributeWidth
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.contentView
                                                                     attribute: NSLayoutAttributeWidth
                                                                    multiplier: 1.0
                                                                      constant: 0.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.photoImageView
                                                                     attribute: NSLayoutAttributeHeight
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.contentView
                                                                     attribute: NSLayoutAttributeHeight
                                                                    multiplier: 1.0
                                                                      constant: 0.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.photoImageView
                                                                     attribute: NSLayoutAttributeCenterX
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.contentView
                                                                     attribute: NSLayoutAttributeCenterX
                                                                    multiplier: 1.0
                                                                      constant: 0.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.photoImageView
                                                                     attribute: NSLayoutAttributeCenterY
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.contentView
                                                                     attribute: NSLayoutAttributeCenterY
                                                                    multiplier: 1.0
                                                                      constant: 0.0f]];
    }
    
}
    
@end
