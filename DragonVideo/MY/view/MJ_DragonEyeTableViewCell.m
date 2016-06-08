//
//  MJ_DragonEyeTableViewCell.m
//  DragonVideo
//
//  Created by dllo on 16/4/7.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonEyeTableViewCell.h"

@implementation MJ_DragonEyeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLable.numberOfLines = 2;
        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.photoImageView];
    }
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.titleLable.frame = CGRectMake(self.contentView.bounds.size.width / 3 + 20, 0, self.contentView.bounds.size.width / 3 * 2 - 30, self.contentView.bounds.size.height);
    
    self.photoImageView.frame = CGRectMake(10, 10, self.contentView.bounds.size.width / 3, self.contentView.bounds.size.height - 20);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
