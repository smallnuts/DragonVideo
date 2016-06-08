//
//  MJ_DragonFoodDetailTableViewCell.m
//  DragonVideo
//
//  Created by MJ on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonFoodDetailTableViewCell.h"

#import <UIImageView+WebCache.h>

@implementation MJ_DragonFoodDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.descLable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.playLable = [[UILabel alloc] initWithFrame:CGRectZero];
        
        self.playLable.textAlignment = NSTextAlignmentRight;
        self.playLable.font = [UIFont systemFontOfSize:14];
        self.descLable.font = [UIFont systemFontOfSize:13 weight:30];;
        self.descLable.numberOfLines = 10;
        
        self.nameLable.textColor = [UIColor grayColor];
        self.playLable.textColor = [UIColor grayColor];
        self.descLable.textColor = [UIColor grayColor];
        self.nameLable.font = [UIFont systemFontOfSize:17 weight:30];
        
        self.play = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.play.image = [UIImage imageNamed:@"playBig"];
        
        
       
        [self.contentView addSubview:self.mainImageView];
        [self.contentView addSubview:self.nameLable];
        [self.contentView addSubview:self.playLable];
        [self.contentView addSubview:self.descLable];
        [self.contentView addSubview:self.play];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    
    self.mainImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width / 2);
    self.nameLable.frame = CGRectMake(20, self.bounds.size.width / 2 + 10, self.bounds.size.width - 40, 20);
    self.descLable.frame = CGRectMake(20, self.bounds.size.width / 2 + 20, self.bounds.size.width - 40, self.bounds.size.width / 2 - 20);
    
    self.playLable.frame = CGRectMake(30, self.bounds.size.width / 2 - 30, self.bounds.size.width - 60, 20);
    
    self.play.frame = CGRectMake(self.bounds.size.width / 2 - 30, self.bounds.size.width / 4 - 30, 60, 60);
    
}

-(void)setFoodDetialModel:(MJ_DragonFoodDetailModel *)foodDetialModel {
    _foodDetialModel = foodDetialModel;
    
//    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:foodDetialModel.course_image]];
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:foodDetialModel.course_image] placeholderImage:[UIImage imageNamed:@"Placeholderfigure"]];
    
    
    
    self.nameLable.text = foodDetialModel.course_name;
    self.descLable.text = foodDetialModel.course_subject;
    self.playLable.text = [NSString stringWithFormat:@"%@人做过", foodDetialModel.video_watchcount];
    
    
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
