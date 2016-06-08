//
//  MJ_DragonEyeDetailDataModel.m
//  DragonVideo
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonEyeDetailDataModel.h"

#import "MJ_DragonEyePlayInfoModel.h"

@implementation MJ_DragonEyeDetailDataModel

- (instancetype)initWithDataSource:(NSDictionary *)dataSource {
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dataSource];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in self.playInfo) {
            MJ_DragonEyePlayInfoModel *playInfoModel = [[MJ_DragonEyePlayInfoModel alloc] init];
            [playInfoModel setValuesForKeysWithDictionary:dic];
            [arr addObject:playInfoModel];
        }
        self.playInfo = [NSArray arrayWithArray:arr];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.dataId = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.dataDescription = value;
    }
    if ([key isEqualToString:@"cover"]) {
        self.coverModel = [[MJ_DragonEyeCoverModel alloc] init];
        [self.coverModel setValuesForKeysWithDictionary:value];
    }
    
    if ([key isEqualToString:@"consumption"]) {
        self.consumptionModel = [[MJ_DragonEyeConsumptionModel alloc] init];
        [self.consumptionModel setValuesForKeysWithDictionary:value];
    }
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
