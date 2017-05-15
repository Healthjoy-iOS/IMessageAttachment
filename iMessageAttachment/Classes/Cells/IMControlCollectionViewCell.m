//
//  IMControlCollectionViewCell.m
//  iMessageAttachment
//
//  Created by Mark Prutskiy on 3/31/17.
//  Copyright © 2017 HealthJoy. All rights reserved.
//

#import "IMControlCollectionViewCell.h"

@interface IMControlCollectionViewCell ()

@end

@implementation IMControlCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self == nil)
        return nil;
    
    _corneredView = [UIView new];
    [self.corneredView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.corneredView];
    
    _iconImageView = [UIImageView new];
    [self.iconImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.corneredView addSubview:self.iconImageView];
    
    _label = [UILabel new];
    [self.label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.corneredView addSubview:self.label];
    
    [self setupLayouts];
    [self setupConstraints];
    
    return self;
}

- (void)setupLayouts {
    
    self.corneredView.backgroundColor = [UIColor whiteColor];
    self.corneredView.layer.cornerRadius = 15.f;
    
    self.label.numberOfLines = 0;
    self.label.textColor = [UIColor blackColor];
    self.label.font = [UIFont systemFontOfSize:18];
    self.label.textAlignment = NSTextAlignmentCenter;
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)setupConstraints {
    
    {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.corneredView
                                                                     attribute: NSLayoutAttributeCenterX
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.contentView
                                                                     attribute: NSLayoutAttributeCenterX
                                                                    multiplier: 1.0
                                                                      constant: 0.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.corneredView
                                                                     attribute: NSLayoutAttributeCenterY
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.contentView
                                                                     attribute: NSLayoutAttributeCenterY
                                                                    multiplier: 1.0
                                                                      constant: 0.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.corneredView
                                                                     attribute: NSLayoutAttributeWidth
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: nil
                                                                     attribute: NSLayoutAttributeNotAnAttribute
                                                                    multiplier: 1.0
                                                                      constant: 105.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.corneredView
                                                                     attribute: NSLayoutAttributeHeight
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: nil
                                                                     attribute: NSLayoutAttributeNotAnAttribute
                                                                    multiplier: 1.0
                                                                      constant: 100.0f]];
    }
    
    {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.iconImageView
                                                                     attribute: NSLayoutAttributeTop
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.corneredView
                                                                     attribute: NSLayoutAttributeTop
                                                                    multiplier: 1.0
                                                                      constant: 15.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.iconImageView
                                                                     attribute: NSLayoutAttributeCenterX
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.corneredView
                                                                     attribute: NSLayoutAttributeCenterX
                                                                    multiplier: 1.0
                                                                      constant: 0.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.iconImageView
                                                                     attribute: NSLayoutAttributeWidth
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: nil
                                                                     attribute: NSLayoutAttributeNotAnAttribute
                                                                    multiplier: 1.0
                                                                      constant: 24.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.iconImageView
                                                                     attribute: NSLayoutAttributeHeight
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: nil
                                                                     attribute: NSLayoutAttributeNotAnAttribute
                                                                    multiplier: 1.0
                                                                      constant: 24.0f]];
    }
    
    {
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.label
                                                                     attribute: NSLayoutAttributeTop
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.iconImageView
                                                                     attribute: NSLayoutAttributeBottom
                                                                    multiplier: 1.0
                                                                      constant: 10.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.label
                                                                     attribute: NSLayoutAttributeCenterX
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.corneredView
                                                                     attribute: NSLayoutAttributeCenterX
                                                                    multiplier: 1.0
                                                                      constant: 0.0f]];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem: self.label
                                                                     attribute: NSLayoutAttributeWidth
                                                                     relatedBy: NSLayoutRelationEqual
                                                                        toItem: self.corneredView
                                                                     attribute: NSLayoutAttributeWidth
                                                                    multiplier: 1.0
                                                                      constant: 0.0f]];
    }
    
    
}

@end
