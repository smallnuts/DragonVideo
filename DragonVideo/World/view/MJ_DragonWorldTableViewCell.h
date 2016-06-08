//
//  MJ_DragonWorldTableViewCell.h
//  DragonVideo
//
//  Created by MJ on 16/4/7.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseTableViewCell.h"

#import "MJ_DragonWorldModel.h"

@interface MJ_DragonWorldTableViewCell : MJ_DragonBaseTableViewCell

@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *footerLable;
@property (nonatomic, strong) UIImageView *playImageView;

@property (nonatomic, strong) MJ_DragonWorldModel *worldModel;

@end
