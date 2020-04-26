//
//  Project_TabBar.h
//  PackageProject
//
//  Created by 邹复康 on 2020/4/26.
//  Copyright © 2020 JerryZ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Project_TabBar : UITabBar

@property (nonatomic, assign) CGSize centerButtonSize;
@property (nonatomic, assign) CGFloat centerButtonOffset;
@property (nonatomic,   copy) NSString *centerButtonImageName;
@property (nonatomic,   copy) void(^centerButtonBlock)(UIButton *centerButton);

@end

NS_ASSUME_NONNULL_END
