//
//  MJ_DragonPlayFileViewController.m
//  DragonVideo
//
//  Created by MJ on 16/4/9.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonPlayFileViewController.h"

#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MJ_DragonPlayFileViewController ()

@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) UISlider *playSlider;
@property (nonatomic, strong) UISlider *volumeSlider;
@property (nonatomic, strong) NSTimer *playTimer;
@property (nonatomic, strong) UILabel *timeLable;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, assign) BOOL isButtton;
@property (nonatomic, strong) UILabel *headLable;
@property (nonatomic, strong) UILabel *footLable;
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, assign) BOOL isHidden;
@property (nonatomic, assign) float lightValue;
@property (nonatomic, strong) UILabel *downloadlable;
@property (nonatomic, strong) UIButton *lockButton;
@property (nonatomic, strong) UIButton *openLockButton;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *tapButtonGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *upSwipeGestureRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *downSwipeGestureRecognizer;
@property (nonatomic, assign) BOOL isHideTapButtonGestureRecognizer;

@end

@implementation MJ_DragonPlayFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHidden = YES;
    self.lightValue = [UIScreen mainScreen].brightness;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatAVPlayer];
    [self creatSlider];
    [self creatAnyControlView];
    [self creatGestureRecognizer];
    [self hideView];
    // Do any additional setup after loading the view.
}

- (void)hide {
    self.playButton.hidden = YES;
    self.playSlider.hidden = YES;
    self.timeLable.hidden = YES;
    self.headLable.hidden = YES;
    self.footLable.hidden = YES;
    self.arrowButton.hidden = YES;
    self.volumeSlider.hidden = YES;
    self.lockButton.hidden = YES;
    
    self.isHidden = NO;
}

- (void)show {
    
    self.playButton.hidden = NO;
    self.playSlider.hidden = NO;
    self.timeLable.hidden = NO;
    self.headLable.hidden = NO;
    self.footLable.hidden = NO;
    self.arrowButton.hidden = NO;
    self.volumeSlider.hidden = NO;
    self.lockButton.hidden = NO;
    
    self.isHidden = YES;
    
    
}

//hideView
- (void) hideView {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self hide];
        
    });
   
}


//手势
- (void)creatGestureRecognizer
{
    //点击轻拍->隐藏view
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
    
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

- (void)swipeGestureRecognizerAction:(UISwipeGestureRecognizer *)swipe
{
    
    
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionRight: {
            self.lightValue += 0.08;
            [[UIScreen mainScreen] setBrightness:self.lightValue];
            
            break;
        }
        case UISwipeGestureRecognizerDirectionLeft: {
            self.lightValue -= 0.10;
            [[UIScreen mainScreen] setBrightness:self.lightValue];
            
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
            
            
            break;
        }
    }
}

- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)tap
{
    
    if (self.isHidden) {
        
        [self hide];
        
    } else {
        
        [self show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self hideView];
        });
    }
    
}

