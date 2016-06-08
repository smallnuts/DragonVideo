//
//  MJ_DragonGuideViewController.m
//  DragonVideo
//
//  Created by MJ on 16/4/14.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonGuideViewController.h"

#define w [UIScreen mainScreen].bounds.size.width
#define h [UIScreen mainScreen].bounds.size.height

@interface MJ_DragonGuideViewController ()

@end

@implementation MJ_DragonGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createGuide];
    // Do any additional setup after loading the view.
}


- (void)createGuide {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    [scrollView setContentSize:CGSizeMake(w * 4, 0)];
    [scrollView setPagingEnabled:YES];  //视图整页显示
    [scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    scrollView.showsHorizontalScrollIndicator = NO;
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    [imageview setImage:[UIImage imageNamed:@"ii1"]];
    [scrollView addSubview:imageview];
   
    
    UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(w, 0, w, h)];
    [imageview1 setImage:[UIImage imageNamed:@"ii2"]];
    [scrollView addSubview:imageview1];
   
    
    UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(w * 2, 0, w, h)];
    [imageview2 setImage:[UIImage imageNamed:@"ii3"]];
    [scrollView addSubview:imageview2];
    
    
    UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(w * 3, 0, w, h)];
    [imageview3 setImage:[UIImage imageNamed:@"ii4"]];
    imageview3.userInteractionEnabled = YES;    //打开imageview3的用户交互;否则下面的button无法响应
    [scrollView addSubview:imageview3];
    
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"开始使用" forState:UIControlStateNormal];
    
    [button setFrame:CGRectMake((self.view.frame.size.width - self.view.frame.size.width * 200 / 414) / 2, self.view.frame.size.height * 630 / 736, self.view.frame.size.width * 200 / 414, self.view.frame.size.width * 50 / 736)];
    button.layer.cornerRadius = 8.0;
    button.tintColor = [UIColor whiteColor];
    button.backgroundColor = [UIColor colorWithRed:190 / 255.0 green:231 / 255.0 blue:233 / 255.0 alpha:1];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [imageview3 addSubview:button];
    
    [self.view addSubview:scrollView];
    
    
    
}

- (void)buttonAction:(UIButton *)sender {
   
   
    [self.delegate jump];
    
    
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
