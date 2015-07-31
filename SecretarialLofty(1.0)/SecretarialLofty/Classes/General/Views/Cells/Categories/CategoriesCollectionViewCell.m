//
//  CategoriesCollectionViewCell.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "CategoriesCollectionViewCell.h"

@implementation CategoriesCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addAllView];
    }
    return self;
}

- (void)addAllView
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 20, 20)];
    
    [self addSubview: _imageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 2, 100, 20)];
    [self addSubview:_nameLabel];
    
    
}

@end
