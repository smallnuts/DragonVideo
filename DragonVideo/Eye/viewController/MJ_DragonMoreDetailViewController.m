//
//  MJ_DragonMoreDetailViewController.m
//  DragonVideo
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonMoreDetailViewController.h"

#import "MJ_DragonMoreDetailCollectionViewCell.h"
#import "MJ_DragonEyeDetailModel.h"
#import "WJLAFNetworkingTool.h"
#import "MJ_DragonEyePlayerViewController.h"

#import "CoreDataManager.h"
#import "DragonVideo.h"
#import "MJ_DragonEyeDetailDataModel.h"

@interface MJ_DragonMoreDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) CoreDataManager *coreDataManager;
@property (nonatomic, strong) NSMutableArray *coreDataArray;
@property (nonatomic, assign) BOOL iscollect;

@end

@implementation MJ_DragonMoreDetailViewController


- (void)viewWillAppear:(BOOL)animated {
    
    self.coreDataManager = [CoreDataManager shareCoreDataManager];
    self.coreDataArray = [NSMutableArray arrayWithCapacity:0];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DragonVideo" inManagedObjectContext:self.coreDataManager.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [self.coreDataArray setArray:fetchedObjects];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    MJ_DragonEyeDetailModel *detailModel = self.dataSource[self.number];
    for (DragonVideo *video in self.coreDataArray) {
        if (detailModel.detailModel.dataId.integerValue == video.dataId.integerValue) {
            [array addObject:video.dataId];
        }
    }
    self.iscollect = NO;
    if (array.count > 0) {
        self.iscollect = YES;
    }
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBarController.tabBar.hidden = YES;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1], NSForegroundColorAttributeName, [UIFont systemFontOfSize:20], NSFontAttributeName,nil]];
     [self foundCollection];
    
}

- (void)foundCollection
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];

    //隐藏侧面的滑动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[MJ_DragonMoreDetailCollectionViewCell class] forCellWithReuseIdentifier:@"MJ_DragonMoreDetailCollectionViewCellIdentifier"];

    [self.view addSubview:self.collectionView];
//  *********
    self.collectionView.contentOffset = CGPointMake(self.number * self.view.bounds.size.width, 0);
    
// [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.number inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//  *********
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MJ_DragonMoreDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MJ_DragonMoreDetailCollectionViewCellIdentifier" forIndexPath:indexPath];
    
    MJ_DragonEyeDetailModel *detailModel = self.dataSource[indexPath.row];
    cell.dataModel = detailModel.detailModel;
    [cell.collectButton addTarget:self action:@selector(buttonActino:) forControlEvents:UIControlEventTouchUpInside];
    cell.collectButton.tag = 100;
    [cell.shareButton addTarget:self action:@selector(buttonActino:) forControlEvents:UIControlEventTouchUpInside];
    cell.shareButton.tag = 101;
    [cell.cacheButton addTarget:self action:@selector(buttonActino:) forControlEvents:UIControlEventTouchUpInside];
    cell.cacheButton.tag = 102;
    if (!self.iscollect) {
        cell.collectImageView.image = [[UIImage imageNamed:@"collect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        cell.collectImageView.image = [[UIImage imageNamed:@"collect2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MJ_DragonEyePlayerViewController *eyePlayerVC = [[MJ_DragonEyePlayerViewController alloc] init];
    MJ_DragonEyeDetailModel *detailModel = self.dataSource[indexPath.row];
    eyePlayerVC.dataModel = detailModel.detailModel;
    [self.navigationController pushViewController:eyePlayerVC animated:YES];
}

- (void)buttonActino:(UIButton *)sender {
    UIButton *collectButton = [self.view viewWithTag:100];
//    UIButton *shareButton = [self.view viewWithTag:101];
//    UIButton *cacheButton = [self.view viewWithTag:102];
    if (sender == collectButton) {
        
    }
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
