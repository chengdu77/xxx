//
//  ExpertTableViewCell.h
//  SYB
//
//  Created by WangJincai on 16/6/14.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpertTableViewCell : UITableViewCell


@property (nonatomic,weak) IBOutlet UIImageView *txImageView;
@property (nonatomic,weak) IBOutlet UILabel *nameLabel;
@property (nonatomic,weak) IBOutlet UILabel *jobLabel;
@property (nonatomic,weak) IBOutlet UILabel *expertLabel;
@property (nonatomic,weak) IBOutlet UILabel *timeLabel1;
@property (nonatomic,weak) IBOutlet UILabel *timeLabel2;
@property (nonatomic,weak) IBOutlet UILabel *timeLabel3;
@property (nonatomic,weak) IBOutlet UILabel *moreLabel;

@property (nonatomic,weak) IBOutlet UIView *lineView;

@end
