//
//  MJ_DragonFoodTableViewCell.m
//  DragonVideo
//
//  Created by MJ on 16/3/31.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonFoodTableViewCell.h"

#import <UIImageView+WebCache.h>


@implementation MJ_DragonFoodTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.mainImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.playLable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.episode_sumLable = [[UILabel alloc] initWithFrame:CGRectZero];
        
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        self.playLable.textAlignment = NSTextAlignmentCenter;
        self.episode_sumLable.textAlignment = NSTextAlignmentCenter;
        
        self.playLable.font = [UIFont systemFontOfSize:13];
        self.episode_sumLable.font = [UIFont systemFontOfSize:13];
        
        self.titleLable.textColor = [UIColor whiteColor];
        self.playLable.textColor = [UIColor whiteColor];
        self.episode_sumLable.textColor = [UIColor whiteColor];
        
//      
//        self.mainImageView.backgroundColor = [UIColor orangeColor];
//        self.titleLable.backgroundColor = [UIColor cyanColor];
//        self.episode_sumLable.backgroundColor = [UIColor cyanColor];
//        self.playLable.backgroundColor = [UIColor cyanColor];
//        
        
        
        [self.contentView addSubview:self.mainImageView];
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.episode_sumLable];
        [self.contentView addSubview:self.playLable];
   
    }
    
    
    return self;
}

-(void)setFoodModel:(MJ_DragonFoodModel *)foodModel {
    
    _foodModel = foodModel;
    
//    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:foodModel.image]];
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:foodModel.image] placeholderImage:[UIImage imageNamed:@"Placeholderfigure1"]];
    
    
    self.titleLable.text = foodModel.series_name;
    self.playLable.text = [NSString stringWithFormat:@"%@人做过", foodModel.play];
    self.episode_sumLable.text = [NSString stringWithFormat:@"%@/%@集", foodModel.episode, foodModel.episode_sum];
    
    
    
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.mainImageView.frame = self.bounds;
    self.titleLable.frame = CGRectMake(50, self.frame.size.height / 2 - 35, self.frame.size.width - 100, 30);
    self.episode_sumLable.frame = CGRectMake(50, self.frame.size.height / 2 + 5, self.frame.size.width / 2 - 50, 20);
    self.playLable.frame = self.playLable.frame = CGRectMake(self.frame.size.width / 2, self.frame.size.height / 2 + 5, self.frame.size.width / 2 - 50, 20);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
