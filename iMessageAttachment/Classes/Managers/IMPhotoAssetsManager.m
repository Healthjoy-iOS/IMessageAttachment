//
//  IMPhotoAssetsManager.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/6/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import "IMPhotoAssetsManager.h"
#import <Photos/Photos.h>

@interface IMPhotoAssetsManager ()

@property(nonatomic, strong) PHFetchResult *assetsFetchResults;
@property(nonatomic, strong) PHCachingImageManager *imageManager;

@end

@implementation IMPhotoAssetsManager

+ (instancetype)fetchAssets {
    IMPhotoAssetsManager *photoAssetsManager = [IMPhotoAssetsManager new];
    PHFetchOptions *options = [PHFetchOptions new];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    photoAssetsManager.assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    photoAssetsManager.imageManager = [[PHCachingImageManager alloc] init];
    return photoAssetsManager;
}

- (NSUInteger)photoCount {
    return self.assetsFetchResults.count;
}

- (void)photoAtIndexPath:(NSIndexPath *)indexPath
              targetSize:(CGSize)targetSize completion:(void(^)(UIImage *image))completion {
    PHImageRequestOptions* options = [PHImageRequestOptions new];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
    [self.imageManager requestImageForAsset:asset
                                 targetSize:targetSize
                                contentMode:PHImageContentModeAspectFill
                                    options:options
                              resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                  completion(result);
                              }];
}

- (CGSize)maximumSize {
    
    return PHImageManagerMaximumSize;
}

@end
