//
//  MJ_DragonWorldModel.m
//  DragonVideo
//
//  Created by dllo on 16/4/8.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonWorldModel.h"

@implementation MJ_DragonWorldModel

- (instancetype)initWithDataSource:(NSDictionary *)dataSource {
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dataSource];
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

@end
