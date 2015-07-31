//
//  SecondCategoriesViewController.m
//  SecretarialLofty
//
//  Created by 康辰 on 15/7/15.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "SecondCategoriesViewController.h"
#import "CategoriesModel.h"
#import "SecondCategoriesTableViewCell.h"
#import "SecondTwoCategoriesCell.h"
#import "SecondCategoriesModels.h"
#import "SecondCategoriesTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "CategoriesDBHelper.h"
#import "Reachability.h"
#import "AMTumblrHud.h"

#define kURLStr(id, pageId) [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/discovery/v1/category/album?calcDimension=hot&categoryId=%lu&device=android&pageId=%lu&pageSize=20&status=0&tagName=", id, pageId]

@interface SecondCategoriesViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *allDataArray;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, retain) SecondCategoriesModels *secondCategoriesM;
@property (nonatomic, assign) NSInteger currentPageId;
@property (nonatomic, retain) UIImage *aImage;
@property (nonatomic, retain) UIImage *bImage;
@property(nonatomic,strong)Reachability *reach;
@property (nonatomic,strong) AMTumblrHud *amTumb;

@end

static NSString * const reuseIdentifier = @"Cell";

@implementation SecondCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _cateModel.title;
    
    // 创建导航栏右侧图片
    self.aImage = [UIImage imageNamed:@"btn_nav_collection@2x"];
    self.bImage = [UIImage imageNamed:@"btn_nav_list@2x"];
    
    // 加载layout方法
    [self addLayout];
    
    [self finishView];
    
    // 加载数据
    [self reloadDataCompletionHanle:nil];
    
    // 定义tableview 并添加到父视图
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 44)];
    [self.view addSubview:_tableView];
    
    // 给tableview添加代理方法
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UIView *view = self.view.subviews.firstObject;
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    __weak typeof(self) weakSelf = self;
    
    // tableview的下拉刷新方法
    [self.tableView addHeaderWithCallback:^{
        [weakSelf reloadDataCompletionHanle:^{
            [weakSelf.tableView headerEndRefreshing];
        }];
    }];
    // tableview的上拉加载
    [self.tableView addFooterWithCallback:^{
        [weakSelf appendDataCompletionHanle:^{
            [weakSelf.tableView footerEndRefreshing];
        }];
    }];
    
    // collectionview的下拉刷新
    [self.collectionView addHeaderWithCallback:^{
        [weakSelf reloadDataCompletionHanle:^{
            [weakSelf.collectionView headerEndRefreshing];
        }];
    }];
    
    // collectionview的上拉刷新
    [self.collectionView addFooterWithCallback:^{
        [weakSelf appendDataCompletionHanle:^{
            [weakSelf.collectionView footerEndRefreshing];
        }];
    }];
    
    // 设置右侧导航栏按钮图片 和切换
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:_aImage style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItemAction:)];
    
    // 设置导航栏左侧按钮图片
    self.navigationItem.leftBarButtonItem = ({
        UIImage *selectedImage=[UIImage imageNamed: @"left.png"];
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:selectedImage style:UIBarButtonItemStyleDone target:self action:@selector(backAction:)];
        leftBtn;
    });

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =NO;
}

#pragma mark - 定义布局控制器
- (void)addLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.minimumInteritemSpacing = 15;
    
    layout.minimumLineSpacing = 20;
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.sectionInset = UIEdgeInsetsMake(65, 30, 30, 30);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    
   // [self.view addSubview:_collectionView];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    // 注册cell
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[SecondTwoCategoriesCell class] forCellWithReuseIdentifier:@"cell"];
   
}

