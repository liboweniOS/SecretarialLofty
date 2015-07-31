//
//  RecommendTableViewController.m
//  SecretarialLofty
//
//  Created by SecretarialLofty on 15/7/8.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "RecommendTableViewController.h"
#import "RecommendFileHelper.h"
#import "RecommendHeaderView.h"
#import "RecommendFooterView.h"
#import "RecommendEditorTableViewCell.h"
#import "SecondCategoriesViewController.h"
#import "CommonTableViewController.h"
#import "CategoriesModel.h"
#import "FocusImages.h"
#import "AMTumblrHud.h"
#import "CategoriesViewController.h"
#import "Reachability.h"


#define kCellEditorIndentifer @"EditorCell"
@interface RecommendTableViewController () <UIScrollViewDelegate>

{
    BOOL playListFlag;
}

@property (nonatomic, retain) NSDictionary *allDataArray;
@property (nonatomic, retain) RecommendHeaderView *headerView;
@property (nonatomic, retain) RecommendFooterView *footerView;
@property (nonatomic, retain) NSMutableDictionary *tableViewAllDataArray;
// 消息提示
@property (nonatomic, retain) UIAlertView *alertView;
// 更新效果对象
@property (nonatomic, retain) AMTumblrHud *amTumb;
@property(nonatomic,strong)Reachability *reach;




@end

