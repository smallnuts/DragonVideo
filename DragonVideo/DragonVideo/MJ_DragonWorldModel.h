//
//  MJ_DragonWorldModel.h
//  DragonVideo
//
//  Created by dllo on 16/4/8.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseModel.h"

@interface MJ_DragonWorldModel : MJ_DragonBaseModel

@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *vid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;

- (instancetype)initWithDataSource:(NSDictionary *)dataSource;

@end
