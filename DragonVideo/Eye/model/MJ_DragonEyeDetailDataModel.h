//
//  MJ_DragonEyeDetailDataModel.h
//  DragonVideo
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseModel.h"

#import "MJ_DragonEyeCoverModel.h"
#import "MJ_DragonEyeConsumptionModel.h"

@interface MJ_DragonEyeDetailDataModel : MJ_DragonBaseModel

@property (nonatomic, strong) NSNumber *dataId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *dataDescription;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *duration;
@property (nonatomic, strong) NSString *playUrl;
@property (nonatomic, strong) NSArray *playInfo;
@property (nonatomic, strong) MJ_DragonEyeConsumptionModel *consumptionModel;
@property (nonatomic, strong) MJ_DragonEyeCoverModel *coverModel;
@property (nonatomic, strong) NSDictionary *webUrl;

- (instancetype)initWithDataSource:(NSDictionary *)dataSource;

@end
