//
//  MJ_DragonDownViewController.m
//  DragonVideo
//
//  Created by MJ on 16/4/9.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonDownViewController.h"
#import "MJ_DragonPlayFileViewController.h"

@interface MJ_DragonDownViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *strNameArray;



@end

@implementation MJ_DragonDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction:)];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:190 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1];
    [self getData];
    [self creatTableView];
    
    if (self.strNameArray.count) {
        self.navigationItem.title = @"我的下载";
    } else {
        
        self.navigationItem.title = @"我的下载(还没有下载视频哦！)";
    }
    
 
    // Do any additional setup after loading the view.
}

- (void)leftButtonAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)creatTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:190 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellIdentifier"];
    
    
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
        return self.strNameArray.count;
  

}
//通过tableView自带的数据源协议对相应cell进行赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellIdentifier"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld.%@", indexPath.row + 1, self.strNameArray[indexPath.row]];
//从数组中取出相关数据并赋值
    cell.backgroundColor = [UIColor colorWithRed:190 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1];

    return cell;
}

//获取数据
- (void)getData {
    NSArray  *paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//获取路径
    NSString *docDir = [paths objectAtIndex:0];
    NSFileManager* fm=[NSFileManager defaultManager];
//打开文件管理器
    NSArray *files = [fm subpathsAtPath:docDir];
//把获取的路径下的所有内容装到数组中
    self.strNameArray = [NSMutableArray arrayWithCapacity:0];
    for (NSString *str in files) {
        if ([str hasSuffix:@"mp4"]) {
           
            [self.strNameArray addObject:str];
        }
    }
//利用for in 循环遍历进行筛选排除不需要的文件。
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    MJ_DragonPlayFileViewController *playVC = [[MJ_DragonPlayFileViewController alloc] init];
    playVC.foodURLStr = self.strNameArray[indexPath.row];

    [self.navigationController pushViewController:playVC animated:YES];
   
    
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
    
    
    NSArray  *paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *docDir = [paths objectAtIndex:0];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", docDir, self.strNameArray[indexPath.row]];
    
   
    NSLog(@"          %@      ", filePath);
    //    当状态为删除的时候
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSFileManager * fileManager = [[NSFileManager alloc]init];

        [fileManager removeItemAtPath:filePath error:nil];
        
        //及时改变数组的数量
        [self.strNameArray removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        [self.tableView reloadData];
        
    }
    
    if (self.strNameArray.count) {
        self.navigationItem.title = @"我的下载";
    } else {
        
        self.navigationItem.title = @"我的下载(还没有下载视频哦！)";
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
