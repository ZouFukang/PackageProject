//
//  Project_ProgressHUD.m
//  PackageProject
//
//  Created by zfk on 2020/4/24.
//  Copyright © 2020 JerryZ. All rights reserved.
//

#import "Project_ProgressHUD.h"

#define kMBProgressHUDLabelHeight 59.5

@implementation Project_ProgressHUD

#pragma mark - SystemHUD

+ (void)showSystemProgressHUDToView:(UIView *)view {
    
    [self showSystemProgressHUDToView:view];
    
    UIView *maskView = [[UIView alloc] initWithFrame:view.bounds];
    maskView.backgroundColor = [UIColor clearColor];
    maskView.tag = 1111111;
    [view addSubview:maskView];
    
    UIActivityIndicatorView *systemHUD = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    systemHUD.center = view.center;
    systemHUD.transform = CGAffineTransformMakeScale(1.618, 1.618);
    systemHUD.hidesWhenStopped = YES;
    systemHUD.tag = 1111112;
    [view addSubview:systemHUD];
    [systemHUD startAnimating];
}

+ (void)hideSystemProgressHUDFromView:(UIView *)view {
    
    UIView *tempMaskView = [view viewWithTag:1111111];
    UIActivityIndicatorView *tempSystemHUD = [view viewWithTag:1111112];
    
    if (tempSystemHUD != NULL && tempMaskView != NULL) {
        
        [tempSystemHUD stopAnimating];
        [tempSystemHUD removeFromSuperview];
        [tempMaskView removeFromSuperview];
    }
}


#pragma mark - MBProgressHUD

+ (void)showMBProgressHUDToView:(UIView *)view withText:(NSString *)text {
    
    MBProgressHUD *mbProgressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    mbProgressHUD.label.text = text;
    mbProgressHUD.label.numberOfLines = 0;
}

+ (void)showMBProgressHUDToView:(UIView *)view withGifName:(NSString *)gifName {
    
    MBProgressHUD *mbProgressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    mbProgressHUD.mode = MBProgressHUDModeCustomView;
    mbProgressHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    mbProgressHUD.bezelView.backgroundColor = [UIColor clearColor];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:gifName ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    FLAnimatedImageView *gifImageView = [[FLAnimatedImageView alloc] init];
    gifImageView.contentMode = UIViewContentModeScaleAspectFit;
    gifImageView.animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
    
    mbProgressHUD.customView = gifImageView;
}

+ (void)showMBProgressHUDToView:(UIView *)view withImageNameArray:(NSArray<NSString *> *)imageNameArray {
    
    MBProgressHUD *mbProgressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    mbProgressHUD.mode = MBProgressHUDModeCustomView;
    mbProgressHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    mbProgressHUD.bezelView.backgroundColor = [UIColor clearColor];
    
    UIImageView *gifImageView = [[UIImageView alloc] init];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSInteger i = 0; i < imageNameArray.count; i++) {
        
        [imageArray addObject:[UIImage imageNamed:imageNameArray[i]]];
    }
    gifImageView.animationImages = imageArray;
    gifImageView.animationDuration = 1.0;
    gifImageView.animationRepeatCount = 0;
    
    mbProgressHUD.customView = gifImageView;
    [gifImageView startAnimating];
}

+ (void)hideMBProgressHUDFromView:(UIView *)view {
    
    MBProgressHUD *tempMBProgressHUD = [MBProgressHUD HUDForView:view];
    [tempMBProgressHUD hideAnimated:YES];
}

