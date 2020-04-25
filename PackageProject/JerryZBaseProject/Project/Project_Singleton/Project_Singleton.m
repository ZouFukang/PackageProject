//
//  Project_Singleton.m
//  PackageProject
//
//  Created by 邹复康 on 2020/4/25.
//  Copyright © 2020 JerryZ. All rights reserved.
//

#import "Project_Singleton.h"

@implementation Project_Singleton
static Project_Singleton * singleton = nil;

+(instancetype)shareSingleton {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        singleton = [[Project_Singleton alloc] init];
    });
    
    return singleton;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    
    return [Project_Singleton shareSingleton];
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    
    return [Project_Singleton shareSingleton];
}

- (instancetype)init{
    
    self = [super init];
    if (self != nil) {
        
        //我们需要设置的属性
        
    }
    
    return self;
}

@end
