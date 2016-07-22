//
//  SL_HttpRequest.h
//  PodTest
//
//  Created by WangJincai on 16/3/9.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SL_HttpBaseRequest : NSObject

@property (nonatomic,strong) NSString *requestPath;

@end

@interface SL_HttpBasePageRequest : SL_HttpBaseRequest

@property(nonatomic,assign) NSInteger ROWS;
@property(nonatomic,assign) NSInteger PAGE;

@end


@interface UploadLogHttpRequest : SL_HttpBaseRequest
//@property(nonatomic,strong) NSString *logloglog;
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *method;
@property(nonatomic,strong) NSString *j_username;
@property(nonatomic,strong) NSString *j_password;
@property(nonatomic,strong) NSString *packageName;
@property(nonatomic,strong) NSString *isFirstRequest;
@end