#pragma mark - 返回按钮点击事件
- (void)backAction:(UIBarButtonItem *)sender
{
    // 返回到前一个画面
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 网络请求并解析
- (void)loadDataWithCategoryId:(NSInteger)categoryId
                        pageId:(NSInteger)pageId
              completionHandle:(void(^)())completionHandle
{
    __weak typeof (self)weakSelf = self;
    
    self.reach = [Reachability reachabilityForInternetConnection];
    if (self.reach.isReachable) {
        [self.amTumb showAnimated:YES];
        self.currentPageId = pageId;
        NSString *urlString = kURLStr((long)categoryId, (long)pageId);
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (!data) {
                UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@"数据请求失败，请检查网络后重试！！" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [ale show];
                NSLog(@"数据请求失败");
                if (completionHandle) {
                    completionHandle();
                }
                return ;
            }
            [weakSelf.amTumb showAnimated:NO];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (pageId == 1) {
                weakSelf.allDataArray = [NSMutableArray array];
            }
            
           // NSLog(@"%@", dict);
            
            NSArray *array = dict[@"list"];
            
            for (NSDictionary *itme in array) {
                SecondCategoriesModels *m = [SecondCategoriesModels new];
                [m setValuesForKeysWithDictionary:itme];
                [weakSelf.allDataArray addObject:m];
            }
            
            [weakSelf.tableView reloadData];
            [weakSelf.collectionView reloadData];
            if (completionHandle) {
                completionHandle();
            }
        }];
    }  else
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"无网络连接,请检查后网络后再操作" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)finishView
{
    self.amTumb = [[AMTumblrHud alloc] initWithFrame:CGRectMake((CGFloat) ((self.view.frame.size.width - 55) * 0.5), (CGFloat) ((self.view.frame.size.height - 20) * 0.5), 55, 20)];
    self.amTumb.hudColor = [UIColor orangeColor];
    [self.view addSubview:self.amTumb];
    [self.amTumb showAnimated:NO];
}
#pragma mark - 给下拉刷新请求网络方法
- (void)reloadDataCompletionHanle:(void (^)())comletionHandle
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    [self loadDataWithCategoryId:_cateModel.Id pageId:1 completionHandle:^{
        if (comletionHandle) {
            comletionHandle();
        }
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}

#pragma mark - 上提加载请求网络方法
- (void)appendDataCompletionHanle:(void (^)())comletionHandle
{
    [self loadDataWithCategoryId:_cateModel.Id pageId:self.currentPageId + 1 completionHandle:^{
        if (comletionHandle) {
            comletionHandle();
        }
    }];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _allDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString * const reuseIdentifier = @"Cell
    SecondTwoCategoriesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    _secondCategoriesM = _allDataArray[indexPath.row];
   
    cell.nameLabel.text = _secondCategoriesM.Title;
    cell.induceLabel.text = _secondCategoriesM.intro;
    
    [cell.showImageView sd_setImageWithURL:[NSURL URLWithString:_secondCategoriesM.albumCoverUrl290]];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenNewSize.size.width - 90) / 2, 190);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _allDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondCategoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[SecondCategoriesTableViewCell alloc] initWithFrame:self.view.frame];
    }
    SecondCategoriesModels *secondM = _allDataArray[indexPath.row];
    
    secondM = _allDataArray[indexPath.row];

    cell.nameLabel.text = secondM.Title;
    cell.intorLabel.text = secondM.intro;
    
    
  //  NSLog(@"albumId = %ld", secondM.albumId);
    
    cell.collectButton.tag = indexPath.row;
    
    [cell.collectButton addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.setimageView sd_setImageWithURL:[NSURL URLWithString:secondM.albumCoverUrl290]];
    
    return cell;
}

#pragma mark - 点击收藏方法
- (void)collectButtonAction:(UIButton *)secder
{
    
    SecondCategoriesModels *secondM = [SecondCategoriesModels new];

    secondM = [_allDataArray objectAtIndex:secder.tag];
    
    BOOL a = [[CategoriesDBHelper categoriesDBHepler]selectDataWithID:secondM.albumId];
    NSLog(@"%d", a);
    if (!a) {
        [[CategoriesDBHelper categoriesDBHepler] insertCategories:secondM.Id AndTitle:secondM.Title];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已收藏" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)barButtonItemAction:(UIBarButtonItem *)sender
{
    // 判断导航栏右侧按钮
    
    if (self.view.subviews.lastObject == self.tableView) {
        sender.image = _bImage;
        [self.tableView removeFromSuperview];
        [self.view addSubview:_collectionView];
    } else {
        sender.image = _aImage;
        [self.collectionView removeFromSuperview];
        [self.view addSubview:_tableView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - tableView跳转到播放页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonTableViewController *recommendAndCategoriesTC = [[CommonTableViewController alloc] initWithStyle:UITableViewStylePlain];
    SecondCategoriesModels *secondM = _allDataArray[indexPath.row];
    recommendAndCategoriesTC.albumStr = secondM.albumId;
    self.tabBarController.tabBar.hidden = YES;
    // 跳转
    [self.navigationController pushViewController:recommendAndCategoriesTC animated:YES];
}

#pragma mark - collectionView跳转到播放页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommonTableViewController *recommendAndCategoriesTC = [[CommonTableViewController alloc] initWithStyle:UITableViewStylePlain];
    SecondCategoriesModels *secondM = _allDataArray[indexPath.row];
    recommendAndCategoriesTC.albumStr = secondM.albumId;
    self.tabBarController.tabBar.hidden = YES;
    // 跳转
    [self.navigationController pushViewController:recommendAndCategoriesTC animated:YES];
}


@end










