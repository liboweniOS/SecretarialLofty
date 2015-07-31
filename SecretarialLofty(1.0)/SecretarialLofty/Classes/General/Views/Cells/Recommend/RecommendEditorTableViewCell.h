//
//  RecommendEditorTableViewCell.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/10.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendEditorTableViewCell : UITableViewCell

@property (nonatomic, retain) NSMutableArray *detailButtons;

@property (nonatomic, retain) NSMutableArray *detailTitles;

@property (nonatomic, retain) NSArray *images;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, retain) UIButton *moveButton;

@end
