//
//  SSpecialDetailViewController.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/13.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "SSpecialDetailViewController.h"
#import "SpecialTableViewController.h"
#import "SpecialDetailModel.h"
#import "SSpecialDetailCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "CategoriesDBHelper.h"

@interface SSpecialDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    UICollectionView *collectionView1;
}

@property(strong,nonatomic)UIImageView*eThemeImageView;//二级页面的主题图片
@property(strong,nonatomic)UILabel*eTitleLabel;//二级页面主题
@property(strong,nonatomic)UILabel*eIntroductLabel;//二级页面主题简介


@end

@implementation SSpecialDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //导航栏左右按钮
    UIImage *selectedImage=[UIImage imageNamed:@"left"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(doProject)];
    self.navigationItem.leftBarButtonItem=leftItem;
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_nav_list"] style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
    self.navigationItem.rightBarButtonItem=rightItem;
    //布局
    [self layoutCollectionView];
    
    [self addHeadView];
    [self addHeader];
    [self addFooter];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =NO;
}

-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)doProject
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)layoutCollectionView
{
    //创建view的布局类
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    //列间距
    flowLayout.minimumInteritemSpacing=15;
    //行边距
    flowLayout.minimumLineSpacing=20;
    //滚动方向
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //外边距
    flowLayout.sectionInset=UIEdgeInsetsMake(10, 30, 30, 30);

    flowLayout.headerReferenceSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, 350);
    
    /************************创建collectionView*****************************/
    collectionView1=[[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    collectionView1.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_01.png"]];;
    
    [self.view addSubview:collectionView1];
    //代理
    collectionView1.delegate=self;
    collectionView1.dataSource=self;
    
    //注册cell
    [collectionView1 registerClass:[SSpecialDetailCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}


//懒加载
-(UIImageView *)eThemeImageView
{
    if (_eThemeImageView!=nil)
    {
        return _eThemeImageView;
    }
    _eThemeImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 160)];
    return _eThemeImageView;
}

-(UILabel *)eTitleLabel
{
    if (_eTitleLabel!=nil) {
        return _eTitleLabel;
    }
    _eTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 160, [UIScreen mainScreen].bounds.size.width, 30)];
    return _eTitleLabel;
}

-(UILabel *)eIntroductLabel
{
    if (_eIntroductLabel!=nil) {
        return _eIntroductLabel;
    }
    _eIntroductLabel=[[UILabel alloc]init];
    return _eIntroductLabel;
}

-(NSArray *)reciveArray
{
    if (_reciveArray==nil) {
        _reciveArray=[[NSArray alloc]init];
    }
    return _reciveArray;
}

-(NSArray *)iDArrAy
{
    if (_iDArrAy==nil) {
        _iDArrAy=[[NSArray alloc]init];
    }
    return _iDArrAy;
}

/*cell的头视图设置*/

-(void)addHeadView
{
    //主题图片
    NSURL *url=[NSURL URLWithString:self.esThemeImageName];
    [self.eThemeImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"bg_01"]];
    //self.eThemeImageView.backgroundColor=[UIColor brownColor];
    //添加边框
    _eThemeImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    _eThemeImageView.layer.borderWidth=5;
    _eThemeImageView.layer.cornerRadius=30;
    _eThemeImageView.layer.masksToBounds=YES;
    
    //主题
    self.eTitleLabel.text=self.esTitle;
    [self.eTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    self.eTitleLabel.textAlignment=NSTextAlignmentCenter;//居中
    
    //主题简介
    self.eIntroductLabel.text=self.esIntroduct;
    self.eIntroductLabel.numberOfLines=0;//可多行显示
    self.eIntroductLabel.lineBreakMode=NSLineBreakByWordWrapping;//换行
    self.eIntroductLabel.contentMode=UIViewContentModeTopLeft;
    self.eIntroductLabel.font=[UIFont systemFontOfSize:12];//设置字体大小
    self.eIntroductLabel.frame = CGRectMake(20, 190, [UIScreen mainScreen].bounds.size.width - 40, 160);
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 350)];
    [headerView addSubview:self.eThemeImageView];
    [headerView addSubview:self.eTitleLabel];
    [headerView addSubview:self.eIntroductLabel];
    
    [collectionView1 addSubview:headerView];
    
}







#pragma mark-显示集合视图有多少个item的方法(必须执行)
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.reciveArray.count;
}

#pragma mark-对集合视图自定义item设置的方法（必须执行
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SSpecialDetailCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    SpecialDetailModel *sdm=[self.reciveArray objectAtIndex:indexPath.item];
    
    NSURL *url=[NSURL URLWithString:sdm.eeImageName];
    [cell.eesImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"bg_01"]];
    cell.eesTitleLabel.text=sdm.eeTitle ;
    cell.eesPlayAmountLabel.text=sdm.eePlayAmount;
    
    cell.scollectButton.tag = indexPath.row;
    
    [cell.scollectButton addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
}

- (void)collectButtonAction:(UIButton *)sender
{
    //    [self.idArray[indexPath.row] integerValue]
    
    SpecialDetailModel *specialM = [self.reciveArray objectAtIndex:sender.tag];
    
    NSInteger b = [self.iDArrAy[sender.tag] integerValue];
    BOOL a = [[CategoriesDBHelper categoriesDBHepler]selectDataWithID:b];
    NSLog(@"%d", a);
    if (!a) {
        [[CategoriesDBHelper categoriesDBHepler] insertCategories:b AndTitle:specialM.eeTitle];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已收藏" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}


#pragma mark-设置每个item大小的方法
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((([UIScreen mainScreen].bounds.size.width-90)/2), 190);
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommonTableViewController *specialDetailTC = [CommonTableViewController new];
    
    specialDetailTC.albumStr = [self.iDArrAy[indexPath.item] integerValue];
     self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController pushViewController:specialDetailTC animated:YES];
}


/*上拉加载*/
-(void)addFooter
{
    
    __weak SSpecialDetailViewController *testVC=self;
    [collectionView1 addFooterWithCallback:^{
        [testVC footData];
    }];
}


-(void)footData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [collectionView1 reloadData];
        [collectionView1  footerEndRefreshing];
    });
}
/*下拉刷新*/
-(void)addHeader
{
    __weak SSpecialDetailViewController *testVC=self;
    [collectionView1 addHeaderWithCallback:^{
        [testVC headerData];
    }];
}

-(void)headerData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [collectionView1 reloadData];
        [self addHeadView];
        [collectionView1  headerEndRefreshing];
    });;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
