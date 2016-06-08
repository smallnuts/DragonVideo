//
//  MJ_DragonEyeCollectionViewCell.h
//  DragonVideo
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseCollectionViewCell.h"

#import "MJ_DragonEyeModel.h"

@interface MJ_DragonEyeCollectionViewCell : MJ_DragonBaseCollectionViewCell

@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) MJ_DragonEyeModel *eyeModel;

@end
