//
//  IMStreamCollectionViewCell.h
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 3/31/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMCollectionViewCellProtocol.h"
#import "IMCaptureSessionManager.h"

@interface IMStreamCollectionViewCell : UICollectionViewCell<IMCollectionViewCellProtocol>

- (void)setCaptureSessionManager:(IMCaptureSessionManager *)captureSessionManager;
- (void)shotButtonTapped;

@end