@implementation RecommendTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐";
    
    __block typeof(self)weakSelf = self;
    
    [self finishView];
    
    //UISearchBar
    
    // 加载数据
    self.reach = [Reachability reachabilityForInternetConnection];
  if (self.reach.isReachable) {
        [self.amTumb showAnimated:YES];
        [[RecommendFileHelper sharedRecommendFileHelper] readerRecommendFile:^(id obj) {
            _allDataArray = [NSDictionary dictionaryWithDictionary:obj];
        
        [weakSelf.amTumb showAnimated:NO];
        
        _footerView = [[RecommendFooterView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 35)];
        
        _headerView = [[RecommendHeaderView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 200) andFocusImages:_allDataArray[@"focusImages"]];
        // 计时器
        [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timer) userInfo:nil repeats:YES];
        
        // 追加小点点的点击事件
        [_headerView.pageControl addTarget:self action:@selector(pageControlAction:) forControlEvents:UIControlEventTouchUpInside];
        // 给scrollview追加代理
        _headerView.scrollView.delegate = self;
        
        // 设置tableView显示内容的容器
        self.tableViewAllDataArray = [NSMutableDictionary dictionaryWithDictionary:_allDataArray];
        [_tableViewAllDataArray removeObjectForKey:@"focusImages"];
        
        weakSelf.tableView.tableHeaderView = _headerView;
        weakSelf.tableView.tableFooterView = _footerView;
    
        [_footerView.footerButton addTarget:self action:@selector(footerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        //[[RecommendFooterView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 35)];
    
        [self finishView];

        [weakSelf.tableView reloadData];
        
        // 设置焦点图点击事件
        for (UIButton *sender in _headerView.buttons) {
            [sender addTarget:self action:@selector(headerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }];
  }
  else{
      UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络连接,请检查后网络后再操作" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
      [alert show];
      
  }

    
    
    NSLog(@"%@", _tableViewAllDataArray);
    
    // 设置导航栏右侧按钮
//    self.navigationItem.rightBarButtonItem = ({
//        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navAVPlayer.png"] style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
//        rightButton;
//    });
}

#pragma mark - 刷新效果
- (void)finishView
{
    self.amTumb = [[AMTumblrHud alloc] initWithFrame:CGRectMake((CGFloat) ((self.view.frame.size.width - 55) * 0.5), (CGFloat) ((self.view.frame.size.height - 20) * 0.5), 55, 20)];
    self.amTumb.hudColor = [UIColor orangeColor];
    [self.view addSubview:self.amTumb];
    [self.amTumb showAnimated:NO];
}

- (void)footerButtonAction:(UIButton *)sender
{
    CategoriesViewController *c = [CategoriesViewController new];
    
    [self.navigationController pushViewController:c animated:YES];
}

#pragma mark - 初始化
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =NO;
    
//    // 设置导航栏播放器按钮状态
//    if ([AVPlayerHelper sharedAVPlayerHelper].allDataArray == nil || [AVPlayerHelper sharedAVPlayerHelper].allDataArray.count == 0) {
//        // 设置按钮不可用
//        self.navigationItem.rightBarButtonItem.enabled = NO;
//    } else {
//        for (Track *track in [AVPlayerHelper sharedAVPlayerHelper].allDataArray) {
//            // 判断URL
//            // 判断URL
//            if (track.playUrl64 != nil) {
//                
//                playListFlag = YES;
//                
//                if ([track.playUrl64 isEqualToString:[AVPlayerHelper sharedAVPlayerHelper].playerURL]) {
//                    // 设置按钮可用
//                    self.navigationItem.rightBarButtonItem.enabled = YES;
//                    break;
//                }
//            }else
//            {
//                playListFlag = NO;
//                
//                if ([track.ccplayPath64 isEqualToString:[AVPlayerHelper sharedAVPlayerHelper].playerURL]) {
//                    // 设置按钮可用
//                    self.navigationItem.rightBarButtonItem.enabled = YES;
//                    break;
//                }
//                
//            }
//        }
//    }
}

#pragma mark - 导航栏右侧按钮点击
//- (void)rightAction:(UIBarButtonItem *)sender
//{
//    CommonPlayViewController *playViewController = [[CommonPlayViewController alloc] init];
//    // 传值
//    
//    if (playListFlag) {
//        for (Track *track in [AVPlayerHelper sharedAVPlayerHelper].allDataArray) {
//            // 判断URL
//            if ([track.playUrl64 isEqualToString:[AVPlayerHelper sharedAVPlayerHelper].playerURL]) {
//                playViewController.trackObj = track;
//                playViewController.briefTextValue = [AVPlayerHelper sharedAVPlayerHelper].briefTextValue;
//                playViewController.tag = track.Tag;
//                break;
//            }
//        }
//    }else
//    {
//        for (List *track in [AVPlayerHelper sharedAVPlayerHelper].allDataArray) {
//            // 判断URL
//            if ([track.ccplayPath64 isEqualToString:[AVPlayerHelper sharedAVPlayerHelper].playerURL]) {
//                playViewController.listObj = track;
//                playViewController.briefTextValue = [AVPlayerHelper sharedAVPlayerHelper].briefTextValue;
//                playViewController.tag = track.Tag;
//                break;
//            }
//        }
//    }
//    
//    
//    // 跳转
//    [self presentViewController:playViewController animated:YES completion:nil];
//}


static NSInteger indexCount = 0;
/**
 *  设置自动动画效果
 */
- (void)timer
{
    if (indexCount < ((NSArray *) _allDataArray[@"focusImages"]).count) {
        CGPoint point = CGPointMake(indexCount * self.view.frame.size.width, 0);
        [_headerView.scrollView setContentOffset:point animated:YES];
        // 设置小点点的位置
        _headerView.pageControl.currentPage = indexCount;
        indexCount++;
    } else {
        indexCount = 0;
        CGPoint point = CGPointMake(indexCount * self.view.frame.size.width, 0);
        [_headerView.scrollView setContentOffset:point animated:YES];
        // 设置小点点的位置
        _headerView.pageControl.currentPage = indexCount;
    }
}

/**
 *  小点点的点击事件
 *
 *  @param sender 小点点对象
 */
- (void)pageControlAction:(UIPageControl *)sender
{
    indexCount = sender.currentPage;
    CGPoint point = CGPointMake(indexCount * self.view.frame.size.width, 0);
    [_headerView.scrollView setContentOffset:point animated:YES];
}

/**
 *  scrollerView拖拽结束方法
 *
 *  @param scrollView scrollerView对象
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 取得当前图片的下标
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    // 设置小点点的位置
    _headerView.pageControl.currentPage = index;
    indexCount = index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mark - 设置有多少分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

#pragma mark - 设置每个分组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewAllDataArray.count;
}

#pragma mark - 设置每行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecommendEditorTableViewCell *editorCell = [tableView dequeueReusableCellWithIdentifier:kCellEditorIndentifer];

    if (editorCell == nil) {
        editorCell = [[RecommendEditorTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellEditorIndentifer];
    }
    
    NSString *title = _tableViewAllDataArray.allKeys[indexPath.row];
    editorCell.title = title;
    editorCell.images = _tableViewAllDataArray[title];
    
    // 给按钮添加点击事件
    for (UIButton *sender in editorCell.detailButtons) {
        // 跳转事件
        [sender addTarget:self action:@selector(detailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 给更多按钮添加点击事件
    [editorCell.moveButton addTarget:self action:@selector(moveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return editorCell;
}

#pragma mark - 更多按钮点击事件
- (void)moveButtonAction:(UIButton *)sender
{
    CategoriesModel *model = [CategoriesModel new];
    model.Id = sender.tag;
    
    SecondCategoriesViewController *secondCategoriesTC = [SecondCategoriesViewController new];
    secondCategoriesTC.cateModel = model;
    
    // 跳转
    [self.navigationController pushViewController:secondCategoriesTC animated:YES];
}

#pragma mark - 详细图片点击事件
- (void)detailButtonAction:(UIButton *)sender
{
    CommonTableViewController *recommendAndCategoriesTC = [[CommonTableViewController alloc] initWithStyle:UITableViewStylePlain];
     self.tabBarController.tabBar.hidden = YES;
    recommendAndCategoriesTC.albumStr = sender.tag;
    
    [self.navigationController pushViewController:recommendAndCategoriesTC animated:YES];
}

#pragma mark - 焦点图点击事件
- (void)headerButtonAction:(UIButton *)sender
{
    CommonTableViewController *recommendAndCategoriesTC = [[CommonTableViewController alloc] initWithStyle:UITableViewStylePlain];
    // 获取对象FocusImages对象
    FocusImages *focusImageObj = _allDataArray[@"focusImages"][sender.tag];
    
    // 判断trackId或者AlbumId是否存在
    if (focusImageObj.trackId != 0) {
        // trackId存在的场合，发起二次请求获取AlbumId
        [[RecommendFileHelper sharedRecommendFileHelper] readerTrackFile:focusImageObj.trackId albumIdBlock:^(NSString *AlbumId) {
            recommendAndCategoriesTC.albumStr = AlbumId.integerValue;
             self.tabBarController.tabBar.hidden = YES;
            // 跳转
            [self.navigationController pushViewController:recommendAndCategoriesTC animated:YES];
        }];
    } else if (focusImageObj.albumId != 0) {
        recommendAndCategoriesTC.albumStr = focusImageObj.albumId;
         self.tabBarController.tabBar.hidden = YES;
        // 跳转
        [self.navigationController pushViewController:recommendAndCategoriesTC animated:YES];
    } else {
        // 提示用户没有网络数据
        self.alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有网络数据" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [_alertView show];
        // 设置时间段
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doTime) userInfo:nil repeats:NO];
    }
}

#pragma mark - 设置显示多长时间后消失
- (void)doTime
{
    [_alertView dismissWithClickedButtonIndex:0 animated:NO];
    _alertView = nil;
}

#pragma mark - 设置cell高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

@end