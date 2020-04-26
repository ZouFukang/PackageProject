//
//  Project_RefreshFooter.h
//  PackageProject
//
//  Created by 邹复康 on 2020/4/26.
//  Copyright © 2020 JerryZ. All rights reserved.
//

#import "MJRefreshFooter.h"

typedef NS_ENUM(NSInteger, Project_RefreshFooterStyle) {
    
    ProjectRefreshFooterStyleStyleArrow_StateLabel,
    ProjectRefreshFooterStyleStyleGif_StateLabel
};

@interface Project_RefreshFooter : MJRefreshFooter

/// 普通或 gif footer 的样式
@property (assign, nonatomic) Project_RefreshFooterStyle style;


/**
 *  创建一个普通的 footer
 */
- (id)initNormalFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/**
 *  创建一个动图的 footer
 */
- (id)initGifFooterWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@end
