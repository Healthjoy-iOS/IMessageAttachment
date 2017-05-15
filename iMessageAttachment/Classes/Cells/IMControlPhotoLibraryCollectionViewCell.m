//
//  IMControlPhotoLibraryCollectionViewCell.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/3/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import "IMControlPhotoLibraryCollectionViewCell.h"

@implementation IMControlPhotoLibraryCollectionViewCell

- (void)setupLayouts {
    [super setupLayouts];
    
    self.iconImageView.image = [UIImage imageNamed:@"ic_photo_library"
                                          inBundle:[IMBundleLocator resourcesBundle]
                     compatibleWithTraitCollection:nil];
    self.label.text = @"Photo\rLibrary";
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
                                                                      constant: 12.0f]];
    }
    
    {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.label
                                                                     attribute: NSLayoutAttributeTop
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.iconImageView
                                                                     attribute: NSLayoutAttributeBottom
                                                                    multiplier: 1.0
                                                                      constant: 5.0f]];
    }
}

@end
