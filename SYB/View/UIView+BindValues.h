//
//  UIView+BindValues.h
//  JCDB
//
//  Created by WangJincai on 16/1/6.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BindValues)

@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) id value;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSNumber *must;//组号
@property (nonatomic, strong) NSNumber *number;//序号


@end
