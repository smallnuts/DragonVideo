//
//  MJ_DragonEyeDetailModel.m
//  DragonVideo
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonEyeDetailModel.h"

@implementation MJ_DragonEyeDetailModel

- (instancetype)initWithDataSource:(NSDictionary *)dataSource {
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dataSource];
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"data"]) {
        self.detailModel = [[MJ_DragonEyeDetailDataModel alloc] initWithDataSource:value];
    }
   
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
