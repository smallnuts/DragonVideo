//
//  MJ_DragonMYViewController.m
//  DragonVideo
//
//  Created by MJ on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonMYViewController.h"
#import "MJ_DragonMYTableViewCell.h"
#import "CleanCaches.h"
#import "MJ_DragonMYFavoritesViewController.h"
#import "MJ_DragonDownViewController.h"

@interface MJ_DragonMYViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *messageStr;

@end

@implementation MJ_DragonMYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"MY";
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:190 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1], NSForegroundColorAttributeName, [UIFont systemFontOfSize:20], NSFontAttributeName,nil]];
    self.messageStr = [CleanCaches folderSizeAtPath];
    
    [self creatTableView];
    
    // Do any additional setup after loading the view.
}




- (void)creatTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backGroundImage"]];
    
    //  创建需要的毛玻璃特效类型
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    //  毛玻璃view 视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //添加到要有毛玻璃特效的控件中
    effectView.frame = self.view.bounds;
    [self.tableView.backgroundView addSubview:effectView];
    //设置模糊透明度
    effectView.alpha = 0.70f;
    
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / 2)];
    headImageView.image = [UIImage imageNamed:@"headImageView"];
    self.tableView.tableHeaderView = headImageView;
    
    
    
    [self.tableView registerClass:[MJ_DragonMYTableViewCell class] forCellReuseIdentifier:@"MJ_DragonMYTableViewCellIdentifier"];
    
    
    [self.view addSubview:self.tableView];
}



//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        MJ_DragonMYFavoritesViewController *favoritesVC = [[MJ_DragonMYFavoritesViewController alloc] init];
        
        [self.navigationController pushViewController:favoritesVC animated:YES];
    }
    
    
    if (indexPath.row == 1) {
        MJ_DragonDownViewController *downVC = [[MJ_DragonDownViewController alloc] init];
        
        [self.navigationController pushViewController:downVC animated:YES];
    }
    
    if (indexPath.row == 2) {
        
        self.messageStr = [CleanCaches folderSizeAtPath];
        NSString *str = [NSString stringWithFormat:@"是否清除缓存%@", self.messageStr];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            self.messageStr = [CleanCaches cleanCachesAtPath];
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:sure];
        [alertController addAction:cancel];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
    }
    if (indexPath.row == 3) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"作者" message:@"QQ:974688925" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        
//        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
        
        
        [alertController addAction:sure];
//        [alertController addAction:cancel];
        
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        
    }

    
   
    
    
    
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

















//返回数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 4;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MJ_DragonMYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MJ_DragonMYTableViewCellIdentifier"];
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row == 0) {
        cell.titleLable.text = @"我的收藏";
        return cell;
    }
    if (indexPath.row == 1) {
        cell.titleLable.text = @"我的下载";
        return cell;
    }
    if (indexPath.row == 2) {
        cell.titleLable.text = @"清除缓存";
        return cell;
    }
    if (indexPath.row == 3) {
        cell.titleLable.text = @"联系我哦";
        return cell;
    }
    
    
    
    return cell;
}



-(void)cleanAction
{
    //获取完整路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    NSString *cachePath = [path stringByAppendingPathComponent:@"caches"];
    NSLog(@"%@", cachePath);
    
    NSFileManager *manage = [NSFileManager defaultManager];
    if ([manage fileExistsAtPath:cachePath]) {
        NSArray *fileNameArray = [manage subpathsAtPath:cachePath];
        for (NSString *fileName in fileNameArray) {
            //拼接绝对路径
            NSString *absolutePath = [cachePath stringByAppendingPathComponent:fileName];
            //通过文件管理者删除文件
            [manage removeItemAtPath:absolutePath error:nil];
        }
    }
    
    //及时更新label上文件的大小
    self.messageStr = [NSString stringWithFormat:@"%.2fM", [self folderSizeAtPath:cachePath]];
}

-(long long)fileSizeAtPath:(NSString *)path
{
    //创建一个文件管理者
    NSFileManager *manage = [NSFileManager defaultManager];
    if ([manage fileExistsAtPath:path]) {
        return [[manage attributesOfItemAtPath:path error:nil] fileSize];
    }
    return 0;
}

-(float)folderSizeAtPath:(NSString *)path
{
    //创建文件管理者
    NSFileManager *manage = [NSFileManager defaultManager];
    if (![manage fileExistsAtPath:path]) {
        return 0;
    }
    //根据路径获取文件夹里面的元素集合
    //获取集合类型的枚举器
    NSEnumerator *enumrator = [[manage subpathsAtPath:path] objectEnumerator];
    //每次遍历得到的文件名
    NSString *fileName = [NSString string];
    //文件夹大小
    float folderSize = 0;
    while ((fileName = [enumrator nextObject]) != nil) {
        NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:absolutePath];
    }
    
    return folderSize / (1024.0 * 1024.0);
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
