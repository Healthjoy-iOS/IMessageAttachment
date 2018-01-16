//
//  IMCaptureSessionManager.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/5/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import "IMCaptureSessionManager.h"
#import <UIKit/UIImage.h>

@interface IMCaptureSessionManager ()

@property (nonatomic, readonly) AVCaptureSession *captureSession;
@property (nonatomic, readonly) dispatch_queue_t sessionQueue;

@end

@implementation IMCaptureSessionManager {
    
    MICaptureImageBlock _captureImageBlock;
}

- (instancetype)init {
    self = [super init];
    
    if(self == nil)
        return nil;
    
    _sessionQueue = dispatch_queue_create("com.iMessageAttachment.app.backgroundQueue", 0);
    
    AVCaptureDevice *captureDevice = [[AVCaptureDevice devices] firstObject];
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    AVCaptureStillImageOutput *output = [AVCaptureStillImageOutput new];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [output setOutputSettings:outputSettings];
    
    _captureSession = [AVCaptureSession new];
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    if([self.captureSession canAddInput:input])
        [self.captureSession addInput:input];
    if([self.captureSession canAddOutput:output])
        [self.captureSession addOutput:output];
    
    return self;
}

- (void)startRunning {
    dispatch_async(_sessionQueue, ^{
        [self.captureSession startRunning];
    });
}

- (void)stopRunning {
    dispatch_async(_sessionQueue, ^{
        [self.captureSession stopRunning];
    });
}

- (BOOL)isRunning {
    return [self.captureSession isRunning];
}

- (void)previewLayer:(CGRect)frame completion:(void(^)(AVCaptureVideoPreviewLayer *previewLayer))completion  {
    dispatch_async(_sessionQueue, ^{
        AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
        CGRect nFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        layer.frame = nFrame;
        completion(layer);
    });
}

- (void)switchCamera {
    [self.captureSession beginConfiguration];
    
    AVCaptureInput* currentCameraInput = [self.captureSession.inputs objectAtIndex:0];
    [self.captureSession removeInput:currentCameraInput];
    
    AVCaptureDevice *newCamera = nil;
    if(((AVCaptureDeviceInput*)currentCameraInput).device.position == AVCaptureDevicePositionBack)
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
    else
        newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
    
    NSError *err = nil;
    AVCaptureDeviceInput *newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:newCamera error:&err];
    if(!newVideoInput || err)
        NSLog(@"[IMessageAttachment] Error creating capture device input: %@", err.localizedDescription);
    else
        [self.captureSession addInput:newVideoInput];
    
    [self.captureSession commitConfiguration];
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
        if ([device position] == position) return device;
    
    return nil;
}

- (void)takePhoto:(MICaptureImageBlock)captureImageBlock {
    _captureImageBlock = captureImageBlock;
    
    AVCaptureStillImageOutput *currentCameraOutput = [self.captureSession.outputs objectAtIndex:0];
    AVCaptureConnection *connection = [currentCameraOutput connectionWithMediaType:AVMediaTypeVideo];
    if(connection.active && connection.enabled && connection) {
        [currentCameraOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            if(error)
                NSLog(@"[IMessageAttachment] Error: %@", error.localizedDescription);
            
            if(imageDataSampleBuffer) {
                NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                UIImage *image = [[UIImage alloc] initWithData:imageData];
                
                _captureImageBlock(image);
            }
        }];
    }
}

@end

