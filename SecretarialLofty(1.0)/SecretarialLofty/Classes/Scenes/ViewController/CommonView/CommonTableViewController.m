//
//  CommonTableViewController.m
//  SecretarialLofty
//
//  Created by SecretarialLofty on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "CommonTableViewController.h"
#import "CommonFileHelper.h"
#import "CommonHeaderView.h"
#import "CommonListTableViewCell.h"
#import "Album.h"
#import "MJRefresh.h"
#import "AMTumblrHud.h"
#import "CommonPlayViewController.h"
#import "CategoriesDBHelper.h"
#import "AVPlayerHelper.h"
#import "Reachability.h"

#import "Info.h"
#import "List.h"
#import "AsyNetWorkTools.h"
#import "CCommonHeaderView.h"


#define kURL @"http://preapp.ximalaya.com/explore/943/subject/%@?version=1.0.2&device=android"

#define kCellIdentifier @"Cell"
@interface CommonTableViewController ()<AsyNetWorkToolDelegate>

//大部分属性
@property (nonatomic, retain) NSArray *allDataArray;
@property (nonatomic, retain) Album *album;
@property (nonatomic, retain) AMTumblrHud *amTumb;
@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic,strong) Reachability *reach;

//小部分属性
@property(nonatomic,strong)NSMutableArray *infoarray;//存放头信息
@property(nonatomic,strong)NSMutableArray *listArray;//存放cell
@property(nonatomic,strong)Info *infoo;



@end

@implementation CommonTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pageCount = 1;
    
    [self finishView];
    [self navView];
   // [self requestData];
    /*
//    __weak typeof (self) weakSelf = self;
//   // __block CommonTableViewController *blockSelf = self;
//     self.reach = [Reachability reachabilityForInternetConnection];
//    
//    // 获取网络数据
//  if (self.reach.isReachable) {
//     [self.amTumb showAnimated:YES];
//    [[CommonFileHelper sharedCommonFileHelper] readerCommonFileWithAlbum:[NSString stringWithFormat:@"%ld", (long)self.albumStr] pageCount:_pageCount  success:^(id obj, NSArray *tracks) {
//         [weakSelf.amTumb showAnimated:NO];
//        // 自定义表头
//        weakSelf.tableView.tableHeaderView = [[CommonHeaderView alloc] initWithFrame:CGRectMake(0, 0, weakSelf.view.frame.size.width, 300) andAlbum:obj];
//        // 将获取到得数据保存到数组中
//        _allDataArray = tracks;
//        weakSelf.album = obj;
//        [weakSelf finishView];
//        // 重新加载tableview
//        [weakSelf.tableView reloadData];
//        // 设置头标题
//        weakSelf.title = self.album.title;
//       
//    }];
//      
//  }
//  else
//  {
//     //
//      UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络连接,请检查后网络后再操作" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//      [alert show];
//  }
     */
     
/*
//    // 设置导航栏左侧按钮图片
//    self.navigationItem.leftBarButtonItem = ({
//        UIImage *selectedImage=[UIImage imageNamed: @"left.png"];
//        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
//        leftBtn;
//    });
//
//    // 设置导航栏右侧收藏按钮图片
//    self.navigationItem.rightBarButtonItem = ({
//        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"navCollect.png"] style:UIBarButtonItemStylePlain target:self action:@selector(collectButtonAction:)];
//        rightBtn;
//
//    });
//  */
    // 注册Cell
    [self.tableView registerClass:[CommonListTableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    self.reach = [Reachability reachabilityForInternetConnection];
    
    [self addHeader];
    [self addFooter];
 /*
//    // 加载数据
//    [self.tableView addFooterWithCallback:^{
//        [weakSelf appendDataCompletionHanle:^{
//            [weakSelf.tableView footerEndRefreshing];
//        }];
//    }];
  */
}

#pragma mark-判断来自哪个页面
-(void)viewWillAppear:(BOOL)animated
{
    if (self.panduan==1) {
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        [self requestDataWithUrl:[NSString stringWithFormat:kURL,[user valueForKey:@"SubjectId"]]];
    }
    else{
        [self requestData];
    }
}



#pragma mark - 刷新效果
- (void)finishView
{
    self.amTumb = [[AMTumblrHud alloc] initWithFrame:CGRectMake((CGFloat) ((self.view.frame.size.width - 55) * 0.5), (CGFloat) ((self.view.frame.size.height - 20) * 0.5), 55, 20)];
    self.amTumb.hudColor = [UIColor orangeColor];
    [self.view addSubview:self.amTumb];
    [self.amTumb showAnimated:NO];
}


#pragma mark-视图添加
/**
 *  导航栏
 */
-(void)navView
{
    // 设置导航栏左侧按钮图片
    self.navigationItem.leftBarButtonItem = ({
        UIImage *selectedImage=[UIImage imageNamed: @"left.png"];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
        leftBtn;
    });
    
    // 设置导航栏右侧收藏按钮图片
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed: @"navCollect.png"] style:UIBarButtonItemStylePlain target:self action:@selector(collectButtonAction:)];
        rightBtn;
        
    });
}

