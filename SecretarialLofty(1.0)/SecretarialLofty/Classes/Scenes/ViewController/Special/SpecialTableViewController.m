//
//  SpecialTableViewController.m
//  SecretarialLofty
//
//  Created by SecretarialLofty on 15/7/8.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//



#import "SpecialTableViewController.h"
#import "SpecialDetailTableViewController.h"
#import "SpecialTableViewCell.h"
#import "SpecialModel.h"
#import "AsyNetWorkTools.h"
#import "UIImageView+WebCache.h"
#import "Reachability.h"
#import "AMTumblrHud.h"
#import "MJRefresh.h"


#define yURL @"http://preapp.ximalaya.com/explore/943/subjects/?version=1.0.2&device=android&page_id=%d&per_page=10"

#define kCellIdentifier @"cell"

@interface SpecialTableViewController ()<AsyNetWorkToolDelegate,UIAlertViewDelegate>
{
   // BOOL TF;
    int pageid;
    int page;
}
@property(strong,nonatomic)NSMutableArray *requestArray;//cell的数据
@property(strong,nonatomic)Reachability *reach;
@property(strong,nonatomic)AMTumblrHud *amTumb;//活动指示器
@property(strong,nonatomic)NSMutableArray *contentTypeArray;//根据此判断进入哪个页面
@property(strong,nonatomic)NSMutableArray *subjectidArray;

@end

@implementation SpecialTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"专题";
    
    self.reach = [Reachability reachabilityForInternetConnection];

    //cell注册
    [self.tableView registerClass:[SpecialTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    
    self.amTumb = [[AMTumblrHud alloc] initWithFrame:CGRectMake((CGFloat) ((self.view.frame.size.width - 55) * 0.5), (CGFloat) ((self.view.frame.size.height - 20) * 0.5), 55, 20)];
    self.amTumb.hudColor = [UIColor orangeColor];
    [self.view addSubview:self.amTumb];
    [self requsetDataWithURL:[NSString stringWithFormat:yURL,page=1]];
    [self addHeader];
    [self addFooter];
   
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =NO;
}

//懒加载
-(NSMutableArray *)requestArray
{
    if (_requestArray==nil) {
        _requestArray=[[NSMutableArray alloc]init];
    }
    return _requestArray;
}

-(NSMutableArray *)subjectidArray
{
    if (_subjectidArray==nil) {
        _subjectidArray=[[NSMutableArray alloc]init];
    }
    return _subjectidArray;
}
-(NSMutableArray *)contentTypeArray
{
    if (_contentTypeArray==nil) {
        _contentTypeArray=[[NSMutableArray alloc]init];
    }
    return _contentTypeArray;
}


- (void)requsetDataWithURL:(NSString *)url
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

- (void)asyResult:(id)result
{
    NSError *error=nil;
    //[self.requestArray removeAllObjects];
    NSDictionary *dataDic=[NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:&error];
    NSArray *arr=[[NSArray alloc]init];
    arr=[dataDic objectForKey:@"list"];
    NSString *subjectid=[[NSString alloc]init];
    NSString *contentTy=[[NSString alloc]init];
    for (NSDictionary *dic in arr) {
        SpecialModel *spM=[[SpecialModel alloc]init];
        spM.yimageName=[dic valueForKey:@"coverPathBig"];
        spM.ytitle=[dic valueForKey:@"title"];
        [self.requestArray addObject:spM];
        
        subjectid=[dic valueForKey:@"subjectId"];
        [self.subjectidArray addObject:subjectid];

        contentTy=[NSString stringWithFormat:@"%@",[dic valueForKey:@"contentType"]];
        [self.contentTypeArray addObject:contentTy];
    }
    [self.amTumb showAnimated:NO];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

#pragma mark - 设置每个分组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.requestArray.count;
}

#pragma mark-设置cell的高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}
#pragma mark - 设置每行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SpecialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    SpecialModel *special=[self.requestArray objectAtIndex:indexPath.row];
    cell.yTitleLabel.text=special.ytitle;
    NSURL *url=[NSURL URLWithString:special.yimageName];
    [cell.yImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"bg_01"]];
    return cell;
}






#pragma mark - 设置cell点击跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];//单例
    [user setObject:self.subjectidArray[indexPath.row] forKey:@"SubjectId"];

    if ([[self.contentTypeArray objectAtIndex:indexPath.row] isEqual:@"1"]) {
        SpecialDetailTableViewController *specialDetailTC = [SpecialDetailTableViewController new];
        specialDetailTC.title = @"专题";
        [self.navigationController pushViewController:specialDetailTC animated:YES];
    }
    else if ([[self.contentTypeArray objectAtIndex:indexPath.row] isEqual:@"2"])
    {
//        CCommonTableViewController *ccomm=[[CCommonTableViewController alloc]init];
        
        CommonTableViewController *ccomm=[[CommonTableViewController alloc]init];
        self.tabBarController.tabBar.hidden = YES;
        ccomm.panduan=1;
        [self.navigationController pushViewController:ccomm animated:YES];
    }
    
    
}

/*上拉加载*/
-(void)addFooter
{
    
    __weak SpecialTableViewController *testVC=self;
    [self.tableView addFooterWithCallback:^{
        [testVC footData];
    }];
}


-(void)footData
{
    page++;
    [self requsetDataWithURL:[NSString stringWithFormat:yURL,page]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView  footerEndRefreshing];
    });
}
/*下拉刷新*/
-(void)addHeader
{
    __weak SpecialTableViewController *testVC=self;
    [self.tableView addHeaderWithCallback:^{
        [testVC headerData];
    }];
}

-(void)headerData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView  headerEndRefreshing];
    });;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
