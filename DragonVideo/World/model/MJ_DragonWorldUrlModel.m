//
//  MJ_DragonWorldUrlModel.m
//  DragonVideo
//
//  Created by dllo on 16/4/8.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonWorldUrlModel.h"

@implementation MJ_DragonWorldUrlModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    return nil;
}

- (instancetype)initWithDataSource:(NSDictionary *)dataSource {
    self = [super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dataSource];
        
    }
    return self;
}


@end
