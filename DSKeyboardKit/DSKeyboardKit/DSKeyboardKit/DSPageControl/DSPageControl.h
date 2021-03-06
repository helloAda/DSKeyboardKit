//
//  DSPageControl.h
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/29.
//  Copyright © 2018 HelloAda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSSelectedIndicator.h"

NS_ASSUME_NONNULL_BEGIN


@interface DSPageControl : UIView

// 总共多少页
@property (nonatomic, assign) NSInteger pageCount;

// 当前选中页 从1开始 默认为1
@property (nonatomic, assign) NSInteger selectedPage;

// 没选中的颜色 默认RGB(216/255,216/255,216/255)
@property (nonatomic, strong) UIColor *unSelectedCorlor;

// 选中的颜色 默认RGB(142/255,142/255,142/255)
@property (nonatomic, strong) UIColor *selectedColor;

// 相邻的两个圆点之间的距离 只有圆点指示时才有效 默认为5
@property (nonatomic, assign) CGFloat interval;

// 指示的圆点的大小 默认为5
@property (nonatomic, assign) CGFloat indicatorSize;

// 当前选中的圆点大小 默认为7
@property (nonatomic, assign) CGFloat selectedIndicatorSize;

// 横线的高度，只有在需要用横线指示时才有效 默认为2
@property (nonatomic, assign) CGFloat lineHeight;

// 绑定的滚动视图
@property (nonatomic, strong) UIScrollView *bindScrollView;

// 请只在scrollView滑动时候再调用，否则可能出现初始化问题
- (DSSelectedIndicator *)selectedIndicator;

@end

NS_ASSUME_NONNULL_END
