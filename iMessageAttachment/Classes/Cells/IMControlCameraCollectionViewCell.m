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

@end
