//
//  DSPageControl.m
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/29.
//  Copyright © 2018 HelloAda. All rights reserved.
//

#import "DSPageControl.h"
#import "DSSelectedIndicator.h"
#import "UIView+DSCategory.h"

@interface DSPageControl ()

@property (nonatomic, strong) DSIndicator *indicator;
@property (nonatomic, strong) DSSelectedIndicator *selectedIndicator;

// 上一次滑动到的下标
@property (nonatomic, assign) NSInteger lastIndex;
// 保存指示layer的rect
@property (nonatomic, assign) CGRect layerRect;
// 选中指示 和 未选中指示的宽度差值的一半
@property (nonatomic, assign) CGFloat diffWidth;
@end

@implementation DSPageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _selectedPage = 1;
        _unSelectedCorlor = [UIColor colorWithRed:216.0 / 255.0 green:216.0 / 255.0 blue:216.0 / 255.0 alpha:1];
        _selectedColor = [UIColor colorWithRed:142.0 / 255.0 green:142.0 / 255.0 blue:142.0 / 255.0 alpha:1];
        _indicatorSize = 5;
        _selectedIndicatorSize = 7;
        _interval = 5;
        _lineHeight = 2;
        // 添加单击和拖动手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self addGestureRecognizer:pan];
        self.layer.masksToBounds = NO;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self.layer addSublayer:self.indicator];
    [self.layer insertSublayer:self.selectedIndicator above:self.indicator];
    
    [self.indicator setNeedsDisplay];
    [self.selectedIndicator setNeedsDisplay];
}



- (DSIndicator *)indicator {
    if (!_indicator) {
        _indicator = [DSIndicator layer];
        self.diffWidth = (self.selectedIndicatorSize - self.indicatorSize) / 2;
        // 指示器的总宽度
        CGFloat width = self.pageCount * (self.indicatorSize + self.interval) - self.interval + self.diffWidth * 2;
        // 页数较少用圆点
        if (width < self.width * 0.7) {
            _indicator.indicatorType = DSIndicatorTypeCircle;
            _indicator.frame = CGRectMake((self.width - width) / 2, 0, width, self.height);
            _layerRect = _indicator.frame;
            _indicator.interval = self.interval;
            _indicator.diffWidth = self.diffWidth;
            _indicator.indicatorSize = self.indicatorSize;

        }
        // 页数多的时候使用直线
        else {
            _indicator.indicatorType = DSIndicatorTypeLine;
            width = self.width * 0.7;
            self.interval = (width - self.selectedIndicatorSize) / self.pageCount;
            _indicator.frame = CGRectMake((self.width - width) / 2, 0, width, self.height);
            _indicator.lineHeight = self.lineHeight;
            _layerRect = _indicator.frame;
            _indicator.interval = self.interval;
        }
        
        _indicator.selectedPage = self.selectedPage;
        _indicator.pageCount = self.pageCount;
        _indicator.unSelectedColor = self.unSelectedCorlor;
        _indicator.contentsScale = [UIScreen mainScreen].scale;
        _indicator.backgroundColor = [UIColor orangeColor].CGColor;

    }
    return _indicator;
}

- (DSSelectedIndicator *)selectedIndicator {
    if (!_selectedIndicator) {
        _selectedIndicator = [DSSelectedIndicator layer];
        _selectedIndicator.frame = _layerRect;
        _selectedIndicator.interval = self.interval;
        _selectedIndicator.indicatorType = _indicator.indicatorType;
        _selectedIndicator.indicatorSize = self.indicatorSize;
        _selectedIndicator.selectedIndicatorSize = self.selectedIndicatorSize;
        _selectedIndicator.selectedindicatorColor = self.selectedColor;
        _selectedIndicator.contentsScale = [UIScreen mainScreen].scale;
    }
    return _selectedIndicator;
}

