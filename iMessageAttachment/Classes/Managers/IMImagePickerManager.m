//
//  IMessageImagePickerManager.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 4/5/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import "IMImagePickerManager.h"
#import "IMessageViewControllerDelegate.h"

@interface IMImagePickerManager ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

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

@end
