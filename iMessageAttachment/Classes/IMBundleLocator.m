//
//  IMBundleLocator.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 5/15/17.
//
//

#import "IMBundleLocator.h"

@implementation IMBundleLocator

+ (NSBundle *)resourcesBundle {
    NSBundle *ourBundle = [NSBundle bundleWithPath:@"IMessageAttachment.bundle"];
    if (ourBundle == nil) {
        ourBundle = [NSBundle mainBundle];
    }
    return ourBundle;
}

@end
