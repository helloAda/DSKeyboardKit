//
//  DSIndicator.m
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/29.
//  Copyright © 2018 HelloAda. All rights reserved.
//

#import "DSIndicator.h"

@implementation DSIndicator


- (void)drawInContext:(CGContextRef)ctx {
    NSAssert(self.selectedPage <= self.pageCount,
             @"当前选中的页数不能比总页数多");
    NSAssert(self.pageCount > 0 && self.selectedPage > 0, @"总页数不能小于等于0");
    
    CGMutablePathRef linePath = CGPathCreateMutable();
    
    // 使用直线显示
    if (self.indicatorType == DSIndicatorTypeLine) {
        CGPathAddRoundedRect(
                             linePath, nil,
                             CGRectMake(0,
                                        self.frame.size.height / 2 - self.lineHeight / 2,
                                        self.frame.size.width, self.lineHeight),
                             0, 0);
    }
    // 使用圆点指示
    else if (self.indicatorType == DSIndicatorTypeCircle){
        for (NSInteger i = 0; i < self.pageCount; i++) {
            CGRect circleRect = CGRectMake(self.diffWidth + i * (self.interval + self.indicatorSize), self.frame.size.height / 2 - self.indicatorSize / 2,
                                           self.indicatorSize, self.indicatorSize);
            CGPathAddEllipseInRect(linePath, nil, circleRect);
        }
    }
    
    CGContextAddPath(ctx, linePath);
    CGContextSetFillColorWithColor(ctx, self.unSelectedColor.CGColor);
    CGContextFillPath(ctx);
}
@end
