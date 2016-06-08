//
//  MJ_DragonFoodViewController.m
//  DragonVideo
//
//  Created by MJ on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonFoodViewController.h"

#import "MJ_DragonFoodTableViewCell.h"
#import "WJLAFNetworkingTool.h"
#import "MJ_DragonFoodModel.h"
#import "MJ_DragonFoodDetailViewController.h"
#import <MBProgressHUD.h>

@interface MJ_DragonFoodViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MJ_DragonFoodModel *foodModel;
@property (nonatomic, strong) NSMutableArray *foodArray;

@end

@implementation MJ_DragonFoodViewController

- (void)viewWillAppear:(BOOL)animated {
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"日食";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:190 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1], NSForegroundColorAttributeName, [UIFont systemFontOfSize:20], NSFontAttributeName,nil]];
   
    
    
    [self creatTableView];
    [self creatData];
    
    
    // Do any additional setup after loading the view.
}

- (void)creatData {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"努力加载中";
    
    [WJLAFNetworkingTool GETNetWithUrl:@"http://api.izhangchu.com/?user_id=1367039&page=1&token=24C7AEC8935798F02FE991D8992A7EE2&methodName=CourseIndex&size=20&version=4.3.2&" body:nil headerFile:nil response:MJ_LongJSON success:^(id result) {
        
        NSArray *array = result[@"data"][@"data"];
        self.foodArray = [NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *dic in array) {
            self.foodModel = [[MJ_DragonFoodModel alloc] init];
            [self.foodModel setValuesForKeysWithDictionary:dic];
            
//            NSLog(@"%@", self.foodModel.series_name);
            [self.foodArray addObject:self.foodModel];
        }
        [HUD hide:NO];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)creatTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = self.view.frame.size.width / 2;
    self.tableView.backgroundColor = [UIColor colorWithRed:190 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellIdentifier"];
    [self.tableView registerClass:[MJ_DragonFoodTableViewCell class] forCellReuseIdentifier:@"MJ_DragonFoodTableViewCellIdentifier"];
    
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MJ_DragonFoodDetailViewController *foodDetailVC = [[MJ_DragonFoodDetailViewController alloc] init];
    foodDetailVC.foodModel = self.foodArray[indexPath.row];
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:foodDetailVC animated:YES];
}

//返回cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MJ_DragonFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MJ_DragonFoodTableViewCellIdentifier"];
    
    self.foodModel = self.foodArray[indexPath.row];
    cell.foodModel = self.foodModel;
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.foodArray.count;
    
}



//单独定制白色电池条
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
