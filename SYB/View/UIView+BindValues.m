//
//  UIView+BindValues.m
//  JCDB
//
//  Created by WangJincai on 16/1/6.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "UIView+BindValues.h"
#import <objc/runtime.h>

@implementation UIView (BindValues)


- (NSString *)Id{
    return objc_getAssociatedObject(self, @selector(Id));
}

- (void)setId:(NSString *)Id{
    objc_setAssociatedObject(self, @selector(Id), Id, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)value{
    return objc_getAssociatedObject(self, @selector(value));
}

- (void)setValue:(id)value{
    objc_setAssociatedObject(self, @selector(value), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSNumber *)type{
    return objc_getAssociatedObject(self, @selector(type));
}

- (void)setType:(NSNumber *)type{
    objc_setAssociatedObject(self, @selector(type), type, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSNumber *)must{
    return objc_getAssociatedObject(self, @selector(must));
}

- (void)setMust:(NSNumber *)must{
    objc_setAssociatedObject(self, @selector(must), must, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)number{
    return objc_getAssociatedObject(self, @selector(number));
}

- (void)setNumber:(NSNumber *)number{
    objc_setAssociatedObject(self, @selector(number), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
