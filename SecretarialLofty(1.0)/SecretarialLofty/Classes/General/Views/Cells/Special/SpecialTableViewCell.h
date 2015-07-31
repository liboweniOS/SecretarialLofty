//
//  SpecialTableViewCell.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialModel.h"
@interface SpecialTableViewCell : UITableViewCell

@property(strong,nonatomic)UIImageView*yImageView;//一级页面图片
@property(strong,nonatomic)UILabel*yTitleLabel;//一级页面标题


@property(strong,nonatomic)SpecialModel*sm;

@end
