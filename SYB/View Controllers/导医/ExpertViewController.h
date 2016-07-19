//
//  ExpertViewController.h
//  SYB
//
//  Created by WangJincai on 16/6/14.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "HeadViewController.h"


typedef NS_ENUM(NSUInteger, ExpertStyle) {
    ExpertStyleQuery = 0, // 查看
    ExpertStyleChoose   //选择
};

@interface ExpertViewController : HeadViewController

@property (nonatomic, assign) ExpertStyle style;
@property (nonatomic,copy) ReturnDataBLock block;

- (void)sendInfo:(id)obj withRefreshSupperView:(ReturnDataBLock)block;

@end
