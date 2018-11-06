//
//  DSIndicator.h
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/29.
//  Copyright © 2018 HelloAda. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DSIndicatorType) {
    DSIndicatorTypeCircle,       // 圆形指示
    DSIndicatorTypeLine        // 直线指示
};

NS_ASSUME_NONNULL_BEGIN

@interface DSIndicator : CALayer

// 总共多少页
@property (nonatomic, assign) NSInteger pageCount;

// 当前选中页 从1开始 默认1
@property (nonatomic, assign) NSInteger selectedPage;

// 指示器类型 少的时候是原点，多的时候自动转换为横线
@property (nonatomic, assign) DSIndicatorType indicatorType;

// 没选中的颜色 默认RGB(216/255,216/255,216/255)
@property (nonatomic, strong) UIColor *unSelectedColor;

// 指示的圆点的大小 默认为5
@property (nonatomic, assign) CGFloat indicatorSize;

// 相邻的两个圆点之间的距离 默认为5
@property (nonatomic, assign) CGFloat interval;

// 直线表示时，直线的高度 默认为2
@property (nonatomic, assign) CGFloat lineHeight;

// 选中指示 和未选中指示 宽度差值的一半 默认是1
@property (nonatomic, assign) CGFloat diffWidth;

@end

NS_ASSUME_NONNULL_END
