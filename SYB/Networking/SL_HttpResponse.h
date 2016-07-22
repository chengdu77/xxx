//
//  SL_HttpResponse.h
//  PodTest
//
//  Created by WangJincai on 16/3/9.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNMessage : NSObject
// 结果编码
@property (nonatomic,strong) NSString *code;

@end

@interface SL_HttpBaseResponse : NSObject

@property(nonatomic,strong) BNMessage *MESSAGE;

@end

//@interface SL_HttpBasePageResponse : SL_HttpBaseResponse
//
//@property(nonatomic,strong) NSMutableArray *DATA;
//
//@end
//
@interface PiblicHttpResponse : SL_HttpBaseResponse

@property (nonatomic,strong) NSMutableArray *messages;
@property(nonatomic,strong) NSMutableDictionary *message;
@end

