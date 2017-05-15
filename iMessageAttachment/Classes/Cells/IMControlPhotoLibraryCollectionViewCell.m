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
    self.label.text = @"Photo Library";
}

@end
