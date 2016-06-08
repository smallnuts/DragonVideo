//
//  MJ_DragonGuideViewController.h
//  DragonVideo
//
//  Created by MJ on 16/4/14.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseViewController.h"

@protocol JumpDelegate <NSObject>

- (void)jump;

@end

@interface MJ_DragonGuideViewController : MJ_DragonBaseViewController

@property (nonatomic, assign) id<JumpDelegate>delegate;


@end
