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
    
    self.label.text = @"Camera";
}

- (void)setupConstraints {
    [super setupConstraints];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.corneredView
                                                                 attribute: NSLayoutAttributeTop
                                                                 relatedBy: NSLayoutRelationEqual
                                                                    toItem: self.contentView
                                                                 attribute: NSLayoutAttributeTop
                                                                multiplier: 1.0
                                                                  constant: 18.0f]];
}

@end
