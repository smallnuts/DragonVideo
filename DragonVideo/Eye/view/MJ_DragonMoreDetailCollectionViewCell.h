//
//  MJ_DragonMoreDetailCollectionViewCell.h
//  DragonVideo
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonBaseCollectionViewCell.h"

#import "MJ_DragonEyeDetailDataModel.h"

@interface MJ_DragonMoreDetailCollectionViewCell : MJ_DragonBaseCollectionViewCell

@property (nonatomic, strong) UIImageView *photoImageVeiw;
@property (nonatomic, strong) UIImageView *playImageVeiw;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *collectLabel;
@property (nonatomic, strong) UIImageView *collectImageView;
@property (nonatomic, strong) UILabel *shareLabel;
@property (nonatomic, strong) UIImageView *shareImageView;
@property (nonatomic, strong) UILabel *cacheLabel;
@property (nonatomic, strong) UIImageView *cacheImageView;
@property (nonatomic, strong) UIButton *collectButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *cacheButton;

@property (nonatomic, strong) MJ_DragonEyeDetailDataModel *dataModel;

@end
