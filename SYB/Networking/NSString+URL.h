//
//  NSString+URL.h
//  URL转义
//
//  Created by WangJincai on 16/3/9.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (URL)

// URL转义
- (NSString *)URLEncodedString;

- (NSString*)URLDecodedString;

// 字符串是否为空
- (BOOL)isEmptyOrWhitespace;

// 去除空格
- (NSString *)trimmedWhitespaceString;

// 取出回车
- (NSString *)trimmedWhitespaceAndNewlineString;

// 判断是是否为手机号
- (BOOL)isTelephone;

// 邮箱判断
- (BOOL)isEmail;

- (NSString *)convertCNToPinyin;

// 弱密码判断
- (BOOL)isWeakPswd;

//把格式化的JSON格式的字符串转换成字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
