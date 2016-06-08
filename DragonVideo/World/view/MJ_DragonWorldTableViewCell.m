//
//  MJ_DragonWorldTableViewCell.m
//  DragonVideo
//
//  Created by MJ on 16/4/7.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonWorldTableViewCell.h"

#import <UIImageView+WebCache.h>

@implementation MJ_DragonWorldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.footerLable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.playImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        self.titleLable.backgroundColor = [UIColor blackColor];
        self.titleLable.textColor = [UIColor whiteColor];
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        self.footerLable.backgroundColor = [UIColor blackColor];
        self.footerLable.textColor = [UIColor whiteColor];
        self.footerLable.textAlignment = NSTextAlignmentCenter;
        
        self.titleLable.alpha = 0.5;
        self.footerLable.alpha = 0.5;
        
        [self.contentView addSubview:self.mainImageView];
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.footerLable];
        [self.contentView addSubview:self.playImageView];
    }
    
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.mainImageView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.width / 7 * 4);
    
    self.titleLable.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, 30);
    
    self.footerLable.frame = CGRectMake(0, self.contentView.bounds.size.width / 7 * 4 - 30, self.contentView.bounds.size.width, 30);
    self.playImageView.frame = CGRectMake(0, 0, 60, 60);
    self.playImageView.center = self.contentView.center;
}

- (void)setWorldModel:(MJ_DragonWorldModel *)worldModel {
    
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:worldModel.course_image]];
    self.titleLable.text = worldModel.course_name;
//    self.footerLable.text = worldModel.channel;
    
    self.playImageView.image = [[UIImage imageNamed:@"playBig"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}










/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
