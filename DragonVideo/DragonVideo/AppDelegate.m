//
//  AppDelegate.m
//  DragonVideo
//
//  Created by MJ on 16/3/30.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "AppDelegate.h"

#import "MJ_DragonEyeViewController.h"
#import "MJ_DragonFoodViewController.h"
#import "MJ_DragonMYViewController.h"
#import "MJ_DragonWorldViewController.h"


@interface AppDelegate ()<JumpDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
//    //增加标识，用于判断是否是第一次启动应用...
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
//    }
    
    
    MJ_DragonEyeViewController *eyeVC = [[MJ_DragonEyeViewController alloc] init];
    UINavigationController *eyeNavi = [[UINavigationController alloc] initWithRootViewController:eyeVC];
    eyeNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"目观" image:[[UIImage imageNamed:@"muguan1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"muguan2"]];
    
    
    MJ_DragonFoodViewController *foodVC = [[MJ_DragonFoodViewController alloc] init];
    UINavigationController *foodNavi = [[UINavigationController alloc] initWithRootViewController:foodVC];
    foodNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"日食" image:[[UIImage imageNamed:@"rishi1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"rishi2"]];
    
    
    MJ_DragonWorldViewController *worldVC = [[MJ_DragonWorldViewController alloc] init];
    UINavigationController *worldNavi = [[UINavigationController alloc] initWithRootViewController:worldVC];
    worldNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"天下" image:[[UIImage imageNamed:@"world1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"world2"]];
    
    
    
    
    MJ_DragonMYViewController *myVC = [[MJ_DragonMYViewController alloc] init];
    UINavigationController *myNavi = [[UINavigationController alloc] initWithRootViewController:myVC];
    myNavi.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"MY" image:[[UIImage imageNamed:@"my1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"my2"]];
    
    
    self.tabBar = [[UITabBarController alloc] init];
    
    self.tabBar.viewControllers = @[eyeNavi, foodNavi, worldNavi, myNavi];
    
    self.tabBar.tabBar.barTintColor = [UIColor colorWithRed:236 / 255.0 green:173 / 255.0 blue:158 / 255.0 alpha:1];
    self.tabBar.tabBar.tintColor = [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1];
    
    
   
    
    
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:236 / 255.0 green:173 / 255.0 blue:158 / 255.0 alpha:1]];
    
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        self.guideVC = [[MJ_DragonGuideViewController alloc] init];
        //   如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
        self.guideVC.delegate = self;
        
        self.window.rootViewController = self.guideVC;
    } else {
        self.window.rootViewController = self.tabBar;
    }
    
   
    // Override point for customization after application launch.
    return YES;
}


- (void)jump {
    
    [self.guideVC presentViewController:self.tabBar animated:YES completion:nil];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
   
}


@end
