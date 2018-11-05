//
//  DSPageControl.h
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/29.
//  Copyright © 2018 HelloAda. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DSSelectedIndicator;

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

// 相邻的两个圆圈之间的距离
@property (nonatomic, assign) CGFloat interval;

// 指示的圆圈的大小
@property (nonatomic, assign) CGFloat indicatorSize;

// 当前指示的圆圈大小
@property (nonatomic, assign) CGFloat selectedIndicatorSize;

// 横线的高度，只有在需要用横线指示时才有效
@property (nonatomic, assign) CGFloat lineHeight;

// 请只在scrollView滑动时候再调用，否则可能出现初始化问题
- (DSSelectedIndicator *)selectedIndicator;

@end

NS_ASSUME_NONNULL_END
