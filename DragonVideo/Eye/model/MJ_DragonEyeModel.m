//
//  MJ_DragonEyeModel.m
//  DragonVideo
//
//  Created by MJ on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonEyeModel.h"

@implementation MJ_DragonEyeModel

- (instancetype)initWithDataSource:(NSDictionary *)dataSource {
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dataSource];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.syeId = value;
    }
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
