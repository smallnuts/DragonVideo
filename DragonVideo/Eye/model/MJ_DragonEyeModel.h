//
//  MJ_DragonEyeModel.h
//  DragonVideo
//
//  Created by MJ on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseModel.h"

@interface MJ_DragonEyeModel : MJ_DragonBaseModel

@property (nonatomic, strong) NSNumber *syeId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *bgPicture;

- (instancetype)initWithDataSource:(NSDictionary *)dataSource;

@end
