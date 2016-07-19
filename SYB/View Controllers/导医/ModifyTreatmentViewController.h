//
//  ModifyTreatmentViewController.h
//  SYB
//
//  Created by WangJincai on 16/6/16.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "HeadViewController.h"

typedef NS_ENUM(NSUInteger, TreatmentOperationMode) {
    TreatmentOperationModeInsert = 0, //新增
    TreatmentOperationModeModify  //修改
};

typedef void (^TreatmentRefreshSupperViewBLock) (id data);

@interface ModifyTreatmentViewController : HeadViewController

@property (nonatomic, assign) TreatmentOperationMode operationMode;
@property (nonatomic,copy) TreatmentRefreshSupperViewBLock block;


- (void)updateInfo:(id)obj withRefreshSupperView:(TreatmentRefreshSupperViewBLock)block;

@end
