//
//  ExpertTableViewCell.m
//  SYB
//
//  Created by WangJincai on 16/6/14.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "ExpertTableViewCell.h"

@implementation ExpertTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self redrawLabel:self.timeLabel1];
    [self redrawLabel:self.timeLabel2];
    [self redrawLabel:self.timeLabel3];
    
    [self redrawLabel:self.moreLabel];
    
    self.lineView.backgroundColor = kBackgroundColor;
    self.jobLabel.textColor = self.expertLabel.textColor = kFontColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)redrawLabel:(UILabel *)label{
    
    label.layer.masksToBounds = YES;
    label.layer.borderWidth = 1;
    label.layer.borderColor = RGB(244, 166, 146).CGColor;
    label.layer.cornerRadius = 3;
    label.backgroundColor = RGB(244, 166, 146);
    
    label.textColor = [UIColor whiteColor];
}

@end
