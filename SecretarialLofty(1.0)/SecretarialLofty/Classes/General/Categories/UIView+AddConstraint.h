//
//  UIView+AddConstraint.h
//  SecretarialLofty
//
//  Created by 康辰 on 15/7/16.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AddConstraint)

typedef enum {
    CONSTRAINSTYLEDEFAULT = 0
} ConstrainStyle;

@end
@interface AddConstraint : UIView

- (void)addConstraintWithSuperView:(UIView *)superView
                    constrainStyle:(ConstrainStyle)constrainStyle;


@end
