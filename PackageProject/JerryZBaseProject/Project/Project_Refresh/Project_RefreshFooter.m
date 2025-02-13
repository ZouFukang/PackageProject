//
//  Project_RefreshFooter.m
//  PackageProject
//
//  Created by 邹复康 on 2020/4/26.
//  Copyright © 2020 JerryZ. All rights reserved.
//

#import "Project_RefreshFooter.h"
#import "MJRefresh.h"

#define kGifImageCount 3


/***************
 *  NormalFooter
 **************/

@interface NormalFooter : MJRefreshBackNormalFooter

@end


@implementation NormalFooter

// 重写 prepare 方法来配置 refreshFooter 的样式
- (void)prepare {
    
    [super prepare];
    
    // NormalFooter 默认样式
    [self setArrow_stateLabel_footerStyle];
}


#pragma mark - footerStyle

- (void)setArrow_stateLabel_footerStyle {
    
    // stateLabel
    [self setTitle:@"上拉加载" forState:(MJRefreshStateIdle)];
    [self setTitle:@"释放更新" forState:(MJRefreshStatePulling)];
    [self setTitle:@"加载中..." forState:(MJRefreshStateRefreshing)];
}

@end



/************
 *  GifFooter
 ***********/

@interface GifFooter : MJRefreshBackGifFooter

@end


@implementation GifFooter

// 重写 prepare 方法来配置 refreshHeader 的样式
- (void)prepare {
    [super prepare];
    
    // GifFooter 默认样式
    [self setGif_stateLabel_footerStyle];
}


#pragma mark - footerStyle

- (void)setGif_stateLabel_footerStyle {
    
    // gif
    NSMutableArray *imageArray = [NSMutableArray array];
    for (NSInteger i = 0; i < kGifImageCount; i ++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_%ld", i]];
        [imageArray addObject:image];
    }
    [self setImages:@[[UIImage imageNamed:@"refresh_0"]] forState:(MJRefreshStateIdle)];// 设置闲置状态的图片(闲置状态 = 闲置 + 下拉但还没有下拉到松手即刷新的状态)
    [self setImages:imageArray forState:(MJRefreshStatePulling)];// 设置松手即刷新的图片
    [self setImages:imageArray forState:(MJRefreshStateRefreshing)];// 设置正在刷新的图片
    
    // stateLabel
    [self setTitle:@"上拉加载" forState:(MJRefreshStateIdle)];
    [self setTitle:@"释放更新" forState:(MJRefreshStatePulling)];
    [self setTitle:@"加载中..." forState:(MJRefreshStateRefreshing)];
}

@end



/***********************
 *  ProjectRefreshFooter
 **********************/

@interface Project_RefreshFooter ()

@property (nonatomic, strong) NormalFooter *normalFooter;
@property (nonatomic, strong) GifFooter *gifFooter;

@end

@implementation Project_RefreshFooter

- (id)initNormalFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action; {
    
    _normalFooter = [[NormalFooter alloc] init];
    [_normalFooter setRefreshingTarget:target refreshingAction:action];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    return _normalFooter;
#pragma clang diagnostic pop
}

- (id)initGifFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action {

    _gifFooter = [[GifFooter alloc] init];
    [_gifFooter setRefreshingTarget:target refreshingAction:action];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    return _gifFooter;
#pragma clang diagnostic pop
}

@end
