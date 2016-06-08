//
//  MJ_DragonMYTableViewCell.m
//  DragonVideo
//
//  Created by MJ on 16/4/6.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonMYTableViewCell.h"

@implementation MJ_DragonMYTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
        
        self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.arrowImageView.image = [UIImage imageNamed:@"rightArrow"];
        
        
        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:self.arrowImageView];
    }
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.titleLable.frame = CGRectMake(30, 0, 200, self.contentView.bounds.size.height);
    
    self.arrowImageView.frame = CGRectMake(self.contentView.bounds.size.width - 40, (self.contentView.bounds.size.height - 30) / 2, 30, 30);
    
    
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
