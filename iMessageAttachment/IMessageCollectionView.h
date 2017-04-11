//
//  IMessageCollectionView.h
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/11/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMConstants.h"

@protocol IMessageViewControllerProtocol;

@interface IMessageCollectionView : UICollectionView

@property (nonatomic, weak) id<IMessageViewControllerProtocol> VCDelegate;

@end
