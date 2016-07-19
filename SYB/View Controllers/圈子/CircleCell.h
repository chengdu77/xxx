//
//  CircleCell.h
//  SYB
//
//  Created by WangJincai on 16/6/27.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel *lineLabel;

@property (nonatomic,strong) IBOutlet UIImageView *iconView;
@property (nonatomic,strong) IBOutlet UILabel *nameLabel;
@property (nonatomic,strong) IBOutlet UILabel *msgLabel;
@property (nonatomic,strong) IBOutlet UILabel *userLabel;

@end
