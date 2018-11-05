//
//  DSSelectedIndicator.m
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/29.
//  Copyright © 2018 HelloAda. All rights reserved.
//

#import "DSSelectedIndicator.h"

@interface DSSelectedIndicator ()

{
    CGFloat _offset;
}
@end

@implementation DSSelectedIndicator

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)scrollToOffset:(CGFloat)offset {
    _offset = offset;
    [self setNeedsDisplay];
}

- (void)moveWithScrollView:(UIScrollView *)scrollView {
    // 当前第几页
    NSInteger index = scrollView.contentOffset.x / scrollView.contentSize.width;
    // 当前页的偏移量
    CGFloat currentOffsetX = scrollView.contentOffset.x - index * scrollView.contentSize.width;
    // 当前页偏移量 换算成 指示器的偏移量
    CGFloat offsetX;
    
    // 是圆点的时候
    if (self.indicatorType == DSIndicatorTypeCircle) {
        offsetX = currentOffsetX / scrollView.contentSize.width * (self.indicatorSize + self.interval);
        [self scrollToOffset:offsetX];
    }
}

- (void)drawInContext:(CGContextRef)ctx {
    // 画一个圆
    CGMutablePathRef linePath = CGPathCreateMutable();

    CGRect circleRect = CGRectMake(_offset, self.frame.size.height / 2 - self.selectedIndicatorSize / 2,
                                   self.selectedIndicatorSize, self.selectedIndicatorSize);
    CGPathAddEllipseInRect(linePath, nil, circleRect);
    
    CGContextAddPath(ctx, linePath);
    CGContextSetFillColorWithColor(ctx, self.selectedindicatorColor.CGColor);
    CGContextFillPath(ctx);
}

@end
