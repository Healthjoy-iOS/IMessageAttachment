//
//  IMPermissionsHelper.m
//  Pods
//
//  Created by Mark Prutskiy on 7/27/17.
//
//

#import "IMPermissionsHelper.h"
#import <AVFoundation/AVFoundation.h>

@interface IMPermissionsHelper ()<UIAlertViewDelegate>

@property (nonatomic, strong) UIAlertView *alertView;

@end

@implementation IMPermissionsHelper

- (BOOL)isAvailableCameraPermission {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusDenied) {
        self.alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"App doesn't have access to your photos. To enable access, tap Settings and turn on Photos."
                                   delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Settings", nil];
        [self.alertView show];
        
        return NO;
    }

    return YES;
}

#pragma mark - 

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1)
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

@end