+ (void)showMBProgressHUDToView:(UIView *)view withText:(NSString *)text atPosition:(MBProgressHUDPosition)position autoHideAfterTimeInterval:(CGFloat)timeInterval completionHandlerAfterAutohide:(void(^)(void))completionHandler; {
    
    MBProgressHUD *mbProgressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    mbProgressHUD.mode = MBProgressHUDModeText;
    mbProgressHUD.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.618];
    mbProgressHUD.contentColor = [UIColor whiteColor];
    
    mbProgressHUD.label.text = text;
    mbProgressHUD.label.numberOfLines = 0;
    
    switch (position) {
            
        case MBProgressHUDPositionTop:
            mbProgressHUD.offset = CGPointMake(0, -CGRectGetHeight(view.frame) / 2.0 + Navigation_Bar_Height + kMBProgressHUDLabelHeight / 2.0);
            break;
            
        case MBProgressHUDPositionCenter:
            break;
            
        case MBProgressHUDPositionBottom:
            mbProgressHUD.offset = CGPointMake(0, CGRectGetHeight(view.frame) / 2.0 - Tab_Bar_Height - kMBProgressHUDLabelHeight / 2.0);
            break;
    }
    
    mbProgressHUD.completionBlock = ^{
        
        if (completionHandler) {
            
            completionHandler();
        }
    };
    
    [mbProgressHUD hideAnimated:YES afterDelay:timeInterval];
}

+ (void)showMBProgressHUDToView:(UIView *)view withText:(NSString *)text image:(NSString *)imageName autoHideAfterTimeInterval:(CGFloat)timeInterval completionHandlerAfterAutohide:(void(^)(void))completionHandler {
    
    MBProgressHUD *mbProgressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    mbProgressHUD.mode = MBProgressHUDModeCustomView;
    mbProgressHUD.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.618];
    mbProgressHUD.contentColor = [UIColor whiteColor];
    
    mbProgressHUD.customView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    mbProgressHUD.label.text = text;
    mbProgressHUD.label.numberOfLines = 0;
    
    mbProgressHUD.completionBlock = ^{
        
        if (completionHandler) {
            
            completionHandler();
        }
    };
    
    [mbProgressHUD hideAnimated:YES afterDelay:timeInterval];
}

+ (void)showMBProgressHUDToView:(UIView *)view withInitProgressPrompt:(NSString *)prompt {
    
    MBProgressHUD *mbProgressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    mbProgressHUD.mode = MBProgressHUDModeAnnularDeterminate;
    mbProgressHUD.bezelView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.618];
    mbProgressHUD.contentColor = [UIColor whiteColor];
    
    mbProgressHUD.label.text = prompt;
}

+ (void)updateMBProgressHUDOnView:(UIView *)view withProgress:(CGFloat)progress progressPrompt:(NSString *)prompt {
    
    MBProgressHUD *tempMBProgressHUD = [MBProgressHUD HUDForView:view];
    if ([self respondsToSelector:@selector(showMBProgressHUDToView:withInitProgressPrompt:)]) {
        
        tempMBProgressHUD.progress = progress;
        tempMBProgressHUD.label.text = prompt;
    }
}

+ (void)updateMBProgressHUDOnView:(UIView *)view withRequstResult:(MBProgressHUDResult)result progressPrompt:(NSString *)prompt autoHideAfterTimeInterval:(CGFloat)timeInterval completionHandlerAfterAutohide:(void(^)(void))completionHandler {
    
    MBProgressHUD *tempMBProgressHUD = [MBProgressHUD HUDForView:view];
    if ([self respondsToSelector:@selector(showMBProgressHUDToView:withInitProgressPrompt:)] && [self respondsToSelector:@selector(updateMBProgressHUDOnView:withProgress:progressPrompt:)]) {
        
        tempMBProgressHUD.mode = MBProgressHUDModeCustomView;
        tempMBProgressHUD.label.text = prompt;
        
        if (result == MBProgressHUDResultSuccess) {
            
            tempMBProgressHUD.customView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"BaseProject_MBProgressHUDResultSuccess"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }else if (result == MBProgressHUDResultError) {
            
            tempMBProgressHUD.customView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"BaseProject_MBProgressHUDResultError"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        }
        
        tempMBProgressHUD.completionBlock = ^{
            
            if (completionHandler) {
                
                completionHandler();
            }
        };
        
        [tempMBProgressHUD hideAnimated:YES afterDelay:timeInterval];
    }
}

@end
