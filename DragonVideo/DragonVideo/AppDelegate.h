//
//  AppDelegate.h
//  DragonVideo
//
//  Created by MJ on 16/3/30.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MJ_DragonGuideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UITabBarController *tabBar;

@property (nonatomic, strong) MJ_DragonGuideViewController *guideVC;
@end

