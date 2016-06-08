//
//  MJ_DragonWorldViewController.m
//  DragonVideo
//
//  Created by MJ on 16/4/7.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonWorldViewController.h"
#import "MJ_DragonWorldTableViewCell.h"
#import "WJLAFNetworkingTool.h"
#import "MJ_DragonWorldModel.h"

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MJ_DragonAVPlayer.h"
#import "MJ_DragonWorldUrlModel.h"
#import <MBProgressHUD.h>
#import <MJRefresh.h>

@interface MJ_DragonWorldViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) MJ_DragonWorldModel *worldModel;

@property (nonatomic, strong) MJ_DragonAVPlayer *avPlayer;
@property (nonatomic, strong) MJ_DragonWorldUrlModel *urlModel;

@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, assign) NSInteger number;
@property (nonatomic, strong) AVPlayerLayer *layer;

@property (nonatomic, strong) UILabel *headLable;
@property (nonatomic, strong) UILabel *footLabel;
@property (nonatomic, strong) UISlider *playSlider;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *fullButton;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, assign) BOOL isButton;
@property (nonatomic, strong) NSTimer *playTimer;
@property (nonatomic, assign) BOOL isFullButton;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapButtonGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *upSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *downSwipeGestureRecognizer;
@property (nonatomic, assign) BOOL isHideTapButtonGestureRecognizer;
@property (nonatomic, assign) BOOL isHidden;
@property (nonatomic, assign) BOOL isButtton;
@property (nonatomic, assign) float lightValue;
@property (nonatomic, strong) UIButton *outButton;


@end

@implementation MJ_DragonWorldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.navigationItem.title = @"天下";
    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    self.isFullButton = YES;
    self.isHidden = YES;
   
    self.number = -1;
    self.playerView = [[UIView alloc] init];
    
    self.avPlayer = [MJ_DragonAVPlayer shareAVPlayer];
    [self requestData];
    [self creatTableView];
    [self creatControl];
    [self creatGestureRecognizer];
    
    // Do any additional setup after loading the view.
}








- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MJ_DragonWorldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MJ_DragonWorldTableViewCellIdentifier"];
    cell.worldModel = self.dataSource[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (void)creatTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerClass:[MJ_DragonWorldTableViewCell class] forCellReuseIdentifier:@"MJ_DragonWorldTableViewCellIdentifier"];
    [self.view addSubview:self.tableView];


}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.bounds.size.width / 7 * 4 + 3;
}

- (void)requestData {

    [WJLAFNetworkingTool GETNetWithUrl:[NSString stringWithFormat:@"http://api.izhangchu.com/ HTTP/1.1?methodName=CourseSeriesView&series_id=22&version=4.40&"] body:nil headerFile:nil response:MJ_LongJSON success:^(id result) {
        NSArray *array = result[@"data"][@"data"];
        
        for (NSDictionary *dic in array) {
            MJ_DragonWorldModel *worldModel = [[MJ_DragonWorldModel alloc] init];
            [worldModel setValuesForKeysWithDictionary:dic];
            [self.dataSource addObject:worldModel];
        }
        NSLog(@"%@", self.dataSource);
        [self.tableView reloadData];

    } failure:^(NSError *error) {
    }];
    
}

