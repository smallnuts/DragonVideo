//
//  MJ_DragonFoodDetailModel.h
//  DragonVideo
//
//  Created by MJ on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseModel.h"

@interface MJ_DragonFoodDetailModel : MJ_DragonBaseModel

@property (nonatomic, strong) NSString *course_name;
@property (nonatomic, strong) NSString *course_subject;
@property (nonatomic, strong) NSString *course_image;
@property (nonatomic, strong) NSNumber *video_watchcount;
@property (nonatomic, strong) NSString *course_video;

@end
