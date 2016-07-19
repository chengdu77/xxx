//
//  appraisal AppraisalTableViewCell.m
//  SYB
//
//  Created by WangJincai on 16/6/17.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "AppraisalTableViewCell.h"

@implementation AppraisalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
