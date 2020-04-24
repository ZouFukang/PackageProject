//
//  JWCacheURLProtocol.m
//  JWNetCache
//
//  Created by junwen.deng on 16/8/19.
//  Copyright © 2016年 junwen.deng. All rights reserved.
//

#import "JWCacheURLProtocol.h"

#define kDefaultUpdateInterval 3600

@interface JWUrlCacheConfig: NSObject

@property (readwrite, nonatomic, strong) NSMutableDictionary *urlDict;// 记录上一次url请求时间
@property (readwrite, nonatomic, assign) NSInteger updateInterval;// 相同的url地址请求，相隔大于等于updateInterval才会发出后台更新的网络请求，小于的话不发出请求，默认3600s即1个小时

@property (readwrite, nonatomic, strong) NSOperationQueue *forgeroundNetQueue;
@property (readwrite, nonatomic, strong) NSOperationQueue *backgroundNetQueue;

@end

@implementation JWUrlCacheConfig

- (NSMutableDictionary *)urlDict {
    
    if (_urlDict == nil) {
        
        _urlDict = [NSMutableDictionary dictionary];
    }
    return _urlDict;
}

- (NSInteger)updateInterval {
    if (_updateInterval == 0) {
        
        _updateInterval = kDefaultUpdateInterval;
    }
    return _updateInterval;
}

- (NSOperationQueue *)forgeroundNetQueue {
    
    if (!_forgeroundNetQueue) {
        
        _forgeroundNetQueue = [[NSOperationQueue alloc] init];
        _forgeroundNetQueue.maxConcurrentOperationCount = 10;
    }
    
    return _forgeroundNetQueue;
}

- (NSOperationQueue *)backgroundNetQueue {
    
    if (!_backgroundNetQueue) {
        
        _backgroundNetQueue = [[NSOperationQueue alloc] init];
        _backgroundNetQueue.maxConcurrentOperationCount = 6;
    }
    
    return _backgroundNetQueue;
}

+ (instancetype)instance {
    
    static JWUrlCacheConfig *urlCacheConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        urlCacheConfig = [[JWUrlCacheConfig alloc] init];
    });
    
    return urlCacheConfig;
}

- (void)clearUrlDict {
    
    [JWUrlCacheConfig instance].urlDict = nil;
}

@end



// 用来标记一个请求是否已经被拦截处理过了，如果不标记的话，就会出现死循环，死循环是这样子的：该请求第一次被拦截后会执行startLoading方法，如果startLoading方法内没使用缓存而是继续发起了这个请求（只是咱们这里要使用缓存而已，比如别人要做网络重定向或者添加请求头信息，就会一直发起请求），那么这个请求又会被拦截，继续走startLoading方法继续发起请求，继续被拦截......因此我们要做个标记，让canInitWithRequest检测一下这个请求是否已经被拦截过，拦截过的话就不要再拦截了
static NSString * const kURLProtocolAlreadyHandleKey = @"alreadyHandle";
// 道理同上
static NSString * const kCheckUpdateInBgKey = @"checkUpdateInBg";

@interface JWCacheURLProtocol()

@property (readwrite, nonatomic, strong) NSURLSession *session;
@property (readwrite, nonatomic, strong) NSMutableData *data;
@property (readwrite, nonatomic, strong) NSURLResponse *response;

@end

@implementation JWCacheURLProtocol

// 注册
+ (void)startListeningNetWorking {
    
    [NSURLProtocol registerClass:[JWCacheURLProtocol class]];
}

// 取消注册
+ (void)cancelListeningNetWorking {
    
    [NSURLProtocol unregisterClass:[JWCacheURLProtocol class]];
}

+ (void)clearUrlDict {
    
    [[JWUrlCacheConfig instance] clearUrlDict];
}


#pragma mark - 子类必须实现几个的方法

// 每发起一个请求，都会触发这个方法，在这个方法里面我们可以判断当前这个请求是否需要被拦截被下面一堆方法处理，返回YES代表这个请求需要被拦截处理，反之就是不需要被拦截处理
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    NSString *urlScheme = [[request URL] scheme];
    if ([urlScheme caseInsensitiveCompare:@"http"] == NSOrderedSame || [urlScheme caseInsensitiveCompare:@"https"] == NSOrderedSame) {
        
        // 判断该请求已经被拦截过，或者是否有标记后台更新
        if ([NSURLProtocol propertyForKey:kURLProtocolAlreadyHandleKey inRequest:request] || [NSURLProtocol propertyForKey:kCheckUpdateInBgKey inRequest:request]) {
            
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}

// 这个方法用来返回规范的request，一般使用的话直接返回request就可以了，不用做处理
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    
    return request;
}

