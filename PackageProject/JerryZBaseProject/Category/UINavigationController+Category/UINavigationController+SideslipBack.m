//
//  UINavigationController+SideslipBack.m
//  MyProject
//
//  Created by zfk on 2020/4/23.
//  Copyright © 2020 JerryZ. All rights reserved.
//

#import "UINavigationController+SideslipBack.h"

@interface UINavigationController () <UINavigationControllerDelegate>

@end

@implementation UINavigationController (SideslipBack)

// push下一个页面的时候自动隐藏tabbar
- (void)zfc_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 当检测到self.viewControllers.count == 1了才能push下一个界面
    if (self.viewControllers.count >= 1) {
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 只有检测到hidesBottomBarWhenPushed的状态，才能push下一个界面，否次会出问题
    [self zfc_pushViewController:viewController animated:YES];
    
    // 当我们检测到时UIImagePickerController的时候，让他不可编辑
    if ([[self class] isEqual:[UIImagePickerController class]]) {
        
        return;
    }
    
    if (self.delegate != self) {
        
        self.delegate = self;
    }

}

// 侧滑返回的时候导航栏的设置
- (void)zfc_updateSystemInteractive:(CGFloat)percentAlpha {
    
    [self zfc_updateSystemInteractive:percentAlpha];
    
    UIViewController * topViewController = self.topViewController;
    if (topViewController != nil) {
        
        id<UIViewControllerTransitionCoordinator> coordinator = topViewController.transitionCoordinator;
        if (coordinator != nil) {
            
            CGFloat fromAlpha = [coordinator viewControllerForKey:UITransitionContextFromViewControllerKey].navigationBarAlpha;// 读取要返回的viewController的导航栏透明度
            CGFloat toAlpha = [coordinator viewControllerForKey:UITransitionContextToViewControllerKey].navigationBarAlpha;// 读取要返回到的viewController的导航栏透明度
            CGFloat nowAlpha = fromAlpha + (toAlpha - fromAlpha) * percentAlpha;
        }
    }
}

@end
