//
//  NSObject+Swizzling.m
//  PackageProject
//
//  Created by zfk on 2020/4/23.
//  Copyright © 2020 JerryZ. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (void)swizzlingWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    IMP originalIMP = method_getImplementation(originalMethod);
    IMP swizzleIMP = method_getImplementation(swizzledMethod);
    
    const char *originalTypeEncoding = method_getTypeEncoding(originalMethod);
    const char *swizzledTypeEncoding = method_getTypeEncoding(swizzledMethod);
    
    BOOL didAddMethod = class_addMethod(self, originalSelector, swizzleIMP, swizzledTypeEncoding);
    
    if (didAddMethod) {

        class_replaceMethod(self, swizzledSelector, originalIMP, originalTypeEncoding);
    } else {
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