// 画中画
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y >= (self.view.bounds.size.width / 7 * 4 + 3) * self.number - 64 + self.view.bounds.size.width / 7 * 4 + 3 || scrollView.contentOffset.y <= (self.view.bounds.size.width / 7 * 4 + 3) * self.number - self.view.bounds.size.height + 44) {
        [self.view addSubview:self.playerView];
        
        self.playerView.frame = CGRectMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 194, self.view.bounds.size.width / 2, 150);
        self.layer.frame = self.playerView.bounds;
        self.headLable.frame = CGRectMake(0, 0, self.playerView.bounds.size.width, 20);
        self.headLable.font = [UIFont systemFontOfSize:12];
        self.footLabel.frame = CGRectMake(0, self.playerView.bounds.size.height - 30, self.playerView.bounds.size.width, 30);
        self.playSlider.frame = CGRectMake(self.playerView.bounds.size.width * 0.2, self.playerView.bounds.size.height - 25, self.footLabel.bounds.size.width * 0.35, 20);
        self.timeLabel.frame = CGRectMake(self.footLabel.bounds.size.width * 0.55, self.playerView.bounds.size.height - 30, self.footLabel.bounds.size.width * 0.33, 30);
        self.timeLabel.font = [UIFont systemFontOfSize:10];
        self.playButton.frame = CGRectMake(10, self.playerView.bounds.size.height - 28.5, 25, 25);
        self.fullButton.frame = CGRectMake(self.footLabel.bounds.size.width * 0.88, self.playerView.bounds.size.height - 25, 20, 20);
        if (self.number >= 0) {
             self.outButton.hidden = NO;
        }
        self.outButton.frame = CGRectMake(5, 0, 20, 20);
        [self.outButton setImage:[[UIImage imageNamed:@"out"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.outButton addTarget:self action:@selector(outButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.playerView addSubview:self.outButton];
    } else {
        [self creatframe];
        self.outButton.hidden = YES;
        [self.tableView addSubview:self.playerView];
    }
   
}

- (void)outButtonAction:(UIButton *)sender {
    [self.avPlayer pause];
    self.playerView.hidden = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.worldModel = self.dataSource[indexPath.row];
    self.number = indexPath.row;
    self.isButton = NO;
    self.playerView.hidden = NO;
    [self.avPlayer pause];
    [self creatAVPlayer];
    [self creatframe];
    [self creatSlider];
    
    
    
}



- (void)creatControl {
    self.playerView = [[UIView alloc] init];
    
    self.avPlayer = [MJ_DragonAVPlayer shareAVPlayer];
    self.headLable = [[UILabel alloc] init];
    self.footLabel = [[UILabel alloc] init];
    self.playSlider = [[UISlider alloc] init];
    self.timeLabel = [[UILabel alloc] init];
    self.fullButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.playButton = [UIButton buttonWithType:UIButtonTypeSystem];

    self.playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sliderUpdate) userInfo:nil repeats:YES];
    self.outButton = [UIButton buttonWithType:UIButtonTypeSystem];
}

// 播放视频
- (void)creatAVPlayer
{
    self.playerView.backgroundColor = [UIColor whiteColor];
    MJ_DragonWorldModel *model = self.dataSource[self.number];
    
    [self.tableView addSubview:self.playerView];
    [self.avPlayer playWithUrl:model.course_video];
    self.layer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    
    //拉伸播放内容以适应播放窗口
    self.layer.videoGravity = AVLayerVideoGravityResize;
     [self.playerView.layer addSublayer:self.layer];
    
    [self.avPlayer play];
   
}

