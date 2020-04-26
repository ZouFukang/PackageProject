//
//  Project_RefreshHeader.m
//  PackageProject
//
//  Created by zfk on 2020/4/26.
//  Copyright © 2020 JerryZ. All rights reserved.
//

#import "Project_RefreshHeader.h"
#import "MJRefreshHeader.h"

#define kGifImageCount 3

/// 普通的Header

typedef NS_ENUM(NSInteger, NormalHeaderStyle) {
    
    NormalHeaderStyleArrow_StateLabel_TimeLabel = 0,
    NormalHeaderStyleArrow_StateLabel = 1,
    NormalHeaderStyleArrow = 2
};

@interface NormalHeader : MJRefreshNormalHeader

@property (nonatomic, assign) NormalHeaderStyle style;

@end

@implementation NormalHeader

// 重写 prepare方法配置refreshHeader的样式
- (void)prepare {
    
    [super prepare];
    
    // 普通样式的默认样式
    self.style = NormalHeaderStyleArrow_StateLabel;
}

#pragma mark - headerStyle

- (void)setArrow_stateLabel_timeLabel_headerStyle {
    
    // 恢复到初始状态
    [self mjRefreshInitState];
    // stateLabel
    [self setTitle:@"下拉刷新" forState:(MJRefreshStateIdle)];
    [self setTitle:@"释放更新" forState:(MJRefreshStatePulling)];
    [self setTitle:@"加载中..." forState:(MJRefreshStateRefreshing)];
    
    // timeLabel
    self.lastUpdatedTimeLabel.hidden = YES;
}

- (void)setArrow_stateLabel_headerStyle {
    
    // 恢复到初始状态
    [self mjRefreshInitState];
    
    // stateLabel
    [self setTitle:@"下拉刷新" forState:(MJRefreshStateIdle)];
    [self setTitle:@"释放更新" forState:(MJRefreshStatePulling)];
    [self setTitle:@"加载中..." forState:(MJRefreshStateRefreshing)];
    
    // 隐藏timeLabel
    self.lastUpdatedTimeLabel.hidden = YES;
}

- (void)setArrow_headerStyle {
    
    // 恢复到初始状态
    [self mjRefreshInitState];
    // 隐藏stateLabel
    self.stateLabel.hidden = YES;
    
    // 隐藏timeLabel
    self.lastUpdatedTimeLabel.hidden = YES;
}

#pragma mark - setter && getter

- (void)setStyle:(NormalHeaderStyle)style {
    
    _style = style;
    
    switch (_style) {
        case NormalHeaderStyleArrow_StateLabel_TimeLabel:
            [self setArrow_stateLabel_timeLabel_headerStyle];
            break;
        case NormalHeaderStyleArrow_StateLabel:
            [self setArrow_stateLabel_headerStyle];
            break;
        case NormalHeaderStyleArrow:
            [self setArrow_headerStyle];
            break;
            
        default:
            break;
    }
}

#pragma mark - MJRefresh初始状态
- (void)mjRefreshInitState {
    
    self.stateLabel.hidden = NO;
    self.lastUpdatedTimeLabel.hidden = NO;
    
    if ([self.lastUpdatedTimeLabel.text isEqualToString:@"最后更新：无记录"]) {
        
        self.lastUpdatedTimeLabel.text = @"无记录";
    }
    
    if (self.lastUpdatedTimeLabel.text.length == 13) {
        
        self.lastUpdatedTimeLabel.text = [self.lastUpdatedTimeLabel.text substringFromIndex:8];
    }
}

@end

/// gif的Header

typedef NS_ENUM(NSInteger, GifHeaderStyle) {
    
    GifHeaderStyleGif_StateLabel_TimeLabel = 3,
    GifHeaderStyleGif_StateLabel = 4,
    GifHeaderStyleGif = 5
};

@interface GifHeader : MJRefreshGifHeader

@property (assign, nonatomic) GifHeaderStyle style;

@end


@implementation GifHeader

// 重写 prepare 方法来配置 refreshHeader 的样式
- (void)prepare {
    [super prepare];
    
    // GifHeader 默认样式
    self.style = GifHeaderStyleGif;
}


#pragma mark - headerStyle

- (void)setGif_stateLabel_timeLabel_headerStyle {
    
    // 恢复到初始状态
    [self mjRefreshInitState];
    
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
    [self setTitle:@"下拉刷新" forState:(MJRefreshStateIdle)];
    [self setTitle:@"释放更新" forState:(MJRefreshStatePulling)];
    [self setTitle:@"加载中..." forState:(MJRefreshStateRefreshing)];
    
    // timeLabel
    self.lastUpdatedTimeText = ^NSString *(NSDate *lastUpdatedTime) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm";
        NSString *time = [formatter stringFromDate:lastUpdatedTime];
        if (String_Is_Empty(time)) {
            
            time = @"无记录";
        }
        return time;
    };
}

- (void)setGif_stateLabel_headerStyle {
    
    // 恢复到初始状态
    [self mjRefreshInitState];
    
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
    [self setTitle:@"下拉刷新" forState:(MJRefreshStateIdle)];
    [self setTitle:@"释放更新" forState:(MJRefreshStatePulling)];
    [self setTitle:@"加载中..." forState:(MJRefreshStateRefreshing)];
    
    // timeLabel
    self.lastUpdatedTimeLabel.hidden = YES;
}

- (void)setGif_headerStyle {
    
    // 恢复到初始状态
    [self mjRefreshInitState];
    
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
    self.stateLabel.hidden = YES;
    
    // timeLabel
    self.lastUpdatedTimeLabel.hidden = YES;
}


#pragma mark - setter, getter

- (void)setStyle:(GifHeaderStyle)style {
    
    _style = style;
    
    switch (_style) {
        case GifHeaderStyleGif_StateLabel_TimeLabel:
            [self setGif_stateLabel_timeLabel_headerStyle];
            break;
        case GifHeaderStyleGif_StateLabel:
            [self setGif_stateLabel_headerStyle];
            break;
        case GifHeaderStyleGif:
            [self setGif_headerStyle];
            break;
    }
}


#pragma mark - MJRefresh 初始状态

- (void)mjRefreshInitState {
    
    self.stateLabel.hidden = NO;
    self.lastUpdatedTimeLabel.hidden = NO;
    
    if ([self.lastUpdatedTimeLabel.text isEqualToString:@"最后更新：无记录"]) {
        
        self.lastUpdatedTimeLabel.text = @"无记录";
    }
    
    if (self.lastUpdatedTimeLabel.text.length == 13) {
        
        self.lastUpdatedTimeLabel.text = [self.lastUpdatedTimeLabel.text substringFromIndex:8];
    }
}

@end



/// Project_RefreshHeader

@interface Project_RefreshHeader ()

@property (nonatomic, strong) NormalHeader *normalHeader;
@property (nonatomic, strong) GifHeader *gifHeader;

@end

@implementation Project_RefreshHeader

- (id)initNormalHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action; {
    
    _normalHeader = [[NormalHeader alloc] init];
    [_normalHeader setRefreshingTarget:target refreshingAction:action];
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    return _normalHeader;
#pragma clang diagnostic pop
}

- (id)initGifHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action; {

    _gifHeader = [[GifHeader alloc] init];
    [_gifHeader setRefreshingTarget:target refreshingAction:action];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    return _gifHeader;
#pragma clang diagnostic pop
}

@end
