//
//  UIView+AddConstraint.m
//  SecretarialLofty
//
//  Created by 康辰 on 15/7/16.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "UIView+AddConstraint.h"

@implementation UIView (AddConstraint)

- (void)addConstraintWithSuperView:(UIView *)superView
                    constrainStyle:(ConstrainStyle)constrainStyle
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
}

@end
