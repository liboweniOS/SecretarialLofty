//
//  List.h
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/21.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayListModel.h"

@interface List :PlayListModel

@property (nonatomic, copy) NSString *cctitle;
@property (nonatomic, copy) NSString *ccnickname;
@property (nonatomic, copy) NSString *ccduration;
@property (nonatomic, copy) NSString *ccalbumTitle;
@property (nonatomic, copy) NSString *ccoverSmall;
@property (nonatomic, copy) NSString *ccoverLarge;
@property (nonatomic, copy) NSString *ccplayPath64;

// tag标示
@property (nonatomic, assign) NSInteger Tag;

@end
