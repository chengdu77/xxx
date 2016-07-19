//
//  AccessReportCell.m
//  SYB
//
//  Created by WangJincai on 16/6/24.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "AccessReportCell.h"

@interface AccessReportCell ()

@property (nonatomic,strong) IBOutlet UILabel *personTitleLabel;
@property (nonatomic,strong) IBOutlet UILabel *timeTitleLabel;

@end

@implementation AccessReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.personTitleLabel.textColor = kFontColor;
    self.timeTitleLabel.textColor = kFontColor;
    self.timeLabel.textColor = kFontColor;
    
    self.stateLabel.layer.masksToBounds = YES;
    self.stateLabel.layer.borderWidth = .5;
    self.stateLabel.layer.borderColor = RGB(244, 166, 146).CGColor;
    self.stateLabel.layer.cornerRadius = 3;
    self.stateLabel.backgroundColor = RGB(244, 166, 146);
    
    
    self.stateLabel.textColor = [UIColor whiteColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
