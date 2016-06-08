//
//  MJ_DragonEyeViewController.m
//  DragonVideo
//
//  Created by MJ on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonEyeViewController.h"

#import "MJ_DragonEyeCollectionViewCell.h"
#import "WJLAFNetworkingTool.h"
#import "MJ_DragonEyeModel.h"
#import "MJ_DragonEyeDetailViewController.h"
#import <MBProgressHUD.h>

@interface MJ_DragonEyeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MJ_DragonEyeViewController

- (void)viewWillAppear:(BOOL)animated {
    //    恢复标签栏
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"目观";
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:190 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1], NSForegroundColorAttributeName, [UIFont systemFontOfSize:20], NSFontAttributeName,nil]];
    // Do any additional setup after loading the view.
    [self foundCollection];
    [self requestData];
    
}

- (void)foundCollection
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width / 2, (self.view.frame.size.height - 100) / 3);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //隐藏侧面的滑动条
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
   
//    self.collectionView.backgroundColor = [UIColor blackColor];
    
    [self.collectionView registerClass:[MJ_DragonEyeCollectionViewCell class] forCellWithReuseIdentifier:@"MJ_DragonEyeCollectionViewCellIdentifier"];
    
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MJ_DragonEyeCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MJ_DragonEyeCollectionViewCellIdentifier" forIndexPath:indexPath];
    
    cell.eyeModel = self.dataSource[indexPath.item];
    
    return cell;
}

- (void)requestData
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"努力加载中";
    
    [WJLAFNetworkingTool GETNetWithUrl:@"http://baobab.wandoujia.com/api/v2/categories?udid=2c12e115a5e04330b549c5b986baa7920df79190&vc=83&vn=1.12.1&deviceModel=MI%20NOTE%20LTE&first_channel=eyepetizer_xiaomi_market&last_channel=eyepetizer_xiaomi_market" body:nil headerFile:nil response:MJ_LongJSON success:^(id result) {
        self.dataSource = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in result) {
            MJ_DragonEyeModel *eyeModel = [[MJ_DragonEyeModel alloc] initWithDataSource:dic];
            [self.dataSource addObject:eyeModel];
        }
        [self.collectionView reloadData];
        [HUD hide:NO];
    } failure:^(NSError *error) {
        
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MJ_DragonEyeModel *eyeModel = self.dataSource[indexPath.row];
    MJ_DragonEyeDetailViewController *detailVC = [[MJ_DragonEyeDetailViewController alloc] init];
    detailVC.string = eyeModel.name;
    [self.navigationController pushViewController:detailVC animated:YES];
    
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
