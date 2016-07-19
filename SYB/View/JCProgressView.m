//
//  JCProgressView.m
//  SYB
//
//  Created by WangJincai on 16/6/18.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "JCProgressView.h"


@interface JCProgressView ()
@property (nonatomic,strong) UIView *internalView;
@property (nonatomic,strong) UILabel *textLabel;
@end

@implementation JCProgressView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initThisView];
        
        [self positionFrame:frame];
    }
    return self;
}

- (void)initThisView{
    
    self.borderWidth = 1;
    
    self.internalView = UIView.new;
    self.internalView.clipsToBounds = YES;
    [self addSubview:self.internalView];
    
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.layer.masksToBounds = YES;
    self.textLabel.layer.cornerRadius = 5;
    self.textLabel.backgroundColor = [UIColor clearColor];
    [self.internalView addSubview:self.textLabel];
    
    
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    [self positionFrame:frame];
}

- (void)positionFrame:(CGRect)frame{
    self.layer.cornerRadius = CGRectGetHeight(frame)/2;
    
    self.internalView.frame = CGRectMake(2, 2,CGRectGetWidth(frame)-4,CGRectGetHeight(frame) -4);
    self.internalView.layer.cornerRadius = (CGRectGetHeight(frame) -4)/2;
}

- (void)setFillColor:(UIColor *)fillColor{
    self.layer.borderColor = fillColor.CGColor;
    self.internalView.backgroundColor = fillColor;
}

- (void)setProgress:(CGFloat)progress{
    
    self.internalView.frame = CGRectMake(2, 2, (CGRectGetWidth(self.frame) -4) *progress, CGRectGetHeight(self.frame)-4);
}

- (void)setBorderWidth:(NSInteger)borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (void)setDisplayText:(NSString *)displayText{
    self.textLabel.text = displayText;
}

- (void)setTextFont:(UIFont *)textFont{
    self.textLabel.font = textFont;
    
}


@end
