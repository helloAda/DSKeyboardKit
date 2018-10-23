//
//  DSChatKeyboardConfig.m
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/8/31.
//  Copyright © 2018年 HelloAda. All rights reserved.
//

#import "DSChatKeyboardConfig.h"

@implementation DSChatKeyboardConfig

+ (instancetype)config {
    DSChatKeyboardConfig *config = [[DSChatKeyboardConfig alloc] init];
    return config;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupConfig];
    }
    return self;
}

// 初始化所有配置信息
- (void)setupConfig {
    _inputToolConfig = [DSInputToolConfig config];
}
@end
