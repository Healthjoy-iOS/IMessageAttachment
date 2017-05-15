//
//  IMControlCollectionViewCell.h
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 3/31/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMBundleLocator.h"
#import "IMCollectionViewCellProtocol.h"

@interface IMControlCollectionViewCell : UICollectionViewCell<IMCollectionViewCellProtocol>
    
@property (nonatomic, readonly) UIView *corneredView;
@property (nonatomic, readonly) UIImageView *iconImageView;
@property (nonatomic, readonly) UILabel *label;

- (void)setupLayouts;
- (void)setupConstraints;

@end
