//
//  MJ_DragonMYFavoritesViewController.m
//  DragonVideo
//
//  Created by MJ on 16/4/6.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonMYFavoritesViewController.h"

#import "CoreDataManager.h"
#import "DragonVideo.h"
#import "MJ_DragonEyeTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "MJ_DragonEyePlayerViewController.h"
#import "MJ_DragonFoodDetailModel.h"
#import "MJ_DragonFoodDetailTableViewCell.h"
#import "DragonEverydayEat.h"
#import "MJ_DragonPlayerBaseViewController.h"
#import "MJ_DragonFoodDetailModel.h"

@interface MJ_DragonMYFavoritesViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CoreDataManager *coreDataManager;
@property (nonatomic, strong) NSMutableArray *coreDataArray;

@property (nonatomic, strong) CoreDataManager *foodCoreDataManager;
@property (nonatomic, strong) NSMutableArray *foodCoreDataArray;


@end

@implementation MJ_DragonMYFavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction:)];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:190 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1];
    
    self.coreDataManager = [CoreDataManager shareCoreDataManager];
    self.coreDataArray = [NSMutableArray arrayWithCapacity:0];
    
    self.foodCoreDataManager = [CoreDataManager shareCoreDataManager];
    self.foodCoreDataArray = [NSMutableArray arrayWithCapacity:0];
    

    
    
    [self creatTableView];
    // Do any additional setup after loading the view.
}
- (void)leftButtonAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:236 / 255.0 green:173 / 255.0 blue:158 / 255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MJ_DragonEyeTableViewCell class] forCellReuseIdentifier:@"MJ_DragonEyeTableViewCellIdentifier"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellIdentifier"];
    [self.tableView registerClass:[MJ_DragonFoodDetailTableViewCell class] forCellReuseIdentifier:@"MJ_DragonFoodDetailTableViewCellIdentifier"];
    
    [self.view addSubview:self.tableView];
    
}

//改变头标题字体，背景颜色
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
    footer.backgroundView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:200 / 255.0 blue:150 / 255.0 alpha:1];
//    footer.textLabel.textAlignment = NSTextAlignmentCenter;
    [footer.textLabel setTextColor:[UIColor whiteColor]];
    footer.textLabel.font = [UIFont systemFontOfSize:17];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    
    if (section == 0) {
       return self.coreDataArray.count;
    }
    if (section == 1) {
       
        return self.foodCoreDataArray.count;
    }
    
    return 10;
}


//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.section == 0) {
        
        MJ_DragonEyeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MJ_DragonEyeTableViewCellIdentifier"];
        DragonVideo *video = self.coreDataArray[indexPath.row];
        cell.titleLable.text = video.title;
        [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:video.feed]];
        cell.backgroundColor = [UIColor colorWithRed:190 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1];
        return cell;
    }
   
    if (indexPath.section == 1) {
        
        MJ_DragonFoodDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MJ_DragonFoodDetailTableViewCellIdentifier"];
        DragonEverydayEat *everyDayEat = self.foodCoreDataArray[indexPath.row];
        
        [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:everyDayEat.course_image]];
        cell.nameLable.text = everyDayEat.course_name;
        cell.descLable.text = everyDayEat.course_subject;
        cell.playLable.text = [NSString stringWithFormat:@"%@人做过", everyDayEat.video_watchcount];
        cell.backgroundColor = [UIColor colorWithRed:190 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1];
        return cell;
    }
    
    
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    
    if (section == 0) {
        if (self.coreDataArray.count) {
            return @"目观";
        } else {
            
            return @"目观   (还没有收藏!!)";
        }
        
        
    }
    if (section == 1) {
        
        if (self.foodCoreDataArray.count) {
            return @"日食";
        } else {
            
            return @"日食   (还没有收藏!!)";
        }
        
    }
    
    
    return nil;
}




- (void)viewWillAppear:(BOOL)animated {
     self.tabBarController.tabBar.hidden = NO;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DragonVideo" inManagedObjectContext:self.coreDataManager.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [self.coreDataArray setArray:fetchedObjects];
    
    
    NSFetchRequest *foodFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *foodEntity = [NSEntityDescription entityForName:@"DragonEverydayEat" inManagedObjectContext:self.foodCoreDataManager.managedObjectContext];
    [foodFetchRequest setEntity:foodEntity];
    
    NSError *error1 = nil;
    NSArray *foodFetchedObjects = [self.foodCoreDataManager.managedObjectContext executeFetchRequest:foodFetchRequest error:&error1];
    [self.foodCoreDataArray setArray:foodFetchedObjects];
    [self.tableView reloadData];
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        return 100;
 
    }
    if (indexPath.section == 1) {
        
        return self.view.frame.size.width;
    }
    
    return 100;
}
// cell  点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
            MJ_DragonEyePlayerViewController *playerVC = [[MJ_DragonEyePlayerViewController alloc] init];
            DragonVideo *video = self.coreDataArray[indexPath.row];
            playerVC.dragonVideo = video;
            [self.navigationController pushViewController:playerVC animated:YES];
        
  
    }
    
    if (indexPath.section == 1) {
        
        MJ_DragonPlayerBaseViewController *basePlayerVC = [[MJ_DragonPlayerBaseViewController alloc] init];
        MJ_DragonFoodDetailModel *foodDetailModel = [[MJ_DragonFoodDetailModel alloc] init];
        DragonEverydayEat *everydayEat = self.foodCoreDataArray[indexPath.row];
        
        foodDetailModel.course_video = everydayEat.course_video;
        foodDetailModel.course_name = everydayEat.course_name;
        
        basePlayerVC.foodDetailModel = foodDetailModel;
        
        [self.navigationController pushViewController:basePlayerVC animated:YES];
        
    }
   

}

// 确定编辑的样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
// 控制是否允许编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 完成编辑
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    当状态为删除的时候
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0) {
            DragonVideo *video = self.coreDataArray[indexPath.row];
            [self.coreDataManager.managedObjectContext deleteObject:video];
            [self.coreDataManager saveContext];
            //    删除选中cell对应的数据
            [self.coreDataArray removeObjectAtIndex:indexPath.row];
            
            //        删除选中的Cell
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
        
        if (indexPath.section == 1) {
            DragonEverydayEat *everydayEat = self.foodCoreDataArray[indexPath.row];
            [self.foodCoreDataManager.managedObjectContext deleteObject:everydayEat];
            [self.foodCoreDataManager saveContext];
            
            [self.foodCoreDataArray removeObjectAtIndex:indexPath.row];
            
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
        
        [self.tableView reloadData];
        
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
