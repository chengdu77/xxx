//
//  JCProgressView.h
//  SYB
//
//  Created by WangJincai on 16/6/18.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCProgressView : UIView


@property (nonatomic,strong) NSString *displayText;
@property (nonatomic,strong) UIFont *textFont;
@property (nonatomic,assign) CGFloat progress;
@property (nonatomic,assign) NSInteger cornerRadius;
@property (nonatomic,assign) NSInteger borderWidth;

@property (nonatomic,strong) UIColor *fillColor;

@end
