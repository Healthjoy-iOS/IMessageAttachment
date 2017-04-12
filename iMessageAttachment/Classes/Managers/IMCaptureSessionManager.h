//
//  IMCaptureSessionManager.h
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/5/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^MICaptureImageBlock)(UIImage *image);

@interface IMCaptureSessionManager : NSObject

- (void)startRunning;
- (void)stopRunning;
- (BOOL)isRunning;
- (void)previewLayer:(CGRect)frame completion:(void(^)(AVCaptureVideoPreviewLayer *previewLayer))completion;
- (void)switchCamera;
- (void)takePhoto:(MICaptureImageBlock)captureImageBlock;

@end
