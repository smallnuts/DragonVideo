//
//  MJ_DragonEyePlayerViewController.m
//  DragonVideo
//
//  Created by dllo on 16/4/2.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonEyePlayerViewController.h"

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MJ_DragonAVPlayer.h"
#import "MJ_DragonEyePlayInfoModel.h"

#import "CoreDataManager.h"
#import "DragonVideo.h"

@interface MJ_DragonEyePlayerViewController ()

@property (nonatomic, strong) MJ_DragonAVPlayer *avPlayer;
@property (nonatomic, strong) UISlider *playSlider;
@property (nonatomic, strong) UISlider *volumeSlider;
@property (nonatomic, strong) NSTimer *playTimer;
@property (nonatomic, strong) UILabel *playTimeLable;
@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, assign) BOOL isButtton;
@property (nonatomic, strong) UILabel *headLable;
@property (nonatomic, strong) UILabel *footLable;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, assign) BOOL isHidden;
@property (nonatomic, assign) float lightValue;
@property (nonatomic, strong) UIButton *collectButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *definitionButton;
@property (nonatomic, strong) UIButton *definitionCutButton;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) BOOL definitionCut;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapButtonGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *upSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *downSwipeGestureRecognizer;
@property (nonatomic, assign) BOOL isHideTapButtonGestureRecognizer;
@property (nonatomic, strong) CoreDataManager *coreDataManager;
@property (nonatomic, strong) NSMutableArray *coreDataArray;
@property (nonatomic, assign) BOOL iscollect;
@property (nonatomic, strong) UIButton *lockButton;
@property (nonatomic, strong) UILabel *downloadlable;
@property (nonatomic, assign) BOOL isDown;
@property (nonatomic, strong) NSArray *arr;//存放收藏后的高清／标清
@property (nonatomic, strong) NSMutableArray *strNameArray;//存放搜索以下载的
@property (nonatomic, strong) UIProgressView *videoProgressView;
@property (nonatomic, assign) CGFloat totalDuration;
@property (nonatomic, assign) NSTimeInterval timeInterval;

@end

@implementation MJ_DragonEyePlayerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.isHidden = YES;

//    获取系统屏幕当前的亮度值
    self.lightValue = [UIScreen mainScreen].brightness;
    
    self.coreDataManager = [CoreDataManager shareCoreDataManager];
    self.coreDataArray = [NSMutableArray arrayWithCapacity:0];
    
    [self creatAVPlayer];
    [self creatSlider];
    [self creatAnyControlView];
    [self creatGestureRecognizer];
}

