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

// 工具栏
@property (nonatomic, strong) DSInputToolView *toolView;
// 是否正在录音
@property (assign, nonatomic)    BOOL recording;

/**
 初始化
 
 @param frame 布局
 @param config 配置信息
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame config:(DSChatKeyboardConfig *)config;

// 刷新当前键盘状态
- (void)refreshStatus:(DSInputToolStatus)status;


@end
