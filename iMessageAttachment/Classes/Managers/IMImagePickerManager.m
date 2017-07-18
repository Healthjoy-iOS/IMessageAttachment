//
//  IMessageImagePickerManager.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/5/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import "IMImagePickerManager.h"
#import <AVFoundation/AVFoundation.h>
#import "IMessageViewControllerDelegate.h"


@interface IMImagePickerManager ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate>

@end

@implementation IMImagePickerManager

- (instancetype)init {
    self = [super init];
    
    if(self == nil)
        return nil;
    
    self.compressionQuality = 1.f;
    
    return self;
}

- (void)takeAttachmentFromSourceType:(UIImagePickerControllerSourceType)sourceType {
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] &&
        sourceType == UIImagePickerControllerSourceTypeCamera)
        return;
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(sourceType == UIImagePickerControllerSourceTypeCamera &&
       authStatus == AVAuthorizationStatusDenied) {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"App doesn't have access to your photos. To enable access, tap Settings and turn on Photos."
                                   delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Settings", nil] show];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    picker.navigationBar.tintColor = [UIColor whiteColor];
    [(UIViewController *)self.delegate presentViewController:picker
                                                    animated:YES
                                                  completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *rawImage = info[UIImagePickerControllerOriginalImage];
    
    NSData *imageDataJPEG = UIImageJPEGRepresentation(rawImage, self.compressionQuality);
    UIImage *mayCompressedImage = [UIImage imageWithData:imageDataJPEG];
    
    [self.delegate pickedAttachmentImage:mayCompressedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma marko UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1)
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

@end
