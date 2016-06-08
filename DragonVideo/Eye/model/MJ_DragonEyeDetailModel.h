//
//  MJ_DragonEyeDetailModel.h
//  DragonVideo
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseModel.h"

#import "MJ_DragonEyeDetailDataModel.h"

@interface MJ_DragonEyeDetailModel : MJ_DragonBaseModel

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) MJ_DragonEyeDetailDataModel *detailModel;

- (instancetype)initWithDataSource:(NSDictionary *)dataSource;

@end
