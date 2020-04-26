//
//  Project_RefreshHeader.h
//  PackageProject
//
//  Created by zfk on 2020/4/26.
//  Copyright © 2020 JerryZ. All rights reserved.
//

#import "MJRefreshHeader.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, Project_RefreshHeaderStyle) {
    
    Project_RefreshHeaderStyleArrow_StateLabel_TimeLabel,
    Project_RefreshHeaderStyleArrow_StateLabel,
    Project_RefreshHeaderStyleArrow,
    
    Project_RefreshHeaderStyleGif_StateLabel_TimeLabel,
    Project_RefreshHeaderStyleGif_StateLabel,
    Project_RefreshHeaderStyleGif
};

@interface Project_RefreshHeader : MJRefreshHeader

/// 定义header 的样式
@property (assign, nonatomic) Project_RefreshHeaderStyle style;

/// 创建一个普通的header
- (id)initNormalHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/// 创建一个GIF的header
- (id)initGifHeaderWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@end

NS_ASSUME_NONNULL_END
