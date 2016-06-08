//
//  MJ_DragonFoodTableViewCell.h
//  DragonVideo
//
//  Created by MJ on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseTableViewCell.h"
#import "MJ_DragonFoodModel.h"

@interface MJ_DragonFoodTableViewCell : MJ_DragonBaseTableViewCell

@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *episode_sumLable;
@property (nonatomic, strong) UILabel *playLable;
@property (nonatomic, strong) UIImageView *mainImageView;

@property (nonatomic, strong) MJ_DragonFoodModel *foodModel;

@end
