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
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"IMessageAttachment" ofType:@"bundle"];
    NSBundle *ourBundle = [NSBundle bundleWithPath:bundlePath];
    if (ourBundle == nil) {
        ourBundle = [NSBundle mainBundle];
    }
    return ourBundle;
}

@end