// 手势
- (void)creatGestureRecognizer
{
    //点击轻拍->隐藏view
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    self.tapGestureRecognizer.numberOfTouchesRequired = 1;//定义执行方法需要手指的个数
    self.tapGestureRecognizer.numberOfTapsRequired = 1;//定义执行方法需要轻拍的次数
    
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    
    //轻扫
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerAction:)];
    self.leftSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerAction:)];
    self.rightSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    self.upSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerAction:)];
    self.upSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    self.upSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:self.upSwipeGestureRecognizer];
    
    self.downSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizerAction:)];
    self.downSwipeGestureRecognizer.numberOfTouchesRequired = 1;
    self.downSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:self.downSwipeGestureRecognizer];
    
}
// 轻扫手势的事件
- (void)swipeGestureRecognizerAction:(UISwipeGestureRecognizer *)swipe
{
    
    
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionRight: {
            self.lightValue += 0.05;
//            设置系统屏幕的亮度值
            [[UIScreen mainScreen] setBrightness:self.lightValue];
            
            NSLog(@"右");
            break;
        }
        case UISwipeGestureRecognizerDirectionLeft: {
            self.lightValue -= 0.05;
//            设置系统屏幕的亮度值
            [[UIScreen mainScreen] setBrightness:self.lightValue];
            
            NSLog(@"左");
            break;
        }
        case UISwipeGestureRecognizerDirectionUp: {
            self.playSlider.value -= 0.025;
            
            if (self.avPlayer.currentItem.duration.value) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.avPlayer seekToTime:CMTimeMakeWithSeconds(self.avPlayer.currentItem.duration.value / self.avPlayer.currentItem.duration.timescale * self.playSlider.value, self.avPlayer.currentTime.timescale) completionHandler:^(BOOL finished) {
                        [self.avPlayer play];
                        
                        [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
                        self.isButtton = NO;
                        
                        
                    }];
                });
            }
            NSLog(@"上");
            break;
        }
        case UISwipeGestureRecognizerDirectionDown: {
            self.playSlider.value += 0.025;
            
            if (self.avPlayer.currentItem.duration.value) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.avPlayer seekToTime:CMTimeMakeWithSeconds(self.avPlayer.currentItem.duration.value / self.avPlayer.currentItem.duration.timescale * self.playSlider.value, self.avPlayer.currentTime.timescale) completionHandler:^(BOOL finished) {
                        [self.avPlayer play];
                        
                        [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
                        self.isButtton = NO;
                        
                    }];
                });
            }
            
            NSLog(@"下");
            break;
        }
    }
    
    
    
}
// 所有控件隐藏
- (void)hide {
    self.playButton.hidden = YES;
    self.playSlider.hidden = YES;
    self.timeLable.hidden = YES;
    self.playTimeLable.hidden = YES;
    self.headLable.hidden = YES;
    self.footLable.hidden = YES;
    self.arrowButton.hidden = YES;
    self.volumeSlider.hidden = YES;
    self.definitionButton.hidden = YES;
    self.collectButton.hidden = YES;
    self.shareButton.hidden = YES;
    self.lockButton.hidden = YES;
    self.videoProgressView.hidden = YES;
    self.isHidden = NO;
}
// 所有控件显示
- (void)show {
    
    self.playButton.hidden = NO;
    self.playSlider.hidden = NO;
    self.timeLable.hidden = NO;
    self.playTimeLable.hidden = NO;
    self.headLable.hidden = NO;
    self.footLable.hidden = NO;
    self.arrowButton.hidden = NO;
    self.volumeSlider.hidden = NO;
    self.definitionButton.hidden = NO;
    self.collectButton.hidden = NO;
    self.shareButton.hidden = NO;
    self.lockButton.hidden = NO;
    self.videoProgressView.hidden = NO;
    self.isHidden = YES;
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
// 播放视频
- (void)creatAVPlayer
{
    
    self.avPlayer = [MJ_DragonAVPlayer shareAVPlayer];
    if (self.dragonVideo) {
        [self.avPlayer playWithUrl:self.dragonVideo.playUrl];
        
    }else {
    [self.avPlayer playWithUrl:self.dataModel.playUrl];
    }
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    
    layer.frame = self.view.frame;
    
    layer.frame = CGRectMake((self.view.frame.size.width - self.view.frame.size.height) / 2, (self.view.frame.size.height - self.view.frame.size.width) / 2, self.view.frame.size.height, self.view.frame.size.width);
    
    layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
    //拉伸播放内容以适应播放窗口
    layer.videoGravity = AVLayerVideoGravityResize;
    
    [self.view.layer addSublayer:layer];
    
    //    self.avPlayer.volume = 5.0f;
    [self.avPlayer play];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self hide];
    });
    
}
// slider滑动条
- (void)creatSlider
{
    
    
    self.footLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, self.view.frame.size.height)];
    
    self.footLable.backgroundColor = [UIColor blackColor];
    self.footLable.alpha = 0.5;
    self.footLable.userInteractionEnabled = YES;
    [self.view addSubview:self.footLable];
