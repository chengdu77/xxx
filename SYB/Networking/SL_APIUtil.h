//
//  SL_APIUtil.h
//  PodTest
//
//  Created by WangJincai on 16/3/9.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadImageParam.h"
#import "SL_HttpRequest.h"
#import "SL_HttpResponse.h"

@class UploadImageParam;

/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost
};

@interface SL_APIUtil : NSObject


+ (void)getURL:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(SL_HttpBaseResponse *))success failure:(void (^)(BOOL NotReachable,NSString *descript))failure class:(Class)responseClass;

+ (void)postURL:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(SL_HttpBaseResponse *))success failure:(void (^)(BOOL NotReachable,NSString *descript))failure class:(Class)responseClass;

/**
 *  上传图片
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param UploadImageParam 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
+ (void)uploadWithPath:(NSString *)path
                 parameters:(id)parameters
                uploadParam:(UploadImageParam *)uploadParam
                    success:(void (^)(SL_HttpBaseResponse *))success failure:(void (^)(BOOL NotReachable,NSString *descript))failure class:(Class)responseClass;

@end
