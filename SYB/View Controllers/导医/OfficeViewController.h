//
//  OfficeViewController.h
//  SYB
//
//  Created by WangJincai on 16/6/14.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "HeadViewController.h"


typedef NS_ENUM(NSUInteger, OfficeStyle) {
    OfficeStyleQuery = 0, // 查看
    OfficeStyleChoose   //选择
};


@interface OfficeViewController : HeadViewController

@property (nonatomic, assign) OfficeStyle style;
@property (nonatomic,copy) ReturnDataBLock block;

- (void)sendInfo:(id)obj withRefreshSupperView:(ReturnDataBLock)block;

@end
