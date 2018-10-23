//
//  DSChatKeyboardConfig.h
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/8/31.
//  Copyright © 2018年 HelloAda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSInputToolConfig.h"


// 聊天键盘的配置
@interface DSChatKeyboardConfig : NSObject

// 工具栏配置
@property (nonatomic, strong) DSInputToolConfig *inputToolConfig;




// 类方法初始化
+ (instancetype)config;

@end
