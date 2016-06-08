//
//  MJ_DragonFoodModel.h
//  DragonVideo
//
//  Created by MJ on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseModel.h"

@interface MJ_DragonFoodModel : MJ_DragonBaseModel

@property (nonatomic, strong) NSNumber *series_id;
@property (nonatomic, strong) NSString *series_name;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSNumber *episode_sum;
@property (nonatomic, strong) NSNumber *episode;
@property (nonatomic, strong) NSNumber *play;


@end
