//
//  NextCaseHistoryViewController.h
//  SYB
//
//  Created by WangJincai on 16/6/22.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "HeadViewController.h"

@interface NextCaseHistoryViewController : HeadViewController

@property (nonatomic,copy) ReturnDataBLock block;

- (void)sendInfo:(id)obj withRefreshSupperView:(ReturnDataBLock)block;

@end
