//
//  IMessageCollectionViewHelper.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 5/10/17.
//
//

#import "IMessageCollectionViewHelper.h"

#define kDefaultKeyboardHeight 258

@implementation IMessageCollectionViewHelper {
    
    CGFloat _keyboardHeight;
}

- (instancetype)init {
    self = [super init];
    
    if(self == nil)
    return nil;
    
    _keyboardHeight = kDefaultKeyboardHeight;
    
    return self;
}

- (void)setKeyboardHeight:(CGFloat)keyboardHeight {
    _keyboardHeight = keyboardHeight;
}

- (CGSize)controlCameraCellSize {
    return CGSizeMake(_keyboardHeight / 2 + 20, _keyboardHeight / 2 - 2);
}

- (CGSize)streamCellSize {
    return CGSizeMake(195, _keyboardHeight - 2);
}

- (CGSize)photoCellSize {
    return CGSizeMake(_keyboardHeight / 2 - 2, _keyboardHeight / 2 - 2);
}

- (CGSize)targetSize {
    return CGSizeMake(250, 250);
}

@end
