//
//  IMessageViewControllerProtocol.h
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/5/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IMessageViewControllerProtocol <NSObject>

@required
- (void)pickedAttachmentImage:(UIImage *)attachmentImage;

@end
