//
//  IMPhotoAssetsManager.h
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/6/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>

@interface IMPhotoAssetsManager : NSObject

+ (instancetype)fetchAssets;

- (NSUInteger)photoCount;
- (CGSize)maximumSize;
- (void)photoAtIndexPath:(NSIndexPath *)indexPath
              targetSize:(CGSize)targetSize completion:(void(^)(UIImage *image))completion;

@end
