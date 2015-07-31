//
//  SpecialDetailTableViewController.m
//  SecretarialLofty
//
//  Created by SecretarialLofty on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//



#import "SpecialDetailTableViewController.h"
#import "SpecialDetailTableViewCell.h"
#import "AsyNetWorkTools.h"
#import "Reachability.h"
#import "AMTumblrHud.h"
#import "SpecialDetailModel.h"
#import "UIImageView+WebCache.h"
#import "SpecialTableViewController.h"
#import "SSpecialDetailViewController.h"
#import "SSpecialDetailCollectionViewCell.h"
#import "MJRefresh.h"
#import "CategoriesDBHelper.h"

#define eURL @"http://preapp.ximalaya.com/explore/943/subject/%@?version=1.0.2&device=android"
#define kCellIdentifier @"cell"

@interface SpecialDetailTableViewController ()<AsyNetWorkToolDelegate>
{
    
}

@property(strong,nonatomic)UIImageView*eThemeImageView;//二级页面的主题图片
@property(strong,nonatomic)UILabel*eTitleLabel;//二级页面主题
@property(strong,nonatomic)UILabel*eIntroductLabel;//二级页面主题简介
@property(strong,nonatomic)AMTumblrHud *amTumb;
@property(strong,nonatomic)NSString *eThemeImageName;
@property(strong,nonatomic)NSString *eTitle;
@property(strong,nonatomic)NSString *eIntroduct;
@property(strong,nonatomic)NSMutableArray *requestArray;
@property(strong,nonatomic)NSMutableArray *idArray;
@property(strong,nonatomic)UIBarButtonItem *right;
@property(strong,nonatomic)Reachability *reach;

@end

@implementation SpecialDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerClass:[SpecialDetailTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    
    self.reach = [Reachability reachabilityForInternetConnection];
    
    // 设置导航栏左右按钮图片
    UIImage *selectedImage=[UIImage imageNamed:@"left"];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:selectedImage style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
    self.navigationItem.leftBarButtonItem=left;
    self.right=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_nav_collection"] style:UIBarButtonItemStylePlain target:self action:@selector(doVariety)];
    self.navigationItem.rightBarButtonItem=self.right;

    
    self.amTumb = [[AMTumblrHud alloc] initWithFrame:CGRectMake((CGFloat) ((self.view.frame.size.width - 55) * 0.5),
                                                                (CGFloat) ((self.view.frame.size.height - 20) * 0.5), 55, 20)];
    self.amTumb.hudColor = [UIColor orangeColor];
    [self.view addSubview:self.amTumb];
    
    
    [self addHeader];
    [self addFooter];
    
}

-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)doVariety
{
    SSpecialDetailViewController *sspecialC=[[SSpecialDetailViewController alloc]init];
     //传值
    sspecialC.reciveArray=self.requestArray;
    sspecialC.iDArrAy=self.idArray;
    sspecialC.esThemeImageName=self.eThemeImageName;
    sspecialC.esTitle=self.eTitle;
    sspecialC.esIntroduct=self.eIntroduct;
    
    [self.navigationController pushViewController:sspecialC animated:YES];

}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =NO;
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [self requestDataWithUrl:[NSString stringWithFormat:eURL,[user valueForKey:@"SubjectId"]]];

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

-(NSMutableArray *)requestArray
{
    if (_requestArray==nil) {
        _requestArray=[[NSMutableArray alloc]init];
    }
    return _requestArray;
}

-(NSMutableArray *)idArray
{
    if (_idArray==nil) {
        _idArray=[[NSMutableArray alloc]init];
    }
    return _idArray;
}


-(void)requestDataWithUrl:(NSString *)url

