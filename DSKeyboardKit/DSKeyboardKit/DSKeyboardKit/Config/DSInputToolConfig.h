//
//  DSInputToolConfig.h
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/23.
//  Copyright © 2018年 HelloAda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//按钮类型  -- 类似微信的键盘，在朋友圈只需要文本输入和表情按钮
typedef NS_ENUM(NSInteger, DSInputToolItemType){
    DSInputToolItemTypeVoice,         // 声音
    DSInputToolItemTypeText,          // 文本
    DSInputToolItemTypeEmoticon,      // 表情
    DSInputToolItemTypeMore,          // 更多
};


// 工具栏的配置
@interface DSInputToolConfig : NSObject

// 类方法初始化
+ (instancetype)config;

#pragma mark - 工具栏的配置

/**
 工具栏按钮 默认 声音 文本 表情 更多
 eg: @(DSInputToolViewItemTypeVoice): @[@"正常状态下名称",@"高亮状态下名称"]
 */
@property (nonatomic, strong) NSDictionary <NSNumber *, NSArray *> *toolItemsDic;

// 录音按钮title 默认 @"按住 说话"
@property (nonatomic, copy) NSString *recordTitle;

@end

NS_ASSUME_NONNULL_END
