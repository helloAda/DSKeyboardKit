//
//  DSInputToolConfig.m
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/23.
//  Copyright © 2018年 HelloAda. All rights reserved.
//

#import "DSInputToolConfig.h"

@implementation DSInputToolConfig
+ (instancetype)config {
    DSInputToolConfig *config = [[DSInputToolConfig alloc] init];
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
// 初始化配置信息
- (void)setupConfig {
    _toolItemsDic = @{
                      @(DSInputToolItemTypeVoice): @[@"input_voice_normal", @"input_voice_highlight"],
                      @(DSInputToolItemTypeText): @[],
                      @(DSInputToolItemTypeEmoticon): @[@"input_emoji_normal", @"input_emoji_highlight"],
                      @(DSInputToolItemTypeMore): @[@"input_more_normal", @"input_more_highlight"]
                      };
    _recordTitle = @"按住 说话";
}


@end
