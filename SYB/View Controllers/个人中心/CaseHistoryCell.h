//
//  CaseHistoryCell.h
//  SYB
//
//  Created by WangJincai on 16/6/22.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseHistoryCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *serialLabel;
@property (nonatomic,strong) IBOutlet UILabel *deptLabel;
@property (nonatomic,strong) IBOutlet UILabel *patientLabel;
@property (nonatomic,strong) IBOutlet UILabel *timeLabel;

@end
