//
//  PaymentCell.m
//  SYB
//
//  Created by WangJincai on 16/6/26.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "PaymentCell.h"

@interface PaymentCell ()

@end

@implementation PaymentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.costLabel.textColor = kFontColor;
    self.timeLabel.textColor = kFontColor;
    
    self.stateLabel.layer.masksToBounds = YES;
    self.stateLabel.layer.borderWidth = .5;
    self.stateLabel.layer.borderColor = RGB(244, 166, 146).CGColor;
    self.stateLabel.layer.cornerRadius = 3;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

 
}

@end
