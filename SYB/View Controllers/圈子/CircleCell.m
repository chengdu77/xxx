//
//  CircleCell.m
//  SYB
//
//  Created by WangJincai on 16/6/27.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "CircleCell.h"

@implementation CircleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.msgLabel.textColor = kFontColor;
    self.userLabel.textColor = kFontColor;
    
    self.lineLabel.backgroundColor = kBackgroundColor;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
