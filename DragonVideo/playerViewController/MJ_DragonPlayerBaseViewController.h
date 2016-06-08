//
//  MJ_DragonPlayerBaseViewController.h
//  DragonVideo
//
//  Created by MJ on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseViewController.h"

#import "MJ_DragonFoodDetailModel.h"

@interface MJ_DragonPlayerBaseViewController : MJ_DragonBaseViewController

@property (nonatomic, strong) MJ_DragonFoodDetailModel *foodDetailModel;
@property (nonatomic, strong) NSString *foodURLStr;



@end
