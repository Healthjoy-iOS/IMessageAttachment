//
//  IMPhotoCollectionViewCell.h
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 3/31/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMCollectionViewCellProtocol.h"

@interface IMPhotoCollectionViewCell : UICollectionViewCell<IMCollectionViewCellProtocol>

@property (nonatomic, readonly) UIImageView *photoImageView;

@end
