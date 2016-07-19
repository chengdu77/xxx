//
//  FreeScramblingModel.m
//  SLYLT
//
//  Created by WangJincai on 16/4/13.
//  Copyright © 2016年 Shenlan.com. All rights reserved.
//

#import "NotificationControlModel.h"
#import <AudioToolbox/AudioToolbox.h>

static NotificationControlModel   *_shareValue;

@implementation NotificationControlModel

+ (NotificationControlModel *)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
                      _shareValue  = [[NotificationControlModel alloc] init];
                  });
    return _shareValue;
}

- (NSInteger)notificationPlaySound{
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    
//    if ([userDefaults boolForKey:kFreeScramblingControlFlag]) {
//        
//        NSString *startDate = [userDefaults objectForKey:kFreeScramblingStartDateControl];
//        NSString *endDate = [userDefaults objectForKey:kFreeScramblingEndDateControl];
//
//        NSDate *date  = [NSDate date];
//        NSDateFormatter* dFormatter = [NSDateFormatter new];
//        [dFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//        NSString *today = [dFormatter stringFromDate:date];
//     
//        NSDate *tomorrow =[[NSDate alloc] initWithTimeIntervalSinceNow:24*60*60];
//        
//        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
//         NSTimeZone * zone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
//        dateFormatter.timeZone = zone;
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//        startDate = [NSString stringWithFormat:@"%@ %@",[dateFormatter stringFromDate:date],startDate];
//        endDate = [NSString stringWithFormat:@"%@ %@",[dateFormatter stringFromDate:tomorrow],endDate];
//        [dateFormatter setDateFormat:dFormatter.dateFormat];
//        
//        NSDate *d_StartDate=[dateFormatter dateFromString:startDate];
//        NSDate *d_EndDate=[dateFormatter dateFromString:endDate];
//        NSDate *d_today=[dateFormatter dateFromString:today];
//        
//        if (d_today >= d_StartDate && d_today <= d_EndDate) {
//            return -1;//免打扰
//        }else{
//            return [self soundAndVibrate];
//        }
//    }else{
        return [self soundAndVibrate];
//    }
}


- (NSInteger)soundAndVibrate{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults boolForKey:kNotificationControlFlag]){
        return -2;//不接受消息
    }
    
    BOOL isSound = [userDefaults boolForKey:kSoundControl];
    BOOL isVibrate = [userDefaults boolForKey:kVibrateControl];
    
    if (isSound && isVibrate) {
        AudioServicesPlaySystemSound(1007);//声音＋振动
    }
    
    if (!isSound && isVibrate) {
         AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//振动
    }
    
    if (isSound && !isVibrate) {
        AudioServicesPlayAlertSound(1007);//声音
    }
    
    return 0;//有接受消息声音
}

@end
