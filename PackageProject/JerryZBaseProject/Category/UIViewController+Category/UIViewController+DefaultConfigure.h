//
//  UIViewController+DefaultConfigure.h
//  MyProject
//
//  Created by zfk on 2020/4/23.
//  Copyright © 2020 JerryZ. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *此分类是把所有的controller做一个统一的配置
 */
@interface UIViewController (DefaultConfigure)

@end

/**
 *此分类是负责对z导航栏的一些配置
 *
 **/
@interface UIViewController (NavigationBar)

// 当前viewController导航栏的透明度（0~1.0），可以用来设置导航栏的渐变效果或者导航栏的显隐，该属性应写在viewDidAppear方法里
@property (assign, nonatomic) CGFloat navigationBarAlpha;

@end

/**
 *此分类主要负责导航栏BarButtonItem的一些配置
 */
@interface UIViewController (NavigationBarButtonItem)

/**
 *为了统一BarButtonItem，保持多个开发者开发的一致性，如果有变化，则重写次方法
 */
- (UIBarButtonItem *)leftBarButtonItemWithTitle:(NSString *)title;
- (UIBarButtonItem *)leftBarButtonItemWithImage:(UIImage *)image;
- (UIBarButtonItem *)leftBarButtonItemWithCustomView:(UIView *)customView;
- (UIBarButtonItem *)rightBarButtonItemWithTitle:(NSString *)title;
- (UIBarButtonItem *)rightBarButtonItemWithImage:(UIImage *)image;
- (UIBarButtonItem *)rightBarButtonItemWithCustomView:(UIView *)customView;

/**
 *  leftBarButtonItem事件
 */
- (void)leftBarButtonItemAction:(UIBarButtonItem *)leftBarButtonItem;

/**
 *  rightBarButtonItem事件
 */
- (void)rightBarButtonItemAction:(UIBarButtonItem *)rightBarButtonItem;

@end


/**
 * 此分类的作用：主要负责导航栏控制器的一些配置
 */
@interface UIViewController (NavigationController)

/// 是否开启侧滑返回
@property (assign, nonatomic) BOOL enableSlideBack;

@end


/**
 * 该分类的作用：主要负责状态栏的一些配置
 */
@interface UIViewController (StatusBar)

@end
