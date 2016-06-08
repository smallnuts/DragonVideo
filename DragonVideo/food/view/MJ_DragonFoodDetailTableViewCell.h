//
//  MJ_DragonFoodDetailTableViewCell.h
//  DragonVideo
//
//  Created by MJ on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseTableViewCell.h"
#import "MJ_DragonFoodDetailModel.h"

@interface MJ_DragonFoodDetailTableViewCell : MJ_DragonBaseTableViewCell

@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UILabel *descLable;
@property (nonatomic, strong) UILabel *playLable;
@property (nonatomic, strong) UIImageView *play;

@property (nonatomic, strong) MJ_DragonFoodDetailModel *foodDetialModel;

@end
