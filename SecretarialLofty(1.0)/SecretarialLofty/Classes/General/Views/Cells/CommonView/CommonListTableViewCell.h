//
//  CommonListTableViewCell.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/11.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonListTableViewCell : UITableViewCell

@property (nonatomic, retain) UIButton *bButton;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *titleValue;
@property (nonatomic, assign) NSInteger timerCount;
@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, retain) UIButton *skipButton;

@end
