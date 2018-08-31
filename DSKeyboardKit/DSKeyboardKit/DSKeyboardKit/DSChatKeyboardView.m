//
//  DSChatKeyboardView.m
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/8/31.
//  Copyright © 2018年 HelloAda. All rights reserved.
//

#import "DSChatKeyboardView.h"

@implementation DSChatKeyboardView

- (instancetype)initWithFrame:(CGRect)frame config:(DSChatKeyboardConfig *)config {
    self = [super initWithFrame:frame];
    if (self) {
        _config = config;
    }
    return self;
}
@end
