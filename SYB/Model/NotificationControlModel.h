//
//  NotificationControlModel.h
//  SLYLT
//
//  Created by WangJincai on 16/4/13.
//  Copyright © 2016年 Shenlan.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFreeScramblingControlFlag @"FreeScramblingControlFlag"
#define kFreeScramblingStartDateControl @"FreeScramblingStartDateControl"
#define kFreeScramblingEndDateControl @"FreeScramblingEndDateControl"

#define kNotificationControlFlag @"NotificationControlFlag"
#define kSoundControl @"SoundControl"
#define kVibrateControl @"VibrateControl"
#define kIsFirstLoginFlag @"IsFirstLoginFlag"//安装后第一次登陆标志

@interface NotificationControlModel : NSObject

+ (NotificationControlModel *)shareInstance;

- (NSInteger)notificationPlaySound;
@end
