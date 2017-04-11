//
//  IMessageImagePickerManager.h
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/5/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol IMessageViewControllerProtocol;

@interface IMImagePickerManager : NSObject

- (void)takeAttachmentFromSourceType:(UIImagePickerControllerSourceType)sourceType;

@property (nonatomic, weak) id<IMessageViewControllerProtocol> delegate;
@property (nonatomic, assign) CGFloat compressionQuality;


@end
