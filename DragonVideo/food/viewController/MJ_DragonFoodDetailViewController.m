//
//  MJ_DragonFoodDetailViewController.m
//  DragonVideo
//
//  Created by MJ on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonFoodDetailViewController.h"
#import "MJ_DragonFoodDetailTableViewCell.h"
#import "WJLAFNetworkingTool.h"
#import "MJ_DragonFoodDetailModel.h"
#import <MBProgressHUD.h>
#import "MJ_DragonPlayerBaseViewController.h"

@interface MJ_DragonFoodDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MJ_DragonFoodDetailModel *foodDetailModel;
@property (nonatomic, strong) NSMutableArray *foodDetailArray;

@end

@implementation MJ_DragonFoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.foodModel.series_name;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction:)];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:190 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1];
    
    
    [self creatData];
    [self creatTableView];
    
    // Do any additional setup after loading the view.
}

- (void)leftButtonAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatData {
//    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    HUD.labelText = @"努力加载中";
    NSString *urlStr = [NSString stringWithFormat:@"http://api.izhangchu.com/ HTTP/1.1?methodName=CourseSeriesView&series_id=%@&version=4.40&", self.foodModel.series_id];

    [WJLAFNetworkingTool GETNetWithUrl:urlStr body:nil headerFile:nil response:MJ_LongJSON success:^(id result) {
        NSArray *array = result[@"data"][@"data"];
        self.foodDetailArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *foodArray = [NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *dic in array) {
            self.foodDetailModel = [[MJ_DragonFoodDetailModel alloc] init];
            [self.foodDetailModel setValuesForKeysWithDictionary:dic];
            
            [foodArray addObject:self.foodDetailModel];
        }
        for (NSInteger i = 1; i <= foodArray.count; i++) {
            
            [self.foodDetailArray addObject:[foodArray objectAtIndex:foodArray.count - i]];
            
        }
        
        
        
        
        [self.tableView reloadData];
//        [HUD hide:NO];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

- (void)creatTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:190 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1];
    self.tableView.rowHeight = self.view.frame.size.width;
    
    [self.tableView registerClass:[MJ_DragonFoodDetailTableViewCell class] forCellReuseIdentifier:@"MJ_DragonFoodDetailTableViewCellIdentifier"];
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MJ_DragonPlayerBaseViewController *playVC = [[MJ_DragonPlayerBaseViewController alloc] init];
    playVC.foodDetailModel = self.foodDetailArray[indexPath.row];
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:playVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.foodDetailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MJ_DragonFoodDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MJ_DragonFoodDetailTableViewCellIdentifier"];
    
    self.foodDetailModel = self.foodDetailArray[indexPath.row];
    cell.foodDetialModel = self.foodDetailModel;
    cell.backgroundColor = [UIColor colorWithRed:190 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1];
    
    return cell;
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
