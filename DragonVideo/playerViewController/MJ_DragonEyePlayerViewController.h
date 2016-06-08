//
//  MJ_DragonEyePlayerViewController.h
//  DragonVideo
//
//  Created by dllo on 16/4/2.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseViewController.h"

#import "MJ_DragonEyeDetailDataModel.h"
#import "DragonVideo.h"

@interface MJ_DragonEyePlayerViewController : MJ_DragonBaseViewController

@property (nonatomic, strong) MJ_DragonEyeDetailDataModel *dataModel;

@property (nonatomic, strong) DragonVideo *dragonVideo;

@end