- (void)creatSlider {
    
    self.headLable.backgroundColor = [UIColor blackColor];
    self.headLable.alpha = 0.5;
    MJ_DragonWorldModel *worldModel = self.dataSource[self.number];

    self.headLable.text = worldModel.course_name;
    
    self.headLable.text = [NSString stringWithFormat:@"        %@", worldModel.course_name];

    self.headLable.textColor = [UIColor whiteColor];
    self.headLable.textAlignment = NSTextAlignmentCenter;
    self.headLable.userInteractionEnabled = YES;
    [self.playerView addSubview:self.headLable];
    
    
    self.footLabel.backgroundColor = [UIColor blackColor];
    self.footLabel.alpha = 0.5;
    self.footLabel.userInteractionEnabled = YES;
    [self.playerView addSubview:self.footLabel];
    
    [self.playSlider setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
    [self.playSlider addTarget:self action:@selector(playSliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.playerView addSubview:self.playSlider];
    
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.playerView addSubview:self.timeLabel];
    
    [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [self.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.playButton.transform = CGAffineTransformMakeRotation(M_PI_2 * 3);
    [self.playerView addSubview:self.playButton];
//    全屏按钮
    [self.fullButton setImage:[[UIImage imageNamed:@"full"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [self.fullButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.playerView addSubview:self.fullButton];
    
    
    
}
// 基本控件的frame
- (void)creatframe {
   self.playerView.frame = CGRectMake(0, (self.view.bounds.size.width / 7 * 4 + 3) * self.number , self.view.bounds.size.width, self.view.bounds.size.width / 7 * 4);
    self.layer.frame = self.playerView.bounds;
    self.headLable.frame = CGRectMake(0, 0, self.playerView.bounds.size.width, 30);
    self.headLable.font = [UIFont systemFontOfSize:20];
    self.footLabel.frame = CGRectMake(0, self.playerView.bounds.size.height - 30, self.playerView.bounds.size.width, 30);
    self.playSlider.frame = CGRectMake(self.playerView.bounds.size.width * 0.1, self.playerView.bounds.size.height - 25, self.footLabel.bounds.size.width * 0.6, 20);
    self.timeLabel.frame = CGRectMake(self.footLabel.bounds.size.width * 0.7, self.playerView.bounds.size.height - 30, self.footLabel.bounds.size.width * 0.2, 30);
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.playButton.frame = CGRectMake(10, self.playerView.bounds.size.height - 28.5, 25, 25);
    self.fullButton.frame = CGRectMake(self.footLabel.bounds.size.width * 0.92, self.playerView.bounds.size.height - 28.5, 25, 25);
    
    self.layer.frame = self.playerView.bounds;
}


- (void)playSliderAction:(UISlider *)slider {
    
    if (self.avPlayer.currentItem.duration.value) {
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.avPlayer seekToTime:CMTimeMakeWithSeconds(self.avPlayer.currentItem.duration.value / self.avPlayer.currentItem.duration.timescale * self.playSlider.value, self.avPlayer.currentTime.timescale) completionHandler:^(BOOL finished) {
                [self.avPlayer play];
                [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
                self.isButton = NO;
            }];
        });
    }
}

// 时间
- (void)sliderUpdate {
    
    self.playSlider.value = CMTimeGetSeconds(self.avPlayer.currentItem.currentTime) / CMTimeGetSeconds(self.avPlayer.currentItem.duration);
    
    CMTime presentTime = self.avPlayer.currentItem.currentTime;
    CMTime totalTime = self.avPlayer.currentItem.duration;
    
    CGFloat presentFloatTim = (CGFloat)presentTime.value / presentTime.timescale;
    CGFloat totalFloatTim = (CGFloat)totalTime.value / totalTime.timescale;
    
    NSDate *presentDate = [NSDate dateWithTimeIntervalSince1970:presentFloatTim];
    NSDate *totalDate = [NSDate dateWithTimeIntervalSince1970:totalFloatTim];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (totalFloatTim / 3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    
    NSString *presentStrTime = [formatter stringFromDate:presentDate];
    NSString *totalStrTime = [formatter stringFromDate:totalDate];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@/%@", presentStrTime, totalStrTime];

}

// 切换全屏按钮的事件
- (void)buttonAction:(UIButton *)sender {
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    self.outButton.hidden = YES;
    if (self.isFullButton) {
        [self.view addSubview:self.playerView];
        self.playerView.frame = CGRectMake((self.view.frame.size.width - self.view.frame.size.height) / 2, (self.view.frame.size.height - self.view.frame.size.width) / 2, self.view.frame.size.height, self.view.frame.size.width);
        self.layer.frame = self.playerView.bounds;
        
        [self.fullButton setImage:[[UIImage imageNamed:@"full2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        self.playerView.transform = CGAffineTransformMakeRotation(M_PI_2);
       self.headLable.frame = CGRectMake(0, 0, self.playerView.bounds.size.width, 40);
        self.footLabel.frame = CGRectMake(0, self.playerView.bounds.size.height - 40, self.playerView.bounds.size.width, 40);
        
        self.playSlider.frame = CGRectMake(self.playerView.bounds.size.width * 0.1, self.playerView.bounds.size.height - 30, self.footLabel.bounds.size.width * 0.63, 20);
        self.timeLabel.frame = CGRectMake(self.playerView.bounds.size.width * 0.73, self.playerView.bounds.size.height - 30, self.playerView.bounds.size.width * 0.2, 20);
        self.timeLabel.font = [UIFont systemFontOfSize:20];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.playButton.frame = CGRectMake(30, self.playerView.bounds.size.height - 40, 40, 40);
        self.fullButton.frame = CGRectMake(self.footLabel.bounds.size.width * 0.93, self.playerView.bounds.size.height - 40, 40, 40);
        
        self.isFullButton = NO;
    } else {
        
        self.navigationController.navigationBarHidden = NO;
        self.tabBarController.tabBar.hidden = NO;
        
        [self.fullButton setImage:[[UIImage imageNamed:@"full"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        self.playerView.transform = CGAffineTransformMakeRotation(M_PI_2 * 4);
        [self creatframe];
        [self.tableView addSubview:self.playerView];
        self.isFullButton = YES;
    }
}

// 手势
- (void)creatGestureRecognizer
{
    //点击轻拍->隐藏view
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    self.tapGestureRecognizer.numberOfTouchesRequired = 1;//定义执行方法需要手指的个数
    self.tapGestureRecognizer.numberOfTapsRequired = 1;//定义执行方法需要轻拍的次数
    
    [self.playerView addGestureRecognizer:self.tapGestureRecognizer];
    
    //轻扫
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerAction:)];
    self.leftSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.playerView addGestureRecognizer:self.leftSwipeGestureRecognizer];
    
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerAction:)];
    self.rightSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.playerView addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    self.upSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerAction:)];
    self.upSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    self.upSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.playerView addGestureRecognizer:self.upSwipeGestureRecognizer];
    
    self.downSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerAction:)];
    self.downSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    self.downSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.playerView addGestureRecognizer:self.downSwipeGestureRecognizer];
    
}