{
    if (self.reach.isReachable) {
        AsyNetWorkTools *tool=[[AsyNetWorkTools alloc]initWithString:url];
        tool.delegate=self;
        [self.amTumb showAnimated:YES];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络连接,请检查后网络后再操作" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}


-(void)asyResult:(id)result
{
    NSError *error=nil;
    NSDictionary *dataDic=[NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:&error];
    //主题
    NSDictionary *tdic=[[NSDictionary alloc]init];
    tdic=[dataDic objectForKey:@"info"];
    self.eThemeImageName=[NSString stringWithString:[tdic valueForKey:@"coverPathBig"]];
    self.eTitle=[NSString stringWithString:[tdic valueForKey:@"title"]];
    self.eIntroduct=[NSString stringWithString:[tdic valueForKey:@"intro"]];
    //书类
    NSArray *arr=[[NSArray alloc]init];
    NSString *ids=[[NSString alloc]init];
    arr=[dataDic objectForKey:@"list"];
    for (NSDictionary *dic in arr) {
        SpecialDetailModel *sdm=[[SpecialDetailModel alloc]init];
        sdm.eeTitle=[dic valueForKey:@"title"];
        sdm.eeImageName=[dic valueForKey:@"coverSmall"];
        sdm.eePlayAmount=[NSString stringWithFormat:@"播放次数: %@",[NSString stringWithFormat:@"%@",[dic valueForKey:@"playsCounts"]]];
        [self.requestArray addObject:sdm];
        
        ids=[dic valueForKey:@"id"];
        [self.idArray addObject:ids];
        
    }
    [self.amTumb showAnimated:NO];
    [self.tableView reloadData];
    [self addHeadView];
}




#pragma mark - Table view data source

/*cell的头视图设置*/

-(void)addHeadView
{
    //主题图片
    NSURL *url=[NSURL URLWithString:self.eThemeImageName];
    [self.eThemeImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"bg_01"]];
    //self.eThemeImageView.backgroundColor=[UIColor brownColor];
    //添加边框
    _eThemeImageView.layer.borderColor=[UIColor whiteColor].CGColor;
    _eThemeImageView.layer.borderWidth=5;
    _eThemeImageView.layer.cornerRadius=30;
    _eThemeImageView.layer.masksToBounds=YES;

    //主题
    self.eTitleLabel.text=self.eTitle;
    [self.eTitleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    self.eTitleLabel.textAlignment=NSTextAlignmentCenter;//居中
   
    //主题简介
    self.eIntroductLabel.text=self.eIntroduct;
    self.eIntroductLabel.numberOfLines=0;//可多行显示
    self.eIntroductLabel.lineBreakMode=NSLineBreakByWordWrapping;//换行
    self.eIntroductLabel.contentMode=UIViewContentModeTopLeft;
    self.eIntroductLabel.font=[UIFont systemFontOfSize:12];//设置字体大小
    self.eIntroductLabel.frame = CGRectMake(20, 190, [UIScreen mainScreen].bounds.size.width - 40, 160);
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 350)];
    [headerView addSubview:self.eThemeImageView];
    [headerView addSubview:self.eTitleLabel];
    [headerView addSubview:self.eIntroductLabel];
    
    self.tableView.tableHeaderView=headerView;

}


#pragma mark - 设置每个分组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.requestArray.count;
}

#pragma mark - 设置每行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SpecialDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    SpecialDetailModel *sDM=[self.requestArray objectAtIndex:indexPath.row];
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithString:sDM.eeImageName]];
    [cell.eeImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"bg_01"]];
    cell.eeTitleLabel.text=sDM.eeTitle;
    cell.eePlayAmountLabel.text=sDM.eePlayAmount;
    cell.collectButton.tag = indexPath.row;

    [cell.collectButton addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark-设置cell的高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)collectButtonAction:(UIButton *)sender
{
//    [self.idArray[indexPath.row] integerValue]
 
    SpecialDetailModel *specialM = [self.requestArray objectAtIndex:sender.tag];
    
    NSInteger b = [self.idArray[sender.tag] integerValue];
    BOOL a = [[CategoriesDBHelper categoriesDBHepler]selectDataWithID:b];
    NSLog(@"%d", a);
    if (!a) {
        [[CategoriesDBHelper categoriesDBHepler] insertCategories:b AndTitle:specialM.eeTitle];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已收藏" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }

}

#pragma mark - 设置cell点击跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonTableViewController *specialDetailTC = [CommonTableViewController new];

    specialDetailTC.albumStr = [self.idArray[indexPath.row] integerValue];
     self.tabBarController.tabBar.hidden = YES;
          
    [self.navigationController pushViewController:specialDetailTC animated:YES];
}

/*上拉加载*/
-(void)addFooter
{
    
    __weak SpecialDetailTableViewController *testVC=self;
    [self.tableView addFooterWithCallback:^{
        [testVC footData];
    }];
}


-(void)footData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView  footerEndRefreshing];
    });
}
/*下拉刷新*/
-(void)addHeader
{
    __weak SpecialDetailTableViewController *testVC=self;
    [self.tableView addHeaderWithCallback:^{
        [testVC headerData];
    }];
}

-(void)headerData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self addHeadView];
        [self.tableView  headerEndRefreshing];
    });;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
