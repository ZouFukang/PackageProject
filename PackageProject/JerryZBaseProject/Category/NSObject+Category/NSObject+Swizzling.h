//
//  NSObject+Swizzling.h
//  PackageProject
//
//  Created by zfk on 2020/4/23.
//  Copyright © 2020 JerryZ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)

/**
 *利用OC的动态性，在运行时替换替换方法
 */
+ (void)swizzlingWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
