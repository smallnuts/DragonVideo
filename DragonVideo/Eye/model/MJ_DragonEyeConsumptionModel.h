//
//  MJ_DragonEyeConsumptionModel.h
//  DragonVideo
//
//  Created by dllo on 16/4/1.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseModel.h"

@interface MJ_DragonEyeConsumptionModel : MJ_DragonBaseModel

@property (nonatomic, strong) NSNumber *collectionCount;
@property (nonatomic, strong) NSNumber *shareCount;
@property (nonatomic, strong) NSNumber *playCount;
@property (nonatomic, strong) NSNumber *replyCount;

@end
