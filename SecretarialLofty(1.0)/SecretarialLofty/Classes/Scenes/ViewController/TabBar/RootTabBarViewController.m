//
//  RootTabBarViewController.m
//  SecretarialLofty
//
//  Created by SecretarialLofty on 15/7/8.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "BaseViewController.h"
#import "RecommendTableViewController.h"
#import "CategoriesViewController.h"
#import "SpecialTableViewController.h"
#import "MineViewController.h"
@interface RootTabBarViewController () <UITabBarControllerDelegate>

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWithTableViewControllers];
}

- (void)initWithTableViewControllers
{
    RecommendTableViewController *recommendTC = [[RecommendTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    recommendTC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"推荐" image:[UIImage imageNamed:@"tabbar_recommend.png"] selectedImage:[UIImage imageNamed:@"tabbar_recommend.png"]];
    
    CategoriesViewController *categoriesCC = [[CategoriesViewController alloc] init];
    
    categoriesCC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:[UIImage imageNamed:@"tabbar_category.png"] selectedImage:[UIImage imageNamed:@"tabbar_category.png"]];

    SpecialTableViewController *specialTC = [SpecialTableViewController new];
    
    specialTC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"专题" image:[UIImage imageNamed:@"tabbar_special.png"] selectedImage:[UIImage imageNamed:@"tabbar_special.png"]];

    MineViewController *mineTC = [MineViewController new];
    
    mineTC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"tabbar_Mine.png"] selectedImage:[UIImage imageNamed:@"tabbar_Mine.png"]];

    NSArray *array = @[recommendTC, categoriesCC, specialTC, mineTC];
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    // 将自定义的tableViewController添加到自定义navigationController中
    for (UIViewController *vc in array) {
        
        BaseViewController *baseVC = [[BaseViewController alloc] initWithRootViewController:vc];
        // 将baseVC添加到可变数组中
        [viewControllers addObject:baseVC];
    }
    
    self.viewControllers = viewControllers;
    
    // 设置背景图片
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_bg02.png"];
    
    // 设置所有tableView背景图片
    [UITableView appearance].backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_01.png"]];
    
    // 设置所有tableViewCell背景图片
    [UITableViewCell appearance].backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_01.png"]];
    
    self.delegate = self;
}

#pragma mark 设置控制器是否可用
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
