//
//  DSChatKeyboardView.m
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/8/31.
//  Copyright © 2018年 HelloAda. All rights reserved.
//

#import "DSChatKeyboardView.h"
#import "UIView+DSCategory.h"

@interface DSChatKeyboardView () <DSInputToolItemDelegate, DSInputToolViewDelegate>
// 配置信息
@property (nonatomic, strong) DSChatKeyboardConfig *config;
//工具栏的状态
@property (nonatomic, assign) DSInputToolStatus toolStatus;
//默认高度  216
@property (nonatomic, assign) CGFloat defaultcontainerHeight;
//键盘的top值 显示键盘时才有意义
@property (nonatomic, assign) CGFloat keyBoardFrameTop;

@end

@implementation DSChatKeyboardView

- (instancetype)initWithFrame:(CGRect)frame config:(DSChatKeyboardConfig *)config {
    self = [super initWithFrame:frame];
    if (self) {
        _config = config;
        _defaultcontainerHeight = 216;
    }
    return self;
}

//这个方法会在layoutSubviews之前调用
- (void)didMoveToWindow {
    [self setup];
}

- (void)setup {
    if (!_toolView) {
        _toolView = [[DSInputToolView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0) config:_config.inputToolConfig];
        [self addSubview:_toolView];
        [_toolView setPlaceHolder:@"输入消息"];
        _toolView.delegate = self;
        _toolView.itemDelegate = self;
        _toolView.size = [_toolView sizeThatFits:CGSizeMake(self.width, CGFLOAT_MAX)];
        _toolView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self refreshStatus:DSInputToolStatusText];
        [self sizeToFit];
    }
}


//刷新当前键盘状态
- (void)refreshStatus:(DSInputToolStatus)status {
    self.toolStatus = status;
    [self.toolView update:status];
    switch (status) {
        case DSInputToolStatusText:
        case DSInputToolStatusAudio: {
            //键盘显示时
            if (self.toolView.showsKeyboard) {
                self.top = self.keyBoardFrameTop - self.toolView.height;
            }
            //不显示键盘时
            else {
                self.top = self.superview.height - self.toolView.height;
            }
        }
            break;
        case DSInputToolStatusEmoticon:
        case DSInputToolStatusMore: {
            self.bottom = self.superview.height;
            break;
        }
        default:
            
            break;
    }
}

@end