//   添加缓冲条
    self.videoProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.videoProgressView.frame = CGRectMake(0, 0, self.view.bounds.size.height * 0.7, 20);
    self.videoProgressView.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.videoProgressView.center = CGPointMake(20, self.view.center.y +  self.view.frame.size.height *0.05);
    self.videoProgressView.backgroundColor = [UIColor clearColor];
    self.videoProgressView.progressTintColor = [UIColor cyanColor];
    [self.view addSubview:self.videoProgressView];
    
    self.playSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height * 0.73, 20)];
    self.playSlider.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.playSlider.center = CGPointMake(20, self.view.center.y + self.view.frame.size.height * 0.05);
    self.playSlider.maximumTrackTintColor = [UIColor clearColor];
    [self.playSlider setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
    [self.playSlider addTarget:self action:@selector(playSliderAction:) forControlEvents:UIControlEventValueChanged];
//    *****************************************************
//     定时器  （1秒钟 调用一次sliderUpdate方法）
    self.playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sliderUpdate) userInfo:nil repeats:YES];
    
    
    [self.view addSubview:self.playSlider];
    
    
    self.volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 20, self.view.frame.size.width / 3 * 2, 20)];
    self.volumeSlider.center = CGPointMake(self.view.center.x, self.view.frame.size.height - 20);
    
    [self.volumeSlider addTarget:self action:@selector(volumeSliderAction:) forControlEvents:UIControlEventValueChanged];
    self.volumeSlider.minimumValue = 0.0f;
    self.volumeSlider.maximumValue = 8.0f;
    self.volumeSlider.value = 3.0f;
    [self.volumeSlider setThumbImage:[UIImage imageNamed:@"volume"] forState:UIControlStateNormal];
    
    [self.view addSubview:self.volumeSlider];
    
    
}
// 音量slider事件
- (void)volumeSliderAction:(UISlider *)slider {
    self.avPlayer.volume = slider.value;
}
//  时间
- (void)sliderUpdate
{
    self.playSlider.value = CMTimeGetSeconds(self.avPlayer.currentItem.currentTime) / CMTimeGetSeconds(self.avPlayer.currentItem.duration);
//    当前的／ 总的
    CMTime presentTime = self.avPlayer.currentItem.currentTime;
    CMTime totalTime = self.avPlayer.currentItem.duration;
    
    CGFloat presentFloatTim = (CGFloat)presentTime.value/presentTime.timescale;
    CGFloat totalFloatTim = (CGFloat)totalTime.value / totalTime.timescale;
    
    NSDate *presentDate = [NSDate dateWithTimeIntervalSince1970:presentFloatTim];
    NSDate *totalDate = [NSDate dateWithTimeIntervalSince1970:totalFloatTim];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (totalFloatTim / 3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    }else {
        [formatter setDateFormat:@"m:ss"];
    }
    
    NSString *presentStrTime = [formatter stringFromDate:presentDate];
    NSString *totalStrTime = [formatter stringFromDate:totalDate];
    
    self.timeLable.text = [NSString stringWithFormat:@"%@", totalStrTime];
    self.playTimeLable.text = [NSString stringWithFormat:@"%@", presentStrTime];
    
////    缓冲条
////    计算缓冲进度
//    self.timeInterval = [self availableDuration];
////     缓冲条的总长度
//   self.totalDuration = CMTimeGetSeconds(totalTime);
//    //    缓冲的百分比timeInterval / totalDuraation
//    [self.videoProgressView setProgress:self.timeInterval / self.totalDuration animated:YES];
//    
//    NSString *str = [NSString stringWithFormat:@"%f", self.totalDuration];
//    
//    if ([str isEqualToString:@"nan"]) {
//        self.totalDuration = 1;
//    }
//    
//    NSString *stri = [NSString stringWithFormat:@"%f", self.timeInterval];
//    if ([stri isEqualToString:@"nan"]) {
//        self.timeInterval = 0;
//    }

    
    self.totalDuration = CMTimeGetSeconds(totalTime);
    
    NSString *str = [NSString stringWithFormat:@"%f", self.totalDuration];
    
    if ([str isEqualToString:@"nan"]) {
        self.totalDuration = 1;
    }
    
    self.timeInterval = [self availableDuration];// 计算缓冲进度
    
    NSString *stri = [NSString stringWithFormat:@"%f", self.timeInterval];
    if ([stri isEqualToString:@"nan"]) {
        self.timeInterval = 0;
    }
    
    
    [self.videoProgressView setProgress:self.timeInterval / self.totalDuration animated:YES];
    

    if ([presentStrTime isEqualToString:totalStrTime]) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    

}
// 缓冲事件
- (NSTimeInterval)availableDuration {
    
    NSArray *loadedTimeRanges = [[self.avPlayer currentItem] loadedTimeRanges];
    
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    
    return result;
}

