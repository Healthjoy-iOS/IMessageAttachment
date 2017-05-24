//
//  IMCaptureSessionManager.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/5/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import "IMCaptureSessionManager.h"
#import <UIKit/UIImage.h>

@interface IMCaptureSessionManager ()<AVCapturePhotoCaptureDelegate>

@property (nonatomic, readonly) AVCaptureSession *captureSession;

@end

@implementation IMCaptureSessionManager {
    
    MICaptureImageBlock _captureImageBlock;
}

- (instancetype)init {
    self = [super init];
    
    if(self == nil)
        return nil;
    
    AVCaptureDevice *captureDevice = [[AVCaptureDevice devices] firstObject];
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    AVCapturePhotoOutput *output = [AVCapturePhotoOutput new];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        _captureSession = [AVCaptureSession new];
        self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
        if([self.captureSession canAddInput:input])
        {
            [self.captureSession addInput:input];
        }
        if([self.captureSession canAddOutput:output])
        {
            [self.captureSession addOutput:output];
        }
    });
    
    return self;
}

- (void)startRunning {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self.captureSession startRunning];
    });
}

- (void)stopRunning {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self.captureSession stopRunning];
    });
}

- (BOOL)isRunning {
    return [self.captureSession isRunning];
}

- (void)previewLayer:(CGRect)frame completion:(void(^)(AVCaptureVideoPreviewLayer *previewLayer))completion  {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        CGRect bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        layer.bounds = bounds;
        layer.position = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
        completion(layer);
    });
}

- (void)switchCamera {
    [self.captureSession beginConfiguration];
    
    AVCaptureInput* currentCameraInput = [_captureSession.inputs objectAtIndex:0];
    [self.captureSession removeInput:currentCameraInput];
    
    AVCaptureDevice *newCamera = nil;
    if(((AVCaptureDeviceInput*)currentCameraInput).device.position == AVCaptureDevicePositionBack)
    {
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
    }
    else
    {
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
    }
    
    NSError *err = nil;
    AVCaptureDeviceInput *newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:newCamera error:&err];
    if(!newVideoInput || err)
    {
        NSLog(@"Error creating capture device input: %@", err.localizedDescription);
    }
    else
    {
        [self.captureSession addInput:newVideoInput];
    }
    
    [self.captureSession commitConfiguration];
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if ([device position] == position) return device;
    }
    return nil;
}

- (void)takePhoto:(MICaptureImageBlock)captureImageBlock {
    _captureImageBlock = captureImageBlock;
    
    AVCapturePhotoOutput *currentCameraOutput = [self.captureSession.outputs objectAtIndex:0];
    AVCaptureConnection *connection = [currentCameraOutput connectionWithMediaType:AVMediaTypeVideo];
    if(connection.active)
        [currentCameraOutput capturePhotoWithSettings:[AVCapturePhotoSettings photoSettings] delegate:self];
}

#pragma mark - AVCapturePhotoCaptureDelegate
-(void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishProcessingPhotoSampleBuffer:(CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(AVCaptureBracketedStillImageSettings *)bracketSettings error:(NSError *)error
{
    if(error) {
        NSLog(@"error : %@", error.localizedDescription);
        _captureImageBlock(nil);
    }
    
    if(photoSampleBuffer) {
        NSData *data = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
        UIImage *image = [UIImage imageWithData:data];
        _captureImageBlock(image);
    }
}

@end
