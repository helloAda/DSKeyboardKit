//
//  DSPageControl.m
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/29.
//  Copyright © 2018 HelloAda. All rights reserved.
//

#import "DSPageControl.h"
#import "DSIndicator.h"
#import "DSSelectedIndicator.h"
#import "UIView+DSCategory.h"

@interface DSPageControl ()

@property (nonatomic, strong) DSIndicator *indicator;
@property (nonatomic, strong) DSSelectedIndicator *selectedIndicator;

// 上一次滑动到的下标
@property (nonatomic, assign) NSInteger lastIndex;
// 保存指示layer的rect
@property (nonatomic, assign) CGRect layerRect;
@end

@implementation DSPageControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
        CGFloat width = self.pageCount * (self.indicatorSize + self.interval) - self.interval;
        // 没有太多页的情况下都使用圆点
        if (width < self.width * 0.7) {
            _indicator.indicatorType = DSIndicatorTypeCircle;
            _indicator.frame = CGRectMake((self.width - width) / 2, 0, width, self.height);
            _layerRect = _indicator.frame;
        } else {
            _indicator.indicatorType = DSIndicatorTypeLine;
            _indicator.frame = CGRectMake(self.width * 0.15, self.height / 2 - 1, width, self.height);
            _layerRect = _indicator.frame;
        }
        
        _indicator.pageCount = self.pageCount;
        _indicator.unSelectedColor = self.unSelectedCorlor;
        _indicator.bindScrollView = self.bindScrollView;
        _indicator.interval = self.interval;
        _indicator.indicatorSize = self.indicatorSize;
        _indicator.contentsScale = [UIScreen mainScreen].scale;
    }
    return _indicator;
}

- (DSSelectedIndicator *)selectedIndicator {
    if (!_selectedIndicator) {
        _selectedIndicator = [DSSelectedIndicator layer];
        _selectedIndicator.frame = _layerRect;
        _selectedIndicator.interval = self.interval;
        _selectedIndicator.indicatorSize = self.indicatorSize;
        _selectedIndicator.selectedindicatorColor = self.selectedColor;
        _selectedIndicator.contentsScale = [UIScreen mainScreen].scale;
    }
    return _selectedIndicator;
}


#pragma mark - 单击 -
- (void)tapAction:(UITapGestureRecognizer *)tap {
//    if (!self.bindScrollView) {return;}
    
    CGPoint location = [tap locationInView:self];
    if (CGRectContainsPoint(self.indicator.frame, location)) {
        // 点击位置的偏移量
        CGFloat offsetX = location.x - self.indicator.frame.origin.x;
        NSInteger index;
        // 第一个所占的宽度
        CGFloat firstWidth = self.indicatorSize + self.interval / 2;
        // 特殊判断 第一个的时候单独处理
        if (offsetX <= firstWidth) {
            index = 0;
        } else {
            index = (offsetX - firstWidth) / (self.indicatorSize + self.interval) + 1;
        }
        
        // 指示器显示到正确位置
        [self.selectedIndicator scrollToOffset:index * (self.interval + self.indicatorSize)];
        // 界面偏移设置
        [self.bindScrollView setContentOffset:CGPointMake(self.bindScrollView.frame.size.width * index, 0) animated:YES];

    }
}

#pragma mark - 滑动 -
- (void)panAction:(UIPanGestureRecognizer *)pan {

    CGPoint location = [pan locationInView:self];
    if (CGRectContainsPoint(self.indicator.frame, location)) {
        // 滑动位置的偏移量
        CGFloat offsetX = location.x - self.indicator.frame.origin.x;
        NSInteger index;
        // 第一个所占的宽度
        CGFloat firstWidth = self.indicatorSize + self.interval / 2;
        // 特殊判断 第一个的时候单独处理
        if (offsetX <= firstWidth) {
            index = 0;
        } else {
            index = (offsetX - firstWidth) / (self.indicatorSize + self.interval) + 1;
        }
        
        // 滑动到最后一个的按钮的时候，指示器的偏移量不能超过lastOffsetX
        CGFloat lastOffsetX = self.indicator.frame.size.width - self.indicatorSize;
        if (offsetX >= lastOffsetX) {
            offsetX = lastOffsetX;
        }
        
        // 滑动结束 要滑动到正确的位置
        if (pan.state == UIGestureRecognizerStateEnded) {
            [self.selectedIndicator scrollToOffset:index * (self.interval + self.indicatorSize)];

        } else {
            // 指示器显示到当前偏移位置
            [self.selectedIndicator scrollToOffset:offsetX];
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