// 开始请求，这个方法作用非常大，把当前请求的request拦截下来以后，在这个方法里面对这个request做各种处理，比如使用自定义的缓存、网络重定向、添加请求头信息等
- (void)startLoading {
    
    // 获取该请求在Caches文件夹下的缓存
    NSCachedURLResponse *urlResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:[self request]];
    if (urlResponse) {// 如果缓存存在，则使用缓存，并且开启异步线程去后台发起请求更新缓存
        
        // 将缓存的response作为请求的response，并且不把这次response作为缓存存储
        [self.client URLProtocol:self didReceiveResponse:urlResponse.response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        // 将缓存的data作为请求的data
        [self.client URLProtocol:self didLoadData:urlResponse.data];
        // 标记请求结束
        [self.client URLProtocolDidFinishLoading:self];

        // 开启异步线程去后台发起请求更新缓存
        [self backgroundUpdateCaches];
    } else {// 如果缓存不存在，则发起请求
        
        NSMutableURLRequest *mutableRequest = [[self request] mutableCopy];
        [NSURLProtocol setProperty:@YES forKey:kURLProtocolAlreadyHandleKey inRequest:mutableRequest];// 标记该请求已经被拦截过
        [self netRequestWithRequest:mutableRequest];
    }
}

// 请求结束
- (void)stopLoading {
    
    [self.session invalidateAndCancel];
    self.session = nil;
}


#pragma mark - private method

- (void)backgroundUpdateCaches {
    
    __weak typeof(self) weakSelf = self;
    [[[JWUrlCacheConfig instance] backgroundNetQueue] addOperationWithBlock:^{
        
        NSDate *updateDate = [[JWUrlCacheConfig instance].urlDict objectForKey:weakSelf.request.URL.absoluteString];
        if (updateDate) {// 判读两次相同的url地址发出请求相隔的时间，如果相隔的时间小于给定的时间，不发出请求。否则发出网络请求
            
            NSDate *currentDate = [NSDate date];
            NSInteger interval = [currentDate timeIntervalSinceDate:updateDate];
            if (interval < [JWUrlCacheConfig instance].updateInterval) {
                return;
            }
        }
        
        NSMutableURLRequest *mutableRequest = [[weakSelf request] mutableCopy];
        [NSURLProtocol setProperty:@YES forKey:kCheckUpdateInBgKey inRequest:mutableRequest];
        [weakSelf netRequestWithRequest:mutableRequest];
    }];
}

// 使用NSURLSession把request发送出去
- (void)netRequestWithRequest:(NSURLRequest *)request {
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[JWUrlCacheConfig instance].forgeroundNetQueue];
    NSURLSessionDataTask *sessionTask = [self.session dataTaskWithRequest:request];
    [[JWUrlCacheConfig instance].urlDict setValue:[NSDate date] forKey:self.request.URL.absoluteString];
    [sessionTask resume];
}

// 拼接urlsession请求到的数据
- (void)appendData:(NSData *)newData {
    
    if ([self data] == nil) {
        
        [self setData:[newData mutableCopy]];
    } else {
        
        [[self data] appendData:newData];
    }
}


#pragma mark - NSURLSessionDataDelegate

// 按理说这里我们是用NSURLSession请求的数据，已经不是webview发起的请求了，是两个不同的请求发起点，那请求回来的数据怎么返回给webview呢？同样是把response交给NSProtocol的client就可以了，client会自动把response转到webview上

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    // 将session请求的data作为webview的data
    [self.client URLProtocol:self didLoadData:data];
    
    [self appendData:data];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    
    // 将session请求的response作为webview的response
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    self.response = response;
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    if (error) {
        
        // 标记请求出错
        [self.client URLProtocol:self didFailWithError:error];
    } else {
        
        // 标记请求结束
        [self.client URLProtocolDidFinishLoading:self];
        
        if (!self.data) {
            
            return;
        }
        
        // 存储该请求的缓存
        NSCachedURLResponse *cacheUrlResponse = [[NSCachedURLResponse alloc] initWithResponse:task.response data:self.data];
        [[NSURLCache sharedURLCache] storeCachedResponse:cacheUrlResponse forRequest:self.request];
        self.data = nil;
    }
}

@end
