//
//  MedicallyCollectionViewCell.m
//  SYB
//
//  Created by WangJincai on 16/6/20.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "MedicallyCollectionViewCell.h"

@implementation MedicallyCollectionViewCell


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        _imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame)-45,(CGRectGetHeight(frame)-38)/2,38,38)];
        [self.contentView addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,CGRectGetHeight(frame)/2-20,100,20)];
        _titleLabel.font = [UIFont fontWithName:kFontName size:14.0];
        [self.contentView addSubview:_titleLabel];
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,CGRectGetHeight(frame)/2,100,20)];
        _descLabel.font = [UIFont fontWithName:kFontName size:12.0];
        _descLabel.textColor = kFontColor;
        [self.contentView addSubview:_descLabel];
        
        self.layer.borderColor = kFontColor.CGColor;
        self.layer.borderWidth = .5;
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
  
}

@end
