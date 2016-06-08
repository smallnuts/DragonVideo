//
//  MJ_DragonfavourirteTableViewCell.m
//  DragonVideo
//
//  Created by MJ on 16/4/9.
//  Copyright © 2016年 MJ. All rights reserved.
//

#import "MJ_DragonfavourirteTableViewCell.h"

@implementation MJ_DragonfavourirteTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.plaImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.plaImageView.backgroundColor = [UIColor cyanColor];
        
        [self.contentView addSubview:self.plaImageView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.plaImageView.frame = self.contentView.bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
