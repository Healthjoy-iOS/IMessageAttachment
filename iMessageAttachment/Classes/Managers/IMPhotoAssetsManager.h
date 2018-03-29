//
//  IMPhotoAssetsManager.h
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/6/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>
#import <UIKit/UICollectionView.h>

@interface IMPhotoAssetsManager : NSObject

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;
- (void)fetchAssets;

- (NSUInteger)photoCount;
- (void)photoAtIndexPath:(NSIndexPath *)indexPath
              targetSize:(CGSize)targetSize completion:(void(^)(UIImage *image))completion;

@end
