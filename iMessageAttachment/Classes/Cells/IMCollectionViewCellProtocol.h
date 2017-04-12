//
//  IMCollectionViewCellProtocol.h
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/3/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, IMCollectionCellType) {
    IMControlCameraCell = 0,
    IMControlPhotoLibraryCell = 1,
    IMSteamCell = 2,
    IMPhotoCell = 3,
};

@protocol IMCollectionViewCellProtocol <NSObject>
    
@end
