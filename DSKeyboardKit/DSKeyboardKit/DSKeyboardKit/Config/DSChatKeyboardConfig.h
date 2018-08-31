//
//  DSChatKeyboardConfig.h
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/8/31.
//  Copyright © 2018年 HelloAda. All rights reserved.
//

#import <Foundation/Foundation.h>

//按钮类型  -- 类似微信的键盘，在朋友圈只需要文本输入和表情按钮
typedef NS_ENUM(NSInteger, DSInputToolViewItemType){
    DSInputToolViewItemTypeVoice,         //声音
    DSInputToolViewItemTypeEmoticon,      //表情
    DSInputToolViewItemTypeMore,          //更多
};

// 聊天键盘的配置
@interface DSChatKeyboardConfig : NSObject

// 类方法初始化
+ (instancetype)config;

#pragma mark - 工具栏的配置

/**
 工具栏按钮 默认 声音 表情 更多
 eg: @(DSInputToolViewItemTypeVoice): @[@"正常状态下名称",@"高亮状态下名称"]
 */
@property (nonatomic, copy) NSDictionary <NSNumber *, NSArray *> *toolItemsDic;

@end
