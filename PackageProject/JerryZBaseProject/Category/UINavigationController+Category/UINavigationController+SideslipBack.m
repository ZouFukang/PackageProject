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
    
    // 当我们检测到时UIImagePickerController的时候，让它不可编辑
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
            [self zfc_setNavigationBarAlpha:@(nowAlpha)];
        }
    }
}

#pragma mark - UINavigationControllerDelegate

//此方法是UINavigationControllerDelegate里的一个方法，我们使用该方法来处理侧滑到一半的时候松手，如果不处理的话导航栏的效果会出问题
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    UIViewController *topViewController = self.topViewController;
    if (topViewController != nil) {
        
        id<UIViewControllerTransitionCoordinator> coordinator = topViewController.transitionCoordinator;
        if (coordinator != nil) {
            
            if (@available(iOS 10.0, *)) {
                [coordinator notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    
                    [self dealInteractionChanges:context];
                }];
            } else {
                // Fallback on earlier versions
            }
        }
    }
}


#pragma mark - private method

- (void)zfc_setNavigationBarAlpha:(NSNumber *)navigationBarAlpha {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.navigationBar performSelector:@selector(zfc_setAlpha:) withObject:navigationBarAlpha];
#pragma clang diagnostic pop
}

- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context {
    
    if ([context isCancelled]) {// 滑了一小半不滑了然后松手，自动取消返回手势
        
        NSTimeInterval cancelDuration = [context transitionDuration] * (double)[context percentComplete];
        [UIView animateWithDuration:cancelDuration animations:^{
            
            CGFloat nowAlpha = [context viewControllerForKey:UITransitionContextFromViewControllerKey].navigationBarAlpha;
            [self zfc_setNavigationBarAlpha:@(nowAlpha)];
        }];
    } else {// 滑了一大半松手，自动完成返回手势
        
        NSTimeInterval finishDuration = [context transitionDuration] * (double)(1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            CGFloat nowAlpha = [context viewControllerForKey:
                                UITransitionContextToViewControllerKey].navigationBarAlpha;
            [self zfc_setNavigationBarAlpha:@(nowAlpha)];
        }];
    }
}

@end


@implementation UINavigationController (StatusBar)

// navigationController会拦截其子控制器关于状态栏的配置，所以这里返回其childViewController的相关配置
- (BOOL)prefersStatusBarHidden {
    
    return self.topViewController.prefersStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    
    return self.topViewController.preferredStatusBarUpdateAnimation;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return self.topViewController.preferredStatusBarStyle;
}

@end