#pragma mark - 单击 -
- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (!self.bindScrollView) {return;}
    
    CGPoint location = [tap locationInView:self];
    if (CGRectContainsPoint(self.indicator.frame, location)) {
        // 点击位置的偏移量
        CGFloat offsetX = location.x - self.indicator.frame.origin.x;
        // 第几个
        NSInteger index = 0;
        // 第一个所占的宽度
        CGFloat firstWidth;
        
        // 圆点写在前面一般都是圆点 就不用判断后面那个条件啦
        if (self.indicator.indicatorType == DSIndicatorTypeCircle) {
            firstWidth = self.indicatorSize + self.interval / 2 + self.diffWidth;
            // 特殊判断 第一个的时候单独处理
            if (offsetX <= firstWidth) {
                index = 0;
            } else {
                index = (offsetX - firstWidth) / (self.indicatorSize + self.interval) + 1;
            }
            
            // 指示器显示到正确位置
            [self.selectedIndicator scrollToOffset:index * (self.interval + self.indicatorSize)];
        } else if (self.indicator.indicatorType == DSIndicatorTypeLine) {
            firstWidth = (self.selectedIndicatorSize + self.interval) / 2;
            // 特殊判断 第一个的时候单独处理
            if (offsetX <= firstWidth) {
                index = 0;
            } else {
                index = (offsetX - firstWidth) / self.interval + 1;
            }
            // 指示器显示到正确位置
            [self.selectedIndicator scrollToOffset:index * self.interval];
        }
        // 界面偏移设置
        [self.bindScrollView setContentOffset:CGPointMake(self.bindScrollView.frame.size.width * index, 0) animated:YES];
    }
}

#pragma mark - 滑动 -
- (void)panAction:(UIPanGestureRecognizer *)pan {
    if (!self.bindScrollView) {return;}

    CGPoint location = [pan locationInView:self];
    if (CGRectContainsPoint(self.indicator.frame, location)) {
        // 滑动位置的偏移量
        CGFloat offsetX = location.x - self.indicator.frame.origin.x;
        NSInteger index = 0;
        // 第一个所占的宽度
        CGFloat firstWidth;
        
        if (self.indicator.indicatorType == DSIndicatorTypeCircle) {
            firstWidth = self.indicatorSize + self.interval / 2 + self.diffWidth;
            // 特殊判断 第一个的时候单独处理
            if (offsetX <= firstWidth) {
                index = 0;
            } else {
                index = (offsetX - firstWidth) / (self.indicatorSize + self.interval) + 1;
            }

        } else if (self.indicator.indicatorType == DSIndicatorTypeLine) {
            firstWidth = (self.selectedIndicatorSize + self.interval) / 2;
            if (offsetX <= firstWidth) {
                index = 0;
            } else {
                index = (offsetX - firstWidth) / self.interval + 1;
            }
        }
        
        
        // 滑动到最后一个的按钮的时候，指示器的偏移量不能超过lastOffsetX
        CGFloat lastOffsetX = self.indicator.frame.size.width - self.selectedIndicatorSize / 2;
        if (offsetX >= lastOffsetX) {
            offsetX = lastOffsetX;
        }
        // 滑动到第一个圆圈的时候不能小于他本身的一半
        if (offsetX <= self.selectedIndicatorSize / 2) {
            offsetX = self.selectedIndicatorSize / 2;
        }
        
        // 滑动结束 要滑动到正确的位置
        if (pan.state == UIGestureRecognizerStateEnded) {
            
            if (self.indicator.indicatorType == DSIndicatorTypeCircle) {
                [self.selectedIndicator scrollToOffset:index * (self.interval + self.indicatorSize)];
            } else if (self.indicator.indicatorType == DSIndicatorTypeLine) {
                [self.selectedIndicator scrollToOffset:index * self.interval];
            }
        } else {
            // 指示器显示到当前偏移位置 （注意：滑动的时候指示器应该是中间和当前偏移量一样）
            [self.selectedIndicator scrollToOffset:offsetX - self.selectedIndicatorSize / 2];
            // 这里防止重复设置ScrollView的偏移量
            if (index != _lastIndex) {
                // 界面偏移设置
                [self.bindScrollView setContentOffset:CGPointMake(self.bindScrollView.frame.size.width * index, 0) animated:YES];
                _lastIndex = index;
            }

        }
    }
}
@end
