//
//  MJ_DragonEyeDetailTableViewCell.m
//  DragonVideo
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonEyeDetailTableViewCell.h"

#import <UIImageView+WebCache.h>


#import "MJ_DragonEyePlayInfoModel.h"

@implementation MJ_DragonEyeDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.photoImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:20 weight:20];
        [self.contentView addSubview:self.titleLabel];
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.typeLabel.textAlignment = NSTextAlignmentCenter;
        self.typeLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.typeLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.photoImageView.frame = self.contentView.bounds;
    self.titleLabel.frame = CGRectMake(0, self.contentView.bounds.size.height / 2 - 30, self.contentView.bounds.size.width, 30);
    self.typeLabel.frame = CGRectMake(0, self.contentView.bounds.size.height / 2, self.contentView.bounds.size.width, 30);
    
}

- (void)setDataModel:(MJ_DragonEyeDetailDataModel *)dataModel {
    _dataModel = dataModel;
    if (dataModel) {
        [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:dataModel.coverModel.feed] placeholderImage:[UIImage imageNamed:@"keyplan"]];
        self.titleLabel.text = dataModel.title;
        self.typeLabel.text = [NSString stringWithFormat:@"%@ / %d'%d''", dataModel.category, [dataModel.duration intValue] / 60, [dataModel.duration intValue] % 60];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
