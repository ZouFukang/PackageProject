//
//  JWCacheURLProtocol.h
//  JWNetCache
//
//  Created by junwen.deng on 16/8/19.
//  Copyright © 2016年 junwen.deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWCacheURLProtocol : NSURLProtocol <NSURLSessionDataDelegate>

+ (void)startListeningNetWorking;
+ (void)cancelListeningNetWorking;

+ (void)clearUrlDict;// 收到内存警告的时候可以调用这个方法清空内存中的url记录

@end
