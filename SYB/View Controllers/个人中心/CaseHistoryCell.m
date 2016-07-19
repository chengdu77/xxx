//
//  CaseHistoryCell.m
//  SYB
//
//  Created by WangJincai on 16/6/22.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "CaseHistoryCell.h"

@interface CaseHistoryCell ()

@property (nonatomic,strong) IBOutlet UILabel *patientTitleLabel;
@property (nonatomic,strong) IBOutlet UILabel *timeTitleLabel;
@end

@implementation CaseHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.serialLabel.textColor = RGB(244, 166, 146);
    self.patientTitleLabel.textColor = kFontColor;
    self.timeTitleLabel.textColor = kFontColor;
    
    self.patientLabel.textColor = kFontColor_Contacts;
    self.timeLabel.textColor = kFontColor_Contacts;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
