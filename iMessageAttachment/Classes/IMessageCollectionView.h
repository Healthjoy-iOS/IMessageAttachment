//
//  IMessageCollectionView.h
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/11/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMConstants.h"

@protocol IMessageViewControllerDelegate;

@interface IMessageCollectionView : UICollectionView

@property (nonatomic, weak) id<IMessageViewControllerDelegate> VCDelegate;

- (void)startRunningStream;
- (void)stopRunningStream;
- (BOOL)isStreamRunning;

- (void)updateCollectionViewHeight:(CGFloat)height;

@end
