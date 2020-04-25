//
//  Project_Singleton.h
//  PackageProject
//
//  Created by 邹复康 on 2020/4/25.
//  Copyright © 2020 JerryZ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Project_Singleton : NSObject<NSCopying,NSMutableCopying>

+(instancetype)shareSingleton;

@end

NS_ASSUME_NONNULL_END
