//
//  MJ_DragonWorldUrlModel.h
//  DragonVideo
//
//  Created by dllo on 16/4/8.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseModel.h"

@interface MJ_DragonWorldUrlModel : MJ_DragonBaseModel

@property (nonatomic, strong) NSString *playurl;

- (instancetype)initWithDataSource:(NSDictionary *)dataSource;

@end
