//
//  PaymentCell.h
//  SYB
//
//  Created by WangJincai on 16/6/26.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentCell : UITableViewCell


@property (nonatomic,strong) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong) IBOutlet UILabel *stateLabel;
@property (nonatomic,strong) IBOutlet UILabel *patientLabel;
@property (nonatomic,strong) IBOutlet UILabel *timeLabel;
@property (nonatomic,strong) IBOutlet UILabel *costLabel;

@property (nonatomic,assign) BOOL paymentFlag;

@end
