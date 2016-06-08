//
//  MJ_DragonEyeDetailTableViewCell.h
//  DragonVideo
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseTableViewCell.h"

#import "MJ_DragonEyeDetailDataModel.h"

@interface MJ_DragonEyeDetailTableViewCell : MJ_DragonBaseTableViewCell

@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) MJ_DragonEyeDetailDataModel *dataModel;

@end
