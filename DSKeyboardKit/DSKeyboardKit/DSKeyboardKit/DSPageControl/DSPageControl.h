//
//  DSPageControl.h
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/29.
//  Copyright © 2018 HelloAda. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSPageControl : UIView

// 总共多少页
@property (nonatomic, assign) NSInteger pageCount;

// 当前选中页
@property (nonatomic, assign) NSInteger selectedPage;

// 没选中的颜色
@property (nonatomic, strong) UIColor *unSelectedCorlor;

// 选中的颜色
@property (nonatomic, strong) UIColor *selectedColor;

// 绑定的滚动视图
@property (nonatomic, strong) UIScrollView *bindScrollView;

// 指示的圆圈的大小
@property (nonatomic, assign) CGFloat indicatorSize;

// 横线的高度，只有在需要用横线指示时才有效
@property (nonatomic, assign) CGFloat lineHeight;

// 相邻的两个圆圈之间的距离
@property (nonatomic, assign) CGFloat interval;

@end

NS_ASSUME_NONNULL_END
