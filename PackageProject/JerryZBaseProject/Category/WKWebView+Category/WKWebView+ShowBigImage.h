//
//  WKWebView+ShowBigImage.h
//  PackageProject
//
//  Created by zfk on 2020/4/24.
//  Copyright © 2020 JerryZ. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (ShowBigImage)

/**
 * 通过js获取html中图片url
 */
- (NSArray *)getImageUrlWithJS:(WKWebView *)wkWebView;

/**
 * 显示大图
 */
- (BOOL)showBigImage:(NSURLRequest *)request;

@end

NS_ASSUME_NONNULL_END
