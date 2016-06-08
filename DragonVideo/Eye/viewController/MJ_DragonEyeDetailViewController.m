//
//  MJ_DragonEyeDetailViewController.m
//  DragonVideo
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonEyeDetailViewController.h"

#import "MJ_DragonEyeDetailTableViewCell.h"
#import "WJLAFNetworkingTool.h"
#import "MJ_DragonEyeDetailModel.h"
#import <MJRefresh.h>
#import "MJ_DragonMoreDetailViewController.h"
#import "MJ_DragonEyeDetailDataModel.h"
#import <MBProgressHUD.h>

#import "MJ_DragonEyePlayInfoModel.h"

@interface MJ_DragonEyeDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger page;

@end

@implementation MJ_DragonEyeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1], NSForegroundColorAttributeName, [UIFont systemFontOfSize:20], NSFontAttributeName,nil]];
    self.navigationItem.title = self.string;
    
    [self foundTableView];
}

- (void)foundTableView
{
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    self.page = 0;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    [self.tableView.mj_header beginRefreshing];
   
    
    //隐藏侧面的滑动条
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[MJ_DragonEyeDetailTableViewCell class] forCellReuseIdentifier:@"MJ_DragonEyeDetailTableViewCellIdentifier"];
    [self.view addSubview:self.tableView];
    //    上拉加载

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    //    马上进入加载状态
    [self.tableView.mj_footer beginRefreshing];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MJ_DragonEyeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MJ_DragonEyeDetailTableViewCellIdentifier"];
    if (self.dataSource.count) {
        MJ_DragonEyeDetailModel *detailModel = self.dataSource[indexPath.row];
        cell.dataModel = detailModel.detailModel;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (void)requestData
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"努力加载中";
    
    [WJLAFNetworkingTool GETNetWithUrl:[NSString stringWithFormat:@"http://baobab.wandoujia.com/api/v3/videos?start=%ld&num=10&categoryName=%@&strategy=date", self.page, self.string] body:nil headerFile:nil response:MJ_LongJSON success:^(id result) {
       
        for (NSDictionary *dic in result[@"itemList"]) {
            MJ_DragonEyeDetailModel *detailModel = [[MJ_DragonEyeDetailModel alloc] initWithDataSource:dic];
            [self.dataSource addObject:detailModel];
        }
        
        [self.tableView reloadData];
         [HUD hide:NO];
//        结束加载状态
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        
    }];
    self.page += 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MJ_DragonMoreDetailViewController *detailVC = [[MJ_DragonMoreDetailViewController alloc] init];
    detailVC.dataSource = self.dataSource;
    detailVC.number = indexPath.row;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = NO;
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
