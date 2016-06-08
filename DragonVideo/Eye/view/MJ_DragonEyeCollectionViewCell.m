//
//  MJ_DragonEyeCollectionViewCell.m
//  DragonVideo
//
//  Created by dllo on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonEyeCollectionViewCell.h"

#import <UIImageView+WebCache.h>

@implementation MJ_DragonEyeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
        [self.contentView addSubview:self.photoImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:self.photoImageView.bounds];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:20 weight:30];
        self.nameLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.nameLabel];
        
    }
    return self;
}

- (void)setEyeModel:(MJ_DragonEyeModel *)eyeModel {
    _eyeModel = eyeModel;
    
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:eyeModel.bgPicture] placeholderImage:[UIImage imageNamed:@"keyplan"]];
    self.nameLabel.text = eyeModel.name;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
