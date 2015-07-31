//
//  MineViewController.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "MineViewController.h"
#import "MyCollectionTableViewController.h"
#import "DisclaimerViewController.h"
#import "AboutUsViewController.h"
#import "SDImageCache.h"
#import "CategoriesDBHelper.h"

#define kCellIdentifier @"Cell"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    float size;
}
@property(strong,nonatomic)UITableView*tableView;
@property(nonatomic,strong)NSArray *mArray;
@property(nonatomic,strong)UIImageView *lheadImgeView;
@property(nonatomic,strong)UIView *headImageView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"我的";
    [self layoutTableView];

    self.mArray=[NSArray arrayWithObjects:@[@"我的收藏",@"清除缓存",@"意见反馈"],@[@"免责声明",@"关于我们"], nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =NO;
}

-(void)layoutTableView
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    self.headImageView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 140)];
    //self.headImageView.backgroundColor=[UIColor orangeColor];
    self.tableView.tableHeaderView=self.headImageView;
    
    
    //图标
    self.lheadImgeView=[[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-110)/2, 20, 110, 110)];
    self.lheadImgeView.image=[UIImage imageNamed:@"iconn"];

    self.lheadImgeView.layer.cornerRadius=18;
    self.lheadImgeView.layer.masksToBounds=YES;
    [self.headImageView addSubview:self.lheadImgeView];
    
}

#pragma mark - Table view data source

#pragma mark - 设置有多少分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.mArray.count;
}

#pragma mark - 设置每个分组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.mArray objectAtIndex:section] count];
}

#pragma mark - 设置每行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    cell.textLabel.text=[[self.mArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark-设置分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma mark-选择cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0)//我的收藏
        {
            MyCollectionTableViewController *myCollection=[[MyCollectionTableViewController alloc]init];
            
            [self.navigationController pushViewController:myCollection animated:YES];
        }
        if (indexPath.row==1)//清除缓存
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要清除缓存?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alert show];
        }
        if (indexPath.row==2)//意见反馈
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"建议请发邮箱!谢谢!!" message:@"邮箱地址:Tracy_young529@sina.com" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        
    }
    if (indexPath.section==1)
        {
            if (indexPath.row==0)//免责声明
            {
                DisclaimerViewController *Disclaimer=[[DisclaimerViewController alloc]init];
                self.tabBarController.tabBar.hidden = YES;
                [self.navigationController pushViewController:Disclaimer animated:YES];
            }
            if (indexPath.row==1)//关于我们
            {
                AboutUsViewController *aboutus=[[AboutUsViewController alloc]init];
                self.tabBarController.tabBar.hidden = YES;
                [self.navigationController pushViewController:aboutus animated:YES];
            }
        }
}

#pragma mark-清除缓存
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)//清除按钮
    {
        
       size=[self checkSize];
      //  [CategoriesDBHelper del];
        
        dispatch_async(
                       
                       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                       , ^{
                           
                           NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                           NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                           for (NSString *p in files) {
                               NSError *error;
                               NSString *path = [cachPath stringByAppendingPathComponent:p];
                               if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                                   [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                               }
                           }
                           [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
                       });
    }
}

#pragma mark-清除缓存
-(void)clearCacheSuccess
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"一共清除了%.2fM的缓存",size] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (float)checkSize
{
    NSString *cachPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    float fileSize=0;
    NSDirectoryEnumerator *fileEnumerator=[[NSFileManager defaultManager]enumeratorAtPath:cachPath];
    
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath=[cachPath stringByAppendingPathComponent:fileName];
        
        NSDictionary *attr=[[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil];
        
        unsigned long long lengh=[attr fileSize];
        fileSize+=(lengh/1024.0)/1024.0;
    }
    return fileSize;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
