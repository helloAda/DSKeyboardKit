//
//  DSSelectedIndicator.h
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/29.
//  Copyright © 2018 HelloAda. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSSelectedIndicator : CALayer

// 选中的指示器大小
@property (nonatomic, assign) CGFloat indicatorSize;

// 选中的指示器颜色
@property (nonatomic, strong) UIColor *selectedindicatorColor;

// 相邻的两个圆圈之间的距离
@property (nonatomic, assign) CGFloat interval;

// 指示到对应下标
- (void)scrollToOffset:(CGFloat)offset;

@end

NS_ASSUME_NONNULL_END