// 播放slider事件
- (void)playSliderAction:(UISlider *)slider
{
    
    if (self.avPlayer.currentItem.duration.value) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            [self.avPlayer seekToTime:CMTimeMakeWithSeconds(self.avPlayer.currentItem.duration.value / self.avPlayer.currentItem.duration.timescale * self.playSlider.value, self.avPlayer.currentTime.timescale) completionHandler:^(BOOL finished) {
                [self.avPlayer play];
                
                [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
                self.isButtton = NO;
                
                
            }];
        });
    }

}
// 基本控件
- (void)creatAnyControlView
{
    self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height - self.view.bounds.size.height * 0.1, self.view.bounds.size.height * 0.1, 20)];
    self.timeLable.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.timeLable.center = CGPointMake(self.playSlider.center.x, self.view.frame.size.height * 0.95);
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    self.timeLable.textColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1];
    self.timeLable.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.timeLable];
    
    self.playTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height - self.view.bounds.size.height * 0.1, self.view.bounds.size.height * 0.1, 20)];
    self.playTimeLable.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.playTimeLable.center = CGPointMake(self.playSlider.center.x, self.view.frame.size.height * 0.15);
    self.playTimeLable.textAlignment = NSTextAlignmentCenter;
    self.playTimeLable.textColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1];
    self.playTimeLable.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.playTimeLable];
    
    self.playButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.playButton.frame = CGRectMake(0, 0, 35, 35);
    self.playButton.center = CGPointMake(self.playSlider.center.x, self.view.frame.size.height * 0.05 + 20);
    
    [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    //添加事件
    [self.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.playButton];
    
    
    self.headLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, 50)];
    self.headLable.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.headLable.center = CGPointMake(self.view.frame.size.width - 25, self.view.center.y);
    self.headLable.backgroundColor = [UIColor blackColor];
    self.headLable.textAlignment = NSTextAlignmentLeft;
    
    self.headLable.textColor = [UIColor whiteColor];
    self.headLable.alpha = 0.5;
    
    if (self.dragonVideo) {
        self.headLable.text =[NSString stringWithFormat:@"                %@", self.dragonVideo.title];
    } else {
        self.headLable.text =[NSString stringWithFormat:@"                %@", self.dataModel.title];
    }
    
    
    [self.view addSubview:self.headLable];
    
    
    self.arrowButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.arrowButton.frame = CGRectMake(100, 20, 40, 40);
    //设置标题 （返回按钮）
    [self.arrowButton setBackgroundImage:[UIImage imageNamed:@"toparrow"] forState:UIControlStateNormal];
    //添加事件
    [self.arrowButton addTarget:self action:@selector(topArrowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.arrowButton.center = CGPointMake(self.headLable.center.x, 50);
    
    [self.view addSubview:self.arrowButton];
    
//    清晰度
    self.definitionButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.definitionButton.frame = CGRectMake(0, 0, 40, 40);
    //设置标题
    [self.definitionButton setTitle:@"高清" forState:UIControlStateNormal];
    self.definitionCut = YES;
    [self.definitionButton setTintColor:[UIColor whiteColor]];
    self.definitionButton.transform = CGAffineTransformMakeRotation(M_PI_2);
    //添加事件
    [self.definitionButton addTarget:self action:@selector(topArrowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.definitionButton.center = CGPointMake(self.headLable.center.x, self.view.frame.size.height * 0.75);
    
    [self.view addSubview:self.definitionButton];
    
//   清晰度切换
    self.definitionCutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.definitionCutButton.frame = CGRectMake(0, 0, 40, 40);
    //设置标题
    [self.definitionCutButton setTitle:@"标清" forState:UIControlStateNormal];
    [self.definitionCutButton setTintColor:[UIColor whiteColor]];
    self.definitionCutButton.transform = CGAffineTransformMakeRotation(M_PI_2);
    //添加事件
    [self.definitionCutButton addTarget:self action:@selector(topArrowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.definitionCutButton.center = CGPointMake(self.headLable.center.x - 50, self.view.frame.size.height * 0.75);
    [self.view addSubview:self.definitionCutButton];
    self.definitionCutButton.hidden = YES;
    
//    收藏按钮
    self.collectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.collectButton.frame = CGRectMake(0, 0, 30, 30);
    //设置标题
    [self.collectButton setBackgroundImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    self.collectButton.transform = CGAffineTransformMakeRotation(M_PI_2);
    //添加事件
    [self.collectButton addTarget:self action:@selector(topArrowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.collectButton.center = CGPointMake(self.headLable.center.x, self.view.frame.size.height * 0.85);
    
    [self.view addSubview:self.collectButton];
    
//    下载按钮
    self.shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.shareButton.frame = CGRectMake(0, 0, 30, 30);
    //设置标题
    [self.shareButton setBackgroundImage:[UIImage imageNamed:@"downOK"] forState:UIControlStateNormal];
    //添加事件
    [self.shareButton addTarget:self action:@selector(topArrowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.shareButton.center = CGPointMake(self.headLable.center.x, self.view.frame.size.height * 0.93);
    
    [self.view addSubview:self.shareButton];
//    锁屏按钮
    self.lockButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.lockButton.frame = CGRectMake(100, 20, 25, 25);
    [self.lockButton setBackgroundImage:[UIImage imageNamed:@"unlock"] forState:UIControlStateNormal];
    //添加事件
    [self.lockButton addTarget:self action:@selector(lockButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.lockButton.center = CGPointMake(self.view.center.x, 50);
    
    [self.view addSubview:self.lockButton];
    
    
}
// 锁屏按钮的事件
- (void)lockButtonAction:(UIButton *)sender
{
    if (self.isHidden) {
        [self hide];
        [self.view removeGestureRecognizer:self.tapGestureRecognizer];
        [self.view removeGestureRecognizer:self.leftSwipeGestureRecognizer];
        [self.view removeGestureRecognizer:self.rightSwipeGestureRecognizer];
        [self.view removeGestureRecognizer:self.upSwipeGestureRecognizer];
        [self.view removeGestureRecognizer:self.downSwipeGestureRecognizer];
        [self.lockButton setBackgroundImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.lockButton.hidden = YES;
        
            });
        
        self.tapButtonGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapButtonGestureRecognizerAction:)];
        
        self.tapButtonGestureRecognizer.numberOfTouchesRequired = 1;//定义执行方法需要手指的个数
        self.tapButtonGestureRecognizer.numberOfTapsRequired = 1;//定义执行方法需要轻拍的次数
        
        [self.view addGestureRecognizer:self.tapButtonGestureRecognizer];
        
        self.isHidden = NO;
    } else {
        [self creatGestureRecognizer];
        self.lockButton.hidden = YES;
        [self show];
        [self.view removeGestureRecognizer:self.tapButtonGestureRecognizer];
        [self.lockButton setBackgroundImage:[UIImage imageNamed:@"unlock"] forState:UIControlStateNormal];
        self.isHidden = YES;
    }
}
// 锁屏后加的点击手势
- (void)tapButtonGestureRecognizerAction:(UITapGestureRecognizer *)tap
{
    if (self.isHideTapButtonGestureRecognizer) {
        
        self.lockButton.hidden = YES;
        self.isHideTapButtonGestureRecognizer = NO;
        
    } else {
        
        self.lockButton.hidden = NO;
        self.isHideTapButtonGestureRecognizer = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.lockButton.hidden = YES;
            self.isHideTapButtonGestureRecognizer = NO;
            
        });
    }
}

// 返回按钮事件 / 按钮点击事件
- (void)topArrowButtonAction:(UIButton *)sender
{
//   返回按钮
    if (sender == self.arrowButton) {
        [self.avPlayer pause];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
//   切换清晰度按钮
    if (sender == self.definitionButton) {
        if (self.dragonVideo) {
            if (self.dragonVideo.highUrl) {
                self.arr = [[NSArray alloc] initWithObjects:self.dragonVideo.markUrl, self.dragonVideo.highUrl, nil];
               
                if (self.arr.count == 2) {
                if (self.isHidden) {
                    self.definitionCutButton.hidden = NO;
                    self.isHidden = NO;
                } else {
                    self.definitionCutButton.hidden = YES;
                    self.isHidden = YES;
                }
            }
        }
        }
    
        if (self.dataModel.playInfo.count == 2) {
            if (self.isHidden) {
                self.definitionCutButton.hidden = NO;
                self.isHidden = NO;
            } else {
                self.definitionCutButton.hidden = YES;
                self.isHidden = YES;
            }
        }
    }
    
    if (sender == self.definitionCutButton) {
        
        if (self.dragonVideo) {
            
            self.array = [NSMutableArray arrayWithArray:self.arr];
        } else {
            self.array = [NSMutableArray arrayWithCapacity:0];
        for (MJ_DragonEyePlayInfoModel *infoModel in self.dataModel.playInfo) {
            [self.array addObject:infoModel.url];
        }
        }
        if (self.definitionCut) {
            [self.definitionButton setTitle:@"标清" forState:UIControlStateNormal];
            [self.definitionCutButton setTitle:@"高清" forState:UIControlStateNormal];
            
            [self.avPlayer playWithUrl:self.array[0]];
            [self.avPlayer play];
            self.definitionCut = NO;
        } else {
            [self.definitionButton setTitle:@"高清" forState:UIControlStateNormal];
            [self.definitionCutButton setTitle:@"标清" forState:UIControlStateNormal];
           
            [self.avPlayer playWithUrl:self.array[1]];
            [self.avPlayer play];
            self.definitionCut = YES;
        }
        self.definitionCutButton.hidden = YES;
        self.isHidden = YES;
    }
// 收藏按钮
    if (sender == self.collectButton) {

        if (self.iscollect) {
            [self.collectButton setBackgroundImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"DragonVideo" inManagedObjectContext:self.coreDataManager.managedObjectContext];
            [fetchRequest setEntity:entity];
            
            NSError *error = nil;
            NSArray *fetchedObjects = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
            [self.coreDataArray setArray:fetchedObjects];

            if (self.dragonVideo) {
                
                for (DragonVideo *video in self.coreDataArray) {
                    
                    if (video.dataId.integerValue == self.dragonVideo.dataId.integerValue) {
                        [self.coreDataManager.managedObjectContext deleteObject:video];
                        [self.coreDataManager saveContext];
                    }
                }
                
            } else {
            
            for (DragonVideo *video in self.coreDataArray) {
                if (self.dataModel.dataId.integerValue == video.dataId.integerValue) {
                    [self.coreDataManager.managedObjectContext deleteObject:video];
                    [self.coreDataManager saveContext];
                }
            }
                
         }
            self.iscollect = 0;
        } else {
            
            [self.collectButton setBackgroundImage:[UIImage imageNamed:@"collect2"] forState:UIControlStateNormal];
            DragonVideo *dragonVideo = [NSEntityDescription insertNewObjectForEntityForName:@"DragonVideo" inManagedObjectContext:self.coreDataManager.managedObjectContext];
            dragonVideo.title = self.dataModel.title;
            dragonVideo.dataId = self.dataModel.dataId;
            dragonVideo.feed = self.dataModel.coverModel.feed;
            dragonVideo.playUrl = self.dataModel.playUrl;
            
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
            if (self.dataModel.playInfo.count == 2) {
                for (MJ_DragonEyePlayInfoModel *infoModel in self.dataModel.playInfo) {
                    [array addObject:infoModel.url];
                }
                dragonVideo.markUrl = array[0];
                dragonVideo.highUrl = array[1];
            }
            
            [self.coreDataManager saveContext];
            self.iscollect = 1;
        }
    }
//   下载按钮
    if (sender == self.shareButton) {
        
        if (self.isDown) {
            self.downloadlable.hidden = NO;
            self.downloadlable.text = @"已经下载";
            [self.view addSubview:self.downloadlable];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.downloadlable.hidden = YES;
                
            });
            
        } else {
            [self.view addSubview:self.downloadlable];
            [self.shareButton setBackgroundImage:[UIImage imageNamed:@"downOK"] forState:UIControlStateNormal];
            self.downloadlable.hidden = NO;
              self.isDown = YES;
             self.downloadlable.text = @"开始下载";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              
                self.downloadlable.hidden = YES;
            });
        
        NSURL *url = [NSURL URLWithString:self.dataModel.playUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDownloadTask *downLoad = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 如果要保存文件,需要将文件保存至沙盒
            // 1. 根据URL获取到下载的文件名
            NSString *fileName = [self.dataModel.title lastPathComponent];
            // 2. 生成沙盒的路径
            NSArray *docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            
            NSString *path = [docs[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", fileName]];
            NSLog(@"路径  %@", path);
            
            NSURL *toURL = [NSURL fileURLWithPath:path];
            // 3. 将文件从临时文件夹复制到沙盒,在iOS中所有的文件操作都是使用NSFileManager
            [[NSFileManager defaultManager] copyItemAtURL:location toURL:toURL error:nil];
            
            // 4. 显示下载完成lable
            dispatch_async(dispatch_get_main_queue(), ^{
                self.downloadlable.hidden = NO;
              self.downloadlable.text = @"下载成功";
                self.shareButton.transform = CGAffineTransformMakeRotation(M_PI_2 * 4);
                
                
                //延时之行一段代码
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    self.downloadlable.hidden = YES;
                });
                
            });
        }];
        //4.因为任务默认是挂起状态，需要恢复任务（执行任务）
        [downLoad resume];
    }
    
  }
}
// 播放／暂停按钮事件
- (void)playButtonAction:(UIButton *)sender
{
    if (self.isButtton) {
        [self.avPlayer play];

        [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
        self.isButtton = NO;
    } else {
        
        [self.avPlayer pause];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        self.isButtton = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"DragonVideo" inManagedObjectContext:self.coreDataManager.managedObjectContext];
        [fetchRequest setEntity:entity];
    
        NSError *error = nil;
        NSArray *fetchedObjects = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
            [self.coreDataArray setArray:fetchedObjects];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    for (DragonVideo *video in self.coreDataArray) {
        if (self.dataModel.dataId.integerValue == video.dataId.integerValue) {
            [array addObject:video.dataId];
        }
    }
    if (array.count > 0 || self.dragonVideo) {
        [self.collectButton setBackgroundImage:[UIImage imageNamed:@"collect2"] forState:UIControlStateNormal];
        self.iscollect = YES;
    } else {
        self.iscollect = NO;
       
    }
    
    self.downloadlable = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    
    self.downloadlable.textAlignment = NSTextAlignmentCenter;
    self.downloadlable.alpha = 0.5;
    self.downloadlable.backgroundColor = [UIColor blackColor];
    self.downloadlable.textColor = [UIColor whiteColor];
    self.downloadlable.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.downloadlable.center = CGPointMake(self.view.center.x, self.view.center.y);
    self.downloadlable.layer.masksToBounds = YES;
    self.downloadlable.layer.cornerRadius = 10;
    
    [self getData];
    
    for (int i = 0; i < self.strNameArray.count; i++) {
        if ([self.dataModel.title isEqualToString:self.strNameArray[i]]) {
            [self.shareButton setBackgroundImage:[UIImage imageNamed:@"downOK"] forState:UIControlStateNormal];
            self.shareButton.transform = CGAffineTransformMakeRotation(M_PI_2 * 4);
            self.isDown = YES;
            break;
        } else {
            
            [self.shareButton setBackgroundImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
            self.isDown = NO;
            
        }
    }
    
    
}

- (void)getData {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *docDir = [paths objectAtIndex:0];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSArray *files = [fm subpathsAtPath:docDir];
    
    self.strNameArray = [NSMutableArray arrayWithCapacity:0];
    for (NSString *str in files) {
        if ([str hasSuffix:@".mp4"]) {
            NSString *string = [str substringToIndex:str.length - 4];
            [self.strNameArray addObject:string];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;   
}

//单独定制白色电池条
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

// 电池条隐藏

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

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
