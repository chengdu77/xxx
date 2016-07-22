//
//  SL_HttpRequest.m
//  PodTest
//
//  Created by WangJincai on 16/3/9.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "SL_HttpRequest.h"


@implementation SL_HttpBaseRequest


@end

@implementation SL_HttpBasePageRequest

-(id)init{
    self = [super init];
    if (self) {
        self.ROWS = kRows;
        self.PAGE = kPages;
    }
    return self;
}

@end

@implementation UploadLogHttpRequest

@end