/**zzz
 *  表头
 */
-(void)addHeaderView
{
    // 自定义表头
    self.tableView.tableHeaderView = [[CCommonHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300) andInfo:_infoo];
    self.title = self.infoo.cctitle;
}
#pragma mark-懒加载
/**
 *  头
 */
-(NSMutableArray *)infoarray
{
    if(_infoarray==nil){
        _infoarray=[[NSMutableArray alloc]init];
    }
    return _infoarray;
}

/**
 *  cell
 */
-(NSMutableArray *)listArray
{
    if (_listArray==nil) {
        _listArray=[[NSMutableArray alloc]init];
    }
    return _listArray;
}



#pragma mark-大部分页面数据请求解析

-(void)requestData
{
    __weak typeof (self) weakSelf = self;
    // 获取网络数据
    if (self.reach.isReachable) {
        [self.amTumb showAnimated:YES];
        [[CommonFileHelper sharedCommonFileHelper] readerCommonFileWithAlbum:[NSString stringWithFormat:@"%ld", (long)self.albumStr] pageCount:_pageCount  success:^(id obj, NSArray *tracks) {
            [weakSelf.amTumb showAnimated:NO];
            // 自定义表头
            weakSelf.tableView.tableHeaderView = [[CommonHeaderView alloc] initWithFrame:CGRectMake(0, 0, weakSelf.view.frame.size.width, 300) andAlbum:obj];
            // 将获取到得数据保存到数组中
            _allDataArray = tracks;
            weakSelf.album = obj;
            [weakSelf finishView];
            // 重新加载tableview
            [weakSelf.tableView reloadData];
            // 设置头标题
            weakSelf.title = self.album.title;
            
        }];
        
    }
    else
    {
        //
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络连接,请检查后网络后再操作" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    // 加载数据
    [self.tableView addFooterWithCallback:^{
        [weakSelf appendDataCompletionHanle:^{
            [weakSelf.tableView footerEndRefreshing];
        }];
    }];
}

#pragma mark-小部分页面

#pragma mark-数据请求解析
/**
 *  网络请求
 */
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
    NSDictionary *infoDic=[[NSDictionary alloc]init];
    infoDic=[dataDic objectForKey:@"info"];
    _infoo=[[Info alloc]init];
    _infoo.ccsubjectId=[[infoDic objectForKey:@"subjectId"] integerValue] ;
    _infoo.ccoverPathBig=[infoDic objectForKey:@"coverPathBig"];
    _infoo.ccintro=[infoDic objectForKey:@"intro"];
    _infoo.cctitle=[infoDic objectForKey:@"title"];
    [self.infoarray addObject:_infoo];
    //cell
    NSArray *listArr=[NSArray array];
    listArr=[dataDic objectForKey:@"list"];
    for (NSDictionary *dic in listArr) {
        List *llist=[[List alloc]init];
        llist.cctitle=[dic objectForKey:@"title"];
        llist.ccnickname=[dic objectForKey:@"nickname"];
        llist.ccduration=[dic objectForKey:@"duration"];
        llist.ccoverSmall=[dic objectForKey:@"coverSmall"];
        llist.ccplayPath64=[dic objectForKey:@"playPath64"];
        llist.ccalbumTitle=[dic objectForKey:@"albumTitle"];
        llist.ccoverLarge=[dic objectForKey:@"coverLarge"];
        [self.listArray addObject:llist];
    }
    [self.amTumb showAnimated:NO];
    [self.tableView reloadData];
    [self addHeaderView];
}

