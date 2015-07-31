//
//  SpecialDetailTableViewCell.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialDetailModel.h"


@interface SpecialDetailTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *eeImageView;//二级页面cell的图片
@property(nonatomic,strong)UILabel *eeTitleLabel;//二级页面cell的标题
@property(nonatomic,strong)UILabel *eePlayAmountLabel;//二级页面cell的点击量
@property(nonatomic,strong)UIButton *collectButton;



@property(nonatomic,strong)SpecialDetailModel *sdm;

@end
