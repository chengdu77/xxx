//
//  SL_APIUtil.m
//  PodTest
//
//  Created by WangJincai on 16/3/9.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "SL_APIUtil.h"
#import "AFNetworking.h"
#import "UploadImageParam.h"
#import "SL_NSDictionary2Object.h"
#import "NSString+URL.h"


@interface SL_APIUtil (p)
+(AFHTTPSessionManager *)manager;
@end

@implementation SL_APIUtil(p)

+(AFHTTPSessionManager *)manager{
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager *_manager;
    dispatch_once(&onceToken, ^
                  {
                    _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
                    _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
                    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//                    _manager.securityPolicy.allowInvalidCertificates = YES;//使用HTTPS
 
                  });
    return _manager;
}

@end


@implementation SL_APIUtil


+ (void)getURL:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(SL_HttpBaseResponse *))success failure:(void (^)(BOOL NotReachable,NSString *descript))failure class:(Class)responseClass{
    
    if (!responseClass) {
        responseClass = [SL_HttpBaseResponse class];
    }
    
    AFHTTPSessionManager *manager = SL_APIUtil.manager;
    NSString *URLString = [NSString stringWithFormat:@"%@%@",manager.baseURL,url];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    if (token.length>0) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"user-agent"];
    
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(responseObject){
            NSData *responseData = (NSData *)responseObject;
            NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];

            NSDictionary *dict = [responseString dictionaryWithJsonString:responseString];
            if (dict) {
                NSString *MESSAGECODE = dict[@"code"];
                if ([kSUCCESSCODE isEqual:MESSAGECODE]) {
                    NSObject *object = [dict objectByClass:responseClass];
                    success((SL_HttpBaseResponse*)object);
                }else{
                    if ([MESSAGECODE isEqual:kExpiredRequests]){
                        [self sessionExpiredAction];
                    }else{
                        failure(NO,dict[@"message"]);
                    }
                }
            }else{
                failure(NO,@"网络不给力");
            }
        }else{
            failure(NO,@"没有返回数据");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *er = [NSString stringWithFormat:@"网络不给力:%@",error];
        failure(YES,er);
    }];
}

+ (void)postURL:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(SL_HttpBaseResponse *))success failure:(void (^)(BOOL NotReachable,NSString *descript))failure class:(Class)responseClass{
    
    AFHTTPSessionManager *manager=SL_APIUtil.manager;
    NSString *URLString = [NSString stringWithFormat:@"%@%@",manager.baseURL,url];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    if (token.length>0) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"user-agent"];
    
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(responseObject){
            NSData *responseData = (NSData *)responseObject;
            NSString *responseString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
#if defined(DEBUG)||defined(_DEBUG)
            NSLog(@"responseString:%@ baseURL：%@",responseString,manager.baseURL);
#endif
            NSDictionary *dict = [responseString dictionaryWithJsonString:responseString];
            if (dict) {
                NSString *MESSAGECODE=dict[@"code"];
                if ([kSUCCESSCODE isEqual:MESSAGECODE]) {
                    NSObject *object = [dict objectByClass:responseClass];
                    success((SL_HttpBaseResponse*)object);
                }else{
                    if ([MESSAGECODE isEqual:kExpiredRequests]){
                        [self sessionExpiredAction];
                    }else{
                        failure(NO,dict[@"message"]);
                    }
                }
            }else{
                failure(NO,@"网络不给力");
            }
        }else{
            failure(NO,@"没有返回数据");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSString *er = [NSString stringWithFormat:@"网络不给力:%@",error];
            failure(YES,er);
        }
    }];
    
}

#pragma mark 上传图片
+ (void)uploadWithPath:(NSString *)path
                 parameters:(id)parameters
                uploadParam:(UploadImageParam *)uploadParam
                    success:(void (^)(SL_HttpBaseResponse *))success failure:(void (^)(BOOL NotReachable,NSString *descript))failure class:(Class)responseClass {
    
   
    AFHTTPSessionManager *manager = SL_APIUtil.manager;
    NSString *url =[NSString stringWithFormat:@"%@/%@",manager.baseURL,path];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    if (token.length>0) {
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    }
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"user-agent"];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(responseObject){
            NSData *responseData = (NSData *)responseObject;
            NSString *responseString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
#if defined(DEBUG)||defined(_DEBUG)
            NSLog(@"responseString:%@ baseURL：%@",responseString,manager.baseURL);
#endif
            NSDictionary *dict = [responseString dictionaryWithJsonString:responseString];
            if (dict) {
                NSString *MESSAGECODE = dict[@"code"];
                if ([kSUCCESSCODE isEqual:MESSAGECODE]) {
                    NSObject *object = [dict objectByClass:responseClass];
                    success((SL_HttpBaseResponse*)object);
                }else{
                    if ([MESSAGECODE isEqual:kExpiredRequests]){
                        //会话过期，回到登陆界面
                        [self sessionExpiredAction];
                    }else{
                        failure(NO,dict[@"message"]);
                    }
                }
            }else{
                failure(NO,@"网络不给力");
            }
        }else{
            failure(NO,@"没有返回数据");
        }
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            NSString *er = [NSString stringWithFormat:@"网络不给力:%@",error];
            failure(YES,er);
        }
    }];
}

#pragma mark 会话过期，回到登陆界面
+ (void)sessionExpiredAction{

    NSNotification *notice = [NSNotification notificationWithName:kExpiredRequestsNotification object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}


@end
