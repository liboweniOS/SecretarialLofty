//
//  CategoriesViewController.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/9.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CategoriesCollectionViewCell.h"
#import "AFNetworking.h"
#import "CategoriesModel.h"
#import "UIImageView+WebCache.h"
#import "CategoriesFileHelper.h"
#import "SecondCategoriesViewController.h"
#import "Adaptive.h"
#import "UIView+AddConstraint.h"
#import "CategoriesDBHelper.h"
#import "AMTumblrHud.h"
#import "Reachability.h"

#define kURLStr @"http://mobile.ximalaya.com/mobile/discovery/v1/categories?device=android&picVersion=10&scale=2"

@interface CategoriesViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) NSMutableArray *allDataArray;
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic,strong) AMTumblrHud *amTumb;
@property(nonatomic,strong)Reachability *reach;

@end

static NSString * const reuseIdentifier = @"Cell";

static NSString *strUrl = @"http://mobile.ximalaya.com/mobile/discovery/v1/categories?device=android&picVersion=10&scale=2";

@implementation CategoriesViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"分类";

    // 设置导航栏右侧按钮
//    self.navigationItem.rightBarButtonItem = ({
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navAVPlayer.png"] style:UIBarButtonItemStyleDone target:self action:@selector(rightAction:)];
//    rightButton;
//    });

    // 1.创建布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    // 设置最小列间距
    layout.minimumInteritemSpacing = 10;   
    
    // 设置分区头部和尾部的大小
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 40);
    //layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    // 2.创建CollectionView，并添加
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];

    _collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_01.png"]];
        [self.view addSubview:_collectionView];
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:[CategoriesCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    __weak typeof (self)weakSelf = self;
    [self finishView];
    
    self.reach = [Reachability reachabilityForInternetConnection];
if (self.reach.isReachable) {
    [self.amTumb showAnimated:YES];
        [[CategoriesFileHelper sharedCategoriesFileHelper] loadDataWithURLStr:kURLStr result:^(id obj) {
            _allDataArray = obj;
            //[weakSelf.amTumb showAnimated:NO];
            [weakSelf.collectionView reloadData];
            [weakSelf.amTumb showAnimated:NO];
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


- (void)viewWillAppear:(BOOL)animated
{
    // 设置导航栏播放器按钮状态
//    if ([AVPlayerHelper sharedAVPlayerHelper].allDataArray == nil || [AVPlayerHelper sharedAVPlayerHelper].allDataArray.count == 0) {
//        // 设置按钮不可用
//        self.navigationItem.rightBarButtonItem.enabled = NO;
//    } else {
//        for (PlayListModel *track in [AVPlayerHelper sharedAVPlayerHelper].allDataArray) {
//            // 判断URL
//            if (track.playUrl64 != nil) {
//                
//                if ([track.playUrl64 isEqualToString:[AVPlayerHelper sharedAVPlayerHelper].playerURL]) {
//                    // 设置按钮可用
//                    self.navigationItem.rightBarButtonItem.enabled = YES;
//                    break;
//                }
//            }else
//            {
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

//#pragma mark - 导航栏右侧按钮点击
//- (void)rightAction:(UIBarButtonItem *)sender
//{
//    CommonPlayViewController *playViewController = [[CommonPlayViewController alloc] init];
//    // 传值
//    for (Track *track in [AVPlayerHelper sharedAVPlayerHelper].allDataArray) {
//        // 判断URL
//        if ([track.playUrl64 isEqualToString:[AVPlayerHelper sharedAVPlayerHelper].playerURL]) {
//            playViewController.trackObj = track;
//            playViewController.briefTextValue = [AVPlayerHelper sharedAVPlayerHelper].briefTextValue;
//            playViewController.tag = track.Tag;
//            break;
//        }
//    }
//    // 跳转
//    [self presentViewController:playViewController animated:YES completion:nil];
//}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == _allDataArray.count / 6) {
        return _allDataArray.count % 6;
    }
    return  6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoriesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    CategoriesModel *model = [CategoriesModel new];
    model = _allDataArray[indexPath.section * 6 + indexPath.row];
    
    cell.nameLabel.text = model.title;
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.coverPath]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width / 2 - 20, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SecondCategoriesViewController *secondVC = [SecondCategoriesViewController new];
    
    CategoriesModel *model = [CategoriesModel new];
    
    model = _allDataArray[indexPath.section * 6 + indexPath.row];

    secondVC.cateModel = model;
    
   // NSLog(@"%ld", model.Id);
    
    [self.navigationController pushViewController:secondVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
