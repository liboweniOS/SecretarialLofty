//
//  Adaptive.m
//  SecretarialLofty
//
//  Created by 康辰 on 15/7/16.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "Adaptive.h"

@implementation Adaptive

- (void)adaptiveWithSuperView:(UIView *)superView
                      subView:(UIView *)subView
{
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:superView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
}


@end
