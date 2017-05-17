//
//  IMControlCameraCollectionViewCell.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/3/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import "IMControlCameraCollectionViewCell.h"

@implementation IMControlCameraCollectionViewCell

- (void)setupLayouts {
    [super setupLayouts];
    
    self.iconImageView.image = [UIImage imageNamed:@"ic_add_a_photo"
                                          inBundle:[IMBundleLocator resourcesBundle]
                     compatibleWithTraitCollection:nil];
    self.label.text = @"Camera";
}

- (void)setupConstraints {
    [super setupConstraints];
    
    {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.iconImageView
                                                                     attribute: NSLayoutAttributeTop
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.corneredView
                                                                     attribute: NSLayoutAttributeTop
                                                                    multiplier: 1.0
                                                                      constant: 15.0f]];
    }
    
    {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.label
                                                                     attribute: NSLayoutAttributeTop
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.iconImageView
                                                                     attribute: NSLayoutAttributeBottom
                                                                    multiplier: 1.0
                                                                      constant: 10.0f]];
    }
}

@end
