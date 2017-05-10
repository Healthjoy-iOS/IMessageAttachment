//
//  IMessageCollectionViewHelper.h
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 5/10/17.
//
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface IMessageCollectionViewHelper : NSObject

- (void)setKeyboardHeight:(CGFloat)keyboardHeight;

- (CGSize)controlCameraCellSize;
- (CGSize)streamCellSize;
- (CGSize)photoCellSize;
- (CGSize)targetSize;

@end
