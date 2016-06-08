//
//  MJ_DragonMoreDetailCollectionViewCell.m
//  DragonVideo
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonMoreDetailCollectionViewCell.h"

#import <UIImageView+WebCache.h>

@implementation MJ_DragonMoreDetailCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.photoImageVeiw = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height * 0.6)];
        self.photoImageVeiw.userInteractionEnabled = YES;
        [self.contentView addSubview:self.photoImageVeiw];
        self.playImageVeiw = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        self.playImageVeiw.center = self.photoImageVeiw.center;
        self.playImageVeiw.image = [[UIImage imageNamed:@"playBig"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.photoImageVeiw addSubview:self.playImageVeiw];
//        毛玻璃
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        effectView.frame = CGRectMake(0, self.contentView.bounds.size.height * 0.6, self.contentView.bounds.size.width, self.contentView.bounds.size.height * 0.4);
        [self.contentView addSubview:effectView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.contentView.bounds.size.width - 20, 30)];
        self.titleLabel.textColor = [UIColor whiteColor];
        [effectView addSubview:self.titleLabel];
        self.lineView = [[UIView alloc] initWithFrame:CGRectZero];
        self.lineView.backgroundColor = [UIColor whiteColor];
        [effectView addSubview:self.lineView];
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, self.contentView.bounds.size.width - 20, 30)];
        self.typeLabel.textColor = [UIColor whiteColor];
        [effectView addSubview:self.typeLabel];
        self.detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, self.contentView.bounds.size.width - 20, effectView.bounds.size.height - 70 - 100)];
        self.detailLabel.textColor = [UIColor whiteColor];
        self.detailLabel.numberOfLines = 5;
        self.detailLabel.font = [UIFont systemFontOfSize:15];
        [effectView addSubview:self.detailLabel];
        
        self.collectButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.collectButton.frame = CGRectMake(10, effectView.bounds.size.height - 70, (self.contentView.bounds.size.width - 40) / 3, 40);
        
        self.collectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, self.collectButton.bounds.size.height)];
        
        [self.collectButton addSubview:self.collectImageView];
        self.collectLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.collectButton.bounds.size.width * 0.6, self.collectButton.bounds.size.height)];
        self.collectLabel.textColor = [UIColor whiteColor];
        self.collectLabel.font = [UIFont systemFontOfSize:20];
        [self.collectButton addSubview:self.collectLabel];
        [effectView addSubview:self.collectButton];
        
        self.shareButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.shareButton.frame = CGRectMake(10 + (self.contentView.bounds.size.width - 40) / 3, effectView.bounds.size.height - 70, (self.contentView.bounds.size.width - 40) / 3, 40);
        self.shareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, self.collectButton.bounds.size.height)];
        self.shareImageView.image = [[UIImage imageNamed:@"share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.shareButton addSubview:self.shareImageView];
        self.shareLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.shareButton.bounds.size.width * 0.6, self.shareButton.bounds.size.height)];
        self.shareLabel.textColor = [UIColor whiteColor];
        self.shareLabel.font = [UIFont systemFontOfSize:20];
        [self.shareButton addSubview:self.shareLabel];
        [effectView addSubview:self.shareButton];
        
        self.cacheButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.cacheButton.frame = CGRectMake(10 + (self.contentView.bounds.size.width - 40) / 3 * 2, effectView.bounds.size.height - 70, (self.contentView.bounds.size.width - 40) / 3, 40);
        self.cacheImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, self.collectButton.bounds.size.height)];
        self.cacheImageView.image = [[UIImage imageNamed:@"cache"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.cacheButton addSubview:self.cacheImageView];
        self.cacheLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.cacheButton.bounds.size.width * 0.6, self.cacheButton.bounds.size.height)];
        self.cacheLabel.textColor = [UIColor whiteColor];
        self.cacheLabel.font = [UIFont systemFontOfSize:20];
        [self.cacheButton addSubview:self.cacheLabel];
        [effectView addSubview:self.cacheButton];
        
    }
    return self;
}

- (void)setDataModel:(MJ_DragonEyeDetailDataModel *)dataModel {
    _dataModel = dataModel;
    
    [self.photoImageVeiw sd_setImageWithURL:[NSURL URLWithString:dataModel.coverModel.feed] placeholderImage:[UIImage imageNamed:@"keyplan"]];
    
    self.titleLabel.text = dataModel.title;
    self.typeLabel.text = [NSString stringWithFormat:@"%@ / %d'%d''", dataModel.category, [dataModel.duration intValue] / 60, [dataModel.duration intValue] % 60];
    self.detailLabel.text = dataModel.dataDescription;
    self.collectLabel.text = [dataModel.consumptionModel.collectionCount stringValue];
    self.shareLabel.text = [dataModel.consumptionModel.shareCount stringValue];
    self.cacheLabel.text = @"缓存";
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
