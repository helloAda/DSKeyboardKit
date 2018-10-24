//
//  DSInputToolView.h
//  
//
//  Created by 黄铭达 on 2017/9/28.
//  Copyright © 2017年 黄铭达. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSInputToolConfig.h"

// 选中状态
typedef NS_ENUM(NSInteger, DSInputToolStatus) {
    DSInputToolStatusAudio,        // - 声音
    DSInputToolStatusText,         // - 文字
    DSInputToolStatusEmoticon,     // - 表情
    DSInputToolStatusMore          // - 更多
};

@protocol DSInputToolItemDelegate <NSObject>

@optional
// 声音按钮点击事件
- (void)onTapVoiceBtn:(UIButton *)btn;
// 表情按钮
- (void)onTapEmoticonBtn:(UIButton *)btn;
// 更多按钮
- (void)onTapMoreBtn:(UIButton *)btn;
// 按下录音按钮，开始录音
- (void)onTapRecordBtnDown:(UIButton *)btn;
// 在按钮内手指离开，录音完成
- (void)onTapRecordBtnUpInside:(UIButton *)btn;
// 在按钮外手指离开，录音取消
- (void)onTapRecordBtnUpOutside:(UIButton *)btn;
// 在按钮内手指还没离开， 提示 "手指上滑，取消发送"
- (void)onTapRecordBtnDragInside:(UIButton *)btn;
// 在按钮外手指还没离开，提示 "松开手指，取消发送"
- (void)onTapRecordBtnDragOutside:(UIButton *)btn;

@end


@protocol DSInputToolViewDelegate <NSObject>

@optional
// 将要被编辑
- (BOOL)textViewShouldBeginEditing;

// 已经结束编辑
- (void)textViewDidEndEditing;

// 文本将要发生改变
- (BOOL)shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)replacementText;

// 文本已经发生改变
- (void)textViewDidChange;

// toolView将要改变高度
- (void)toolViewWillChangeHeight:(CGFloat)height;

// toolView已经改变高度
- (void)toolViewDidChangeHeight:(CGFloat)height;

@end

@interface DSInputToolView : UIView

// 配置信息
@property (nonatomic, strong) DSInputToolConfig *config;

// 输入的文字
@property (nonatomic, copy) NSString *contentText;

// 是否显示键盘
@property (nonatomic, assign) BOOL showsKeyboard;

// 代理
@property (nonatomic, weak) id<DSInputToolViewDelegate> delegate;

// 按钮点击事件代理
@property (nonatomic, weak) id<DSInputToolItemDelegate> itemDelegate;

#pragma mark -- 方法 --

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame config:(DSInputToolConfig *)config;

// 更新状态
- (void)update:(DSInputToolStatus)status;

// 选中范围
- (NSRange)selectedRange;

// 设置占位文本
- (void)setPlaceHolder:(NSString *)placeHolder;

// 插入文本
- (void)insertText:(NSString *)text;

// 删除文本
- (void)deleteText:(NSRange)range;

@end



