//
//  CommonTreatmentViewController.h
//  SYB
//
//  Created by WangJincai on 16/6/21.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "HeadViewController.h"

typedef NS_ENUM(NSUInteger, CommonTreatmentStyle) {
    CommonTreatmentStyleQuery = 0, // 查看
    CommonTreatmentStyleChoose   //选择
};

@interface CommonTreatmentViewController : HeadViewController


@property (nonatomic, assign) CommonTreatmentStyle style;
@property (nonatomic,copy) ReturnDataBLock block;


- (void)sendInfo:(id)obj withRefreshSupperView:(ReturnDataBLock)block;

@end
