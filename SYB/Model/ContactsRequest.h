//
//  SystemRequest.h
//  SLYLT
//
//  Created by WangJincai on 16/4/18.
//  Copyright © 2016年 Shenlan.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SL_HttpRequest.h"
#import "SL_HttpResponse.h"

@class UploadImageParam;

@interface ContactsRequest : NSObject

#pragma mark 登录
+ (void)loginRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail;


#pragma mark 用户注册／密码修改
+ (void)registerRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail;

#pragma mark 短信
+ (void)smsRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail;

#pragma mark 察看圈子主分类
+ (void)bbsModuleRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail;

#pragma mark 察看圈子子分类
+ (void)bbsModuleChildRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail;

#pragma mark 查看圈子里已发帖子
+ (void)bbsContentDetailRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail;

#pragma mark 查看圈子分类所有列表或者回贴列表
+ (void)bbsContentListRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail;

#pragma mark 按页查看圈子分类发帖列表
+ (void)bbsContentListPageRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail;

#pragma mark 圈子发帖和回帖
+ (void)bbsContentPostRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail;

#pragma mark 删除圈子已发帖子
+ (void)bbsContentDeleteRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail;
@end
