//
//  MyCollectionTableViewController.m
//  SecretarialLofty
//
//  Created by lanou3g on 15/7/15.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "MyCollectionTableViewController.h"
#import "CategoriesDBHelper.h"
#import "SecondCategoriesModels.h"
#import "CommonTableViewController.h"
@interface MyCollectionTableViewController ()

@property (nonatomic, retain) NSMutableArray *allDataArray;

@end

@implementation MyCollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allDataArray = [NSMutableArray array];
    
    _allDataArray = [NSMutableArray arrayWithArray:[[CategoriesDBHelper categoriesDBHepler] selectAllData]];
    [self.tableView reloadData];
   // NSArray *array = [[CategoriesDBHelper categoriesDBHepler] selectAllData];
    
    self.title = @"我的收藏";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _allDataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    SecondCategoriesModels *m = [SecondCategoriesModels new];
  //  NSLog(@"%@", m.Title);
    m = _allDataArray[indexPath.row];
    cell.textLabel.text = m.Title;
    
    return cell;
}

- (NSMutableArray *)allDataArray
{
    if (!_allDataArray) {
        self.allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonTableViewController *recommendAndCategoriesTC = [[CommonTableViewController alloc] initWithStyle:UITableViewStylePlain];
    SecondCategoriesModels *secondM = _allDataArray[indexPath.row];
    recommendAndCategoriesTC.albumStr = secondM.albumId;
    // 跳转
    [self.navigationController pushViewController:recommendAndCategoriesTC animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
