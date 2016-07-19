//
//  DeviceViewController.h
//  xsgj
//
//  Created by 卿 明 on 15/11/3.
//  Copyright (c) 2015年 Shenlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadViewController.h"


typedef void(^TypeListBlock)(id value);

@interface TypeListViewController : HeadViewController

@property (nonatomic,strong) NSArray *infos;
@property (nonatomic,copy) TypeListBlock block;

- (void)setTypeListBlock:(TypeListBlock) block;

@end
