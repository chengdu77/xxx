//
//  ContactsRequest.m
//  SLYLT
//
//  Created by WangJincai on 16/4/18.
//  Copyright © 2016年 Shenlan.com. All rights reserved.
//

#import "ContactsRequest.h"
#import "SL_APIUtil.h"

@implementation ContactsRequest

#pragma mark 1.登录
+ (void)loginRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{

    [SL_APIUtil postURL:kURL_login parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
    
}

#pragma mark 用户注册／密码修改
+ (void)registerRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_register parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
    
}

#pragma mark 短信
+ (void)smsRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_sms parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 察看圈子主分类
+ (void)bbsModuleRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_bbs_module parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
    
}

#pragma mark 察看圈子子分类
+ (void)bbsModuleChildRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_bbs_module_child parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 查看圈子里已发帖子
+ (void)bbsContentDetailRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_bbs_content_detail parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 查看圈子分类所有列表或者回贴列表
+ (void)bbsContentListRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_bbs_content_list parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 按页查看圈子分类发帖列表
+ (void)bbsContentListPageRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_bbs_content_list_page parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 圈子发帖和回帖
+ (void)bbsContentPostRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_bbs_content_post parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 删除圈子已发帖子
+ (void)bbsContentDeleteRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_bbs_content_delete parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

@end
