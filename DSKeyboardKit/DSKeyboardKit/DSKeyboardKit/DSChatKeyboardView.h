//
//  DSChatKeyboardView.h
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/8/31.
//  Copyright © 2018年 HelloAda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSInputToolView.h"
#import "DSChatKeyboardConfig.h"

@interface DSChatKeyboardView : UIView

// 配置信息
@property (nonatomic, strong) DSChatKeyboardConfig *config;

// 工具栏
@property (nonatomic, strong) DSInputToolView *toolView;

/**
 初始化
 
 @param frame 位置大小
 @param config 配置信息
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame config:(DSChatKeyboardConfig *)config;

@end