#pragma mark - 点击收藏方法
- (void)collectButtonAction:(UIBarButtonItem *)sender
{
    
    if(self.panduan==1)
    {
        Info *infoM = [Info new];
        
        infoM = [_infoarray objectAtIndex:sender.tag];
        
        BOOL a = [[CategoriesDBHelper categoriesDBHepler]selectDataWithID:(NSInteger)infoM.ccsubjectId];
        // NSLog(@"%d", a);
        if (!a) {
            [[CategoriesDBHelper categoriesDBHepler] insertCategories:(NSInteger)infoM.ccsubjectId AndTitle:infoM.cctitle];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已收藏" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    }
    else{
        BOOL a = [[CategoriesDBHelper categoriesDBHepler]selectDataWithID:_album.albumId];
        NSLog(@"%d", a);
        if (!a) {
            [[CategoriesDBHelper categoriesDBHepler] insertCategories:_album.albumId AndTitle:_album.title];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已收藏" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    
}
#pragma mark - 刷新事件
- (void)appendDataCompletionHanle:(void (^)())comletionHandle
{
    _pageCount++;
    [[CommonFileHelper sharedCommonFileHelper] readerCommonFileWithAlbum:[NSString stringWithFormat:@"%ld", (long)self.albumStr] pageCount:_pageCount success:^(id obj, NSArray *tracks) {
        
        _allDataArray = tracks;
        [self finishView];
        [self.tableView reloadData];
        comletionHandle();
    }];
}

#pragma mark - 返回按钮点击事件
- (void)backAction:(UIBarButtonItem *)sender
{
    // 返回到前一个页面
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.panduan==1) {
        return _listArray.count;
    }
    else{
    return _allDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    if (self.panduan==1)
    {
        List *list = self.listArray[indexPath.row];
        // 设置图片
        cell.imageURL = list.ccoverSmall;
        // 设置标题
        cell.titleValue = list.cctitle;
        // 设置播放时长
        cell.timerCount = [list.ccduration integerValue];
        // 设置作者
        cell.authorName = list.ccnickname;
        // 设置按钮点击事件
        cell.bButton.tag = indexPath.row + 1;
        // 设置track标示
        list.Tag = indexPath.row;
        
        // 判断当前播放的歌曲是否相同
        if ([[AVPlayerHelper sharedAVPlayerHelper] playerState] &&
            [list.ccplayPath64 isEqualToString:[AVPlayerHelper sharedAVPlayerHelper].playerURL])
        {
            
            // 将cellButton的tag值赋给tag属性
            _tag = cell.bButton.tag;
        }
    }
    else
    {
        Track *track = _allDataArray[indexPath.row];
        
        // 设置图片
        cell.imageURL = track.coverSmall;
        // 设置标题
        cell.titleValue = track.title;
        // 设置播放时长
        cell.timerCount = track.duration;
        // 设置作者
        cell.authorName = track.nickname;
        // 设置按钮点击事件
        cell.bButton.tag = indexPath.row;
        // 设置track标示
        track.Tag = indexPath.row;
        //[cell.bButton addTarget:self action:@selector(rotate:) forControlEvents:UIControlEventTouchUpInside];
        
        // 判断当前播放的歌曲是否相同
        if ([[AVPlayerHelper sharedAVPlayerHelper] playerState] &&
            [track.playUrl64 isEqualToString:[AVPlayerHelper sharedAVPlayerHelper].playerURL])
        {
            
            // 将cellButton的tag值赋给tag属性
            _tag = cell.bButton.tag;
           // [self rotate:cell.bButton andState:flag];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonPlayViewController *playViewController = [[CommonPlayViewController alloc] init];
    if (self.panduan==1)
    {
        List *listObj = _listArray[indexPath.row];
        // 将播放列表保存到AVPlayerHelper中
        [AVPlayerHelper sharedAVPlayerHelper].allDataArray = [NSArray arrayWithArray:_listArray];
//        CommonPlayViewController *playViewController = [[CommonPlayViewController alloc] init];
        // 传值
        playViewController.listObj = listObj;
        playViewController.briefTextValue = self.infoo.ccintro;
        playViewController.tag = listObj.Tag;
        playViewController.panduan = 1;
    }
    
    else
    {
        Track *trackObj = _allDataArray[indexPath.row];
        // 将播放列表保存到AVPlayerHelper中
        [AVPlayerHelper sharedAVPlayerHelper].allDataArray = [NSArray arrayWithArray:_allDataArray];
//        CommonPlayViewController *playViewController = [[CommonPlayViewController alloc] init];
        // 传值
        playViewController.trackObj = trackObj;
        playViewController.briefTextValue = self.album.intro;
        playViewController.tag = indexPath.row;
   }
    // 跳转
    [self presentViewController:playViewController animated:YES completion:nil];
}
    
    
/*上拉加载*/
-(void)addFooter
{
    
    __weak CommonTableViewController *testVC=self;
    [self.tableView addFooterWithCallback:^{
        [testVC footData];
    }];
}


-(void)footData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.tableView  footerEndRefreshing];
    });;
}
/*下拉刷新*/
-(void)addHeader
{
    __weak CommonTableViewController *testVC=self;
    [self.tableView addHeaderWithCallback:^{
        [testVC headerData];
    }];
}

-(void)headerData
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self addHeaderView];
        [self.tableView  headerEndRefreshing];
    });;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end