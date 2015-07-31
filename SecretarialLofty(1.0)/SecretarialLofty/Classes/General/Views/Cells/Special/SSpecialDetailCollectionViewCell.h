//
//  SSpecialDetailCollectionViewCell.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialDetailModel.h"
@interface SSpecialDetailCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *eesImageView;//二级页面cell的图片
@property(nonatomic,strong)UILabel *eesTitleLabel;//二级页面cell的标题
@property(nonatomic,strong)UILabel *eesPlayAmountLabel;//二级页面cell的点击量
@property(nonatomic,strong)UIButton *scollectButton;

@property(nonatomic,strong)SpecialDetailModel *sdm;

@end
