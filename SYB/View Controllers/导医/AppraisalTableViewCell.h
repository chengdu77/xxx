//
//  AppraisalTableViewCell.h
//  SYB
//
//  Created by WangJincai on 16/6/17.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppraisalTableViewCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIImageView *userImageView;
@property (nonatomic,strong) IBOutlet UIImageView *appraisal_back_ImageView;
@property (nonatomic,strong) IBOutlet UIImageView *bubbleImageView;
@property (nonatomic,strong) IBOutlet UILabel *userNameLabel;
@property (nonatomic,strong) IBOutlet UILabel *timeLabel;
@property (nonatomic,strong) IBOutlet UILabel *detailLabel;

@end
