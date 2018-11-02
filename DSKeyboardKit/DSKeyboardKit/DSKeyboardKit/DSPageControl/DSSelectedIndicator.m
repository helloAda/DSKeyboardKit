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

- (void)drawInContext:(CGContextRef)ctx {
    // 画一个圆
    CGMutablePathRef linePath = CGPathCreateMutable();

    CGRect circleRect = CGRectMake(_offset, self.frame.size.height / 2 - self.indicatorSize / 2,
                                   self.indicatorSize, self.indicatorSize);
    CGPathAddEllipseInRect(linePath, nil, circleRect);
    
    CGContextAddPath(ctx, linePath);
    CGContextSetFillColorWithColor(ctx, self.selectedindicatorColor.CGColor);
    CGContextFillPath(ctx);
}

@end