- (void)creatAnyControlView
{
    self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height - 100, 100, 20)];
    
    self.timeLable.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.timeLable.center = CGPointMake(self.playSlider.center.x, self.view.frame.size.height - 50);
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    self.timeLable.textColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1];
    self.timeLable.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:self.timeLable];
    
    
    
    self.playButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.playButton.frame = CGRectMake(20, 50, 30, 30);
    self.playButton.center =CGPointMake(self.playSlider.center.x, 50);
    
    [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    //添加事件
    [self.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.playButton];
    
    
    
    self.headLable = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, self.view.frame.size.height, 50)];
    self.headLable.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.headLable.center = CGPointMake(self.view.frame.size.width - 25, self.view.center.y);
    self.headLable.backgroundColor = [UIColor blackColor];
    self.headLable.textAlignment = NSTextAlignmentCenter;
    
    self.headLable.textColor = [UIColor whiteColor];
    self.headLable.alpha = 0.5;
    
    self.headLable.text =[NSString stringWithFormat:@"%@", self.foodURLStr];
    
    [self.view addSubview:self.headLable];
    
    
    
    self.arrowButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.arrowButton.frame = CGRectMake(100, 20, 40, 40);
    [self.arrowButton setBackgroundImage:[UIImage imageNamed:@"toparrow"] forState:UIControlStateNormal];
    //添加事件
    [self.arrowButton addTarget:self action:@selector(topArrowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.arrowButton.center = CGPointMake(self.headLable.center.x, 50);
    
    [self.view addSubview:self.arrowButton];
    
 
    self.lockButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.lockButton.frame = CGRectMake(100, 20, 25, 25);
    [self.lockButton setBackgroundImage:[UIImage imageNamed:@"unlock"] forState:UIControlStateNormal];
    //添加事件
    [self.lockButton addTarget:self action:@selector(lockButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.lockButton.center = CGPointMake(self.view.center.x, 50);
    
    [self.view addSubview:self.lockButton];
    
    
    
    
    
    
}

- (void)lockButtonAction:(UIButton *)sender {
    
    [self hide];
    [self.view removeGestureRecognizer:self.tapGestureRecognizer];
    [self.view removeGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view removeGestureRecognizer:self.rightSwipeGestureRecognizer];
    [self.view removeGestureRecognizer:self.upSwipeGestureRecognizer];
    [self.view removeGestureRecognizer:self.downSwipeGestureRecognizer];
    
    self.openLockButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.openLockButton.frame = CGRectMake(100, 20, 25, 25);
    [self.openLockButton setBackgroundImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
    //添加事件
    [self.openLockButton addTarget:self action:@selector(openLockButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.openLockButton.center = CGPointMake(self.view.center.x, 50);
    
    [self.view addSubview:self.openLockButton];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.openLockButton.hidden = YES;
        
    });
    
    self.tapButtonGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapButtonGestureRecognizerAction:)];
    
    self.tapButtonGestureRecognizer.numberOfTouchesRequired = 1;//定义执行方法需要手指的个数
    self.tapButtonGestureRecognizer.numberOfTapsRequired = 1;//定义执行方法需要轻拍的次数
    
    [self.view addGestureRecognizer:self.tapButtonGestureRecognizer];
    
}

- (void)tapButtonGestureRecognizerAction:(UITapGestureRecognizer *)tap {
    if (self.isHideTapButtonGestureRecognizer) {
        
        self.openLockButton.hidden = YES;
        self.isHideTapButtonGestureRecognizer = NO;
        
    } else {
        
        self.openLockButton.hidden = NO;
        self.isHideTapButtonGestureRecognizer = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.openLockButton.hidden = YES;
            self.isHideTapButtonGestureRecognizer = NO;
            
            
        });
    }
}

- (void)openLockButtonAction:(UIButton *)sender {
    [self creatGestureRecognizer];
    self.openLockButton.hidden = YES;
    [self show];
    [self.view removeGestureRecognizer:self.tapButtonGestureRecognizer];
    
}


- (void)topArrowButtonAction:(UIButton *)sender {
    
    [self.avPlayer pause];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)playButtonAction:(UIButton *)sender {
    
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

- (void)creatSlider {
    
    
    self.footLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, self.view.frame.size.height)];
    
    self.footLable.backgroundColor = [UIColor blackColor];
    self.footLable.alpha = 0.5;
    self.footLable.userInteractionEnabled = YES;
    [self.view addSubview:self.footLable];
    
    
    self.playSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height - 200, 20)];
    self.playSlider.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.playSlider.center = CGPointMake(20, self.view.center.y - 15);
    [self.playSlider setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
    [self.playSlider addTarget:self action:@selector(playSliderAction:) forControlEvents:UIControlEventValueChanged];
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

- (void)volumeSliderAction:(UISlider *)slider {
    
    self.avPlayer.volume = slider.value;
    
}

- (void)sliderUpdate {
    self.playSlider.value = CMTimeGetSeconds(self.avPlayer.currentItem.currentTime) / CMTimeGetSeconds(self.avPlayer.currentItem.duration);
    
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
    
    self.timeLable.text = [NSString stringWithFormat:@"%@/%@", presentStrTime, totalStrTime];
    
    
    if ([presentStrTime isEqualToString:totalStrTime]) {
        
        //        [self.avPlayer playWithUrl:self.foodDetailModel.course_video];
        //        [self.avPlayer play];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
 
}

- (void)playSliderAction:(UISlider *)slider {
    
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

- (void)creatAVPlayer {
    
    NSArray  *paths  =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *docDir = [paths objectAtIndex:0];
    
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@", docDir, self.foodURLStr];
    
    NSURL *videoURL = [NSURL fileURLWithPath:fullPath];
    
    
    self.avPlayer = [AVPlayer playerWithURL:videoURL];
    
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    
    layer.frame = self.view.frame;
    
    layer.frame = CGRectMake((self.view.frame.size.width - self.view.frame.size.height) / 2, (self.view.frame.size.height - self.view.frame.size.width) / 2, self.view.frame.size.height, self.view.frame.size.width);
    
    layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1);
    
    layer.videoGravity = AVLayerVideoGravityResize;//拉伸播放内容以适应播放窗口
    
    [self.view.layer addSublayer:layer];
    
    //    self.avPlayer.volume = 5.0f;
    [self.avPlayer play];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
       
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

//单独定制白色电池条
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
