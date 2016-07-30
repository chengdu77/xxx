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


#pragma mark 文件上传(图片）
+ (void)tokenUploadRequestParameters:(NSDictionary *)parameters uploadParam:(UploadImageParam *)uploadParam success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil uploadWithPath:kURL_token_upload parameters:parameters uploadParam:uploadParam success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

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

#pragma mark 修改用户密码
+ (void)userUpdatePasswordRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_user_updatePassword parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 修改用户信息
+ (void)userUpdateInfoRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail {
    
    [SL_APIUtil postURL:kURL_user_updateInfo parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}


#pragma mark 修改用户头像
+ (void)userUpdateIconRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_user_updateIcon parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 获取用户联系人列表
+ (void)userGetContactsRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_user_getContacts parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 新增联系人
+ (void)userAddContactRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_user_addContact parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 修改联系人
+ (void)userUpdateContactRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_user_updateContact parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 删除联系人
+ (void)userDeleteContactRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_user_deleteContact parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 登陆用户信息
+ (void)userMyInfoRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_user_myInfo parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 新建病历
+ (void)patientAddRecordRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_patient_addRecord parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 获取病历列表
+ (void)patientGetRecordsRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_patient_getRecords parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 获取病历详情
+ (void)patientGetRecordRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_patient_getRecord parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 删除病历
+ (void)patientDeleteRecordRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_patient_deleteRecord parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

#pragma mark 获取我的主题(发帖)和回帖
+ (void)bbsContentMyRequestParameters:(NSDictionary *)parameters success:(void(^)(PiblicHttpResponse *response))success fail:(void(^)(BOOL notReachable,NSString *desciption))fail{
    
    [SL_APIUtil postURL:kURL_bbs_content_my parameters:parameters success:^(SL_HttpBaseResponse * response) {
        success((PiblicHttpResponse *)response);
    } failure:^(BOOL NotReachable, NSString *descript) {
        fail(NotReachable,descript);
    } class:[PiblicHttpResponse class]];
}

@end
