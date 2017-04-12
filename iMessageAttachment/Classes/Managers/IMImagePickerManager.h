//
//  IMessageImagePickerManager.h
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/5/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol IMessageViewControllerDelegate;

@interface IMImagePickerManager : NSObject

- (void)takeAttachmentFromSourceType:(UIImagePickerControllerSourceType)sourceType;

@property (nonatomic, weak) id<IMessageViewControllerDelegate> delegate;
@property (nonatomic, assign) CGFloat compressionQuality;


@end
