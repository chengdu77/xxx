//
//  MedicallyCollectionViewCell.h
//  SYB
//
//  Created by WangJincai on 16/6/20.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicallyCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) IBOutlet UILabel *titleLabel;
@property (nonatomic,strong) IBOutlet UILabel *descLabel;
@property (nonatomic,strong) IBOutlet UIImageView *imageView;

@end
