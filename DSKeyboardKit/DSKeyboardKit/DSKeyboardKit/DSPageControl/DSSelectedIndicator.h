//
//  DSSelectedIndicator.h
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/29.
//  Copyright © 2018 HelloAda. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "DSIndicator.h"

NS_ASSUME_NONNULL_BEGIN

@interface DSSelectedIndicator : CALayer

// 指示的圆点的大小 默认为5
@property (nonatomic, assign) CGFloat indicatorSize;

// 选中的原点大小 默认为7
@property (nonatomic, assign) CGFloat selectedIndicatorSize;

// 选中的指示器颜色 默认RGB(142/255,142/255,142/255)
@property (nonatomic, strong) UIColor *selectedindicatorColor;

// 相邻的两个圆点之间的距离 默认为5
@property (nonatomic, assign) CGFloat interval;

// 指示器类型 少的时候是原点，多的时候自动转换为横线
@property (nonatomic, assign) DSIndicatorType indicatorType;

// 指示到对应下标
- (void)scrollToOffset:(CGFloat)offset;

// 跟随scrollView移动
- (void)moveWithScrollView:(UIScrollView *)scrollView;
@end

NS_ASSUME_NONNULL_END
