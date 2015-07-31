//
//  RecommendEditorTableViewCell.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "RecommendEditorTableViewCell.h"
#import "Recommend_Editer.h"
#import "UIButton+WebCache.h"

@interface RecommendEditorTableViewCell ()

@property (nonatomic, retain) LBWCellHeaderView *headerView;

@end

@implementation RecommendEditorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width + 50, 200);
        [self addAllViews];
    }
    return self;
}

#pragma mark - 自定义方法
#pragma mark addAllViews
- (void)addAllViews
{
    self.detailButtons = [NSMutableArray array];
    self.detailTitles = [NSMutableArray array];
    
    // 循环数组，追加图片及title
    for (int i = 0; i < 3; i++) {
        
        // 使用自定义view追加头部信息
        self.headerView = [[LBWCellHeaderView alloc] initWithFrame:CGRectMake(10, 5, kScreenSize.width, 35)];
        
        [self.contentView addSubview:_headerView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        button.frame = CGRectMake(2 + (i * kScreenSize.width / 3.0),
//                                  self.headerView.frame.origin.y * 2 + self.headerView.frame.size.height,
//                                  (kScreenSize.width / 3.0 - 4),
//                                  kScreenSize.height - (self.headerView.frame.origin.y * 2 + self.headerView.frame.size.height + 35));
        
        button.frame = CGRectMake(2 + (i * [UIScreen mainScreen].bounds.size.width / 3), self.headerView.frame.origin.y * 2 + self.headerView.frame.size.height, ([UIScreen mainScreen].bounds.size.width / 3) - 4, kScreenSize.height - (self.headerView.frame.origin.y * 2 + self.headerView.frame.size.height + 35));
        
        // 设置圆角
        button.layer.cornerRadius = 20;
        button.clipsToBounds = YES;
        // 设置边框
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        button.layer.borderWidth = 4;
        button.layer.masksToBounds = YES;
        
        [_detailButtons addObject:button];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 + (i * [UIScreen mainScreen].bounds.size.width / 3.0),button.frame.origin.y + button.frame.size.height,button.frame.size.width,35)];
        
        [_detailTitles addObject:titleLabel];
        
        [self.contentView addSubview:button];
        [self.contentView addSubview:titleLabel];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImages:(NSArray *)images
{
    if (_images != images) {
        _images = nil;
        _images = images;
        
        // 循环数组，追加图片及title
        for (int i = 0; i < 3; i++) {
            
            Recommend_Editer *ditor = images[i];
            
            // 给更多按钮赋值
            self.moveButton = self.headerView.rightButton;
            _moveButton.tag = ditor.categoryId;
            
            // 获取button
            UIButton *button = _detailButtons[i];
            
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:ditor.coverLarge] forState:UIControlStateNormal];
            
            // 跳转赋值
            button.tag = ditor.albumId;
            
            // 获取titleLabel
            UILabel *titleLabel = _detailTitles[i];
            
            titleLabel.text = ditor.title;
            titleLabel.numberOfLines = 0;
            titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            
            [self.contentView addSubview:button];
            [self.contentView addSubview:titleLabel];
        }
        
    }
}

- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = nil;
        _title = [title copy];
        // 赋值
        _headerView.leftLabelText = title;
    }
}
@end