//
//  NewsView.m
//  SYB
//
//  Created by WangJincai on 16/6/20.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "NewsView.h"


@interface NewsView ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation NewsView

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
    
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(3,7,CGRectGetHeight(frame)-14,CGRectGetHeight(frame)-14)];
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25,0,240,CGRectGetHeight(frame))];
        _titleLabel.textColor=[UIColor grayColor];
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.font = [UIFont fontWithName:kFontName size:12.0];
        [self addSubview:_titleLabel];
        
    }
    return self;
}



- (void)setViewWithTitle:(NSString *)title{
    [_titleLabel setText:title];
}

- (void)setViewWithIcon:(UIImage *)icon{
    [_imageView setImage:icon];
}

@end