// 点击手势的事件
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    
    if (self.isHidden) {
        [self hide];
        
    } else {
        [self show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self hide];
        });
    }
}

// 所有控件隐藏
- (void)hide {
    self.playButton.hidden = YES;
    self.playSlider.hidden = YES;
    self.timeLabel.hidden = YES;
    self.headLable.hidden = YES;
    self.footLabel.hidden = YES;
    self.fullButton.hidden = YES;
    self.outButton.hidden = YES;
    
    self.isHidden = NO;
}
// 所有控件显示
- (void)show {
    
    self.playButton.hidden = NO;
    self.playSlider.hidden = NO;
    self.timeLabel.hidden = NO;
    self.headLable.hidden = NO;
    self.footLabel.hidden = NO;
    self.fullButton.hidden = NO;
    self.outButton.hidden = NO;

    self.isHidden = YES;
}

- (void)swipeGestureRecognizerAction:(UISwipeGestureRecognizer *)swipe
{
    
    
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionRight: {
            
            self.playSlider.value += 0.05;
            
            if (self.avPlayer.currentItem.duration.value) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.avPlayer seekToTime:CMTimeMakeWithSeconds(self.avPlayer.currentItem.duration.value / self.avPlayer.currentItem.duration.timescale * self.playSlider.value, self.avPlayer.currentTime.timescale) completionHandler:^(BOOL finished) {
                        [self.avPlayer play];
                        
                        [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
                        self.isButtton = NO;
                        
                        
                    }];
                });
            }
            break;
        }
        case UISwipeGestureRecognizerDirectionLeft: {
            
            self.playSlider.value -= 0.05;
            
            if (self.avPlayer.currentItem.duration.value) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.avPlayer seekToTime:CMTimeMakeWithSeconds(self.avPlayer.currentItem.duration.value / self.avPlayer.currentItem.duration.timescale * self.playSlider.value, self.avPlayer.currentTime.timescale) completionHandler:^(BOOL finished) {
                        [self.avPlayer play];
                        
                        [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
                        self.isButtton = NO;
                        
                        
                    }];
                });
            }
            break;
        }
        case UISwipeGestureRecognizerDirectionUp: {
//            self.lightValue += 0.10;
//            [[UIScreen mainScreen] setBrightness:self.lightValue];
            break;
        }
        case UISwipeGestureRecognizerDirectionDown: {
            
//            self.lightValue -= 0.10;
//            [[UIScreen mainScreen] setBrightness:self.lightValue];
//
            
            break;
        }
    }
}




// 播放／暂停按钮事件
- (void)playButtonAction:(UIButton *)sender
{
    if (self.isButton) {
        [self.avPlayer play];
        
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
        self.isButton = NO;
    } else {
        
        [self.avPlayer pause];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        self.isButton = YES;
    }
}


- (void)viewWillDisappear:(BOOL)animated {
    self.playerView.hidden = YES;
    self.outButton.hidden = YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
