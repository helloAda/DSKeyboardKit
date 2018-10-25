//
//  DSInputToolView.m
//  
//
//  Created by 黄铭达 on 2017/9/28.
//  Copyright © 2017年 黄铭达. All rights reserved.
//

#import "DSInputToolView.h"
#import "DSInputScrollTextView.h"
#import "UIView+DSCategory.h"

#define BtnPadding 6 //按钮间隔
#define TextViewPadding 3 //文本框间隔



@interface DSInputToolView ()<DSInputScrollTextViewDelegate>

// 存放对应按钮控件
@property (nonatomic,copy)  NSDictionary *itemViewDict;

// 配置的按钮类型集合
@property (nonatomic, copy)  NSArray<NSNumber *> *types;

// 输入框
@property (nonatomic, strong) DSInputScrollTextView *inputTextView;

// 当前选中的状态
@property (nonatomic, assign) DSInputToolStatus status;

//输入文字框的背景图片
@property (nonatomic, strong) UIImageView *inputTextBackImage;

//声音按钮
@property (nonatomic, strong) UIButton *voiceBtn;

//表情按钮
@property (nonatomic, strong) UIButton *emoticonBtn;

//更多按钮
@property (nonatomic, strong) UIButton *moreBtn;

//记录声音按钮
@property (nonatomic, strong) UIButton *recordBtn;

@end

@implementation DSInputToolView

- (instancetype)initWithFrame:(CGRect)frame config:(DSInputToolConfig *)config
{
    self = [super initWithFrame:frame];
    if (self) {
        _config = config;
        [self setup];
    }
    return self;
}

// 初始化
- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    // 按顺序排好
    self.types = [_config.toolItemsDic.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    // 声音按钮
    if ([self.types containsObject:@(DSInputToolItemTypeVoice)]) {
        NSArray *array = [NSArray arrayWithArray:[_config.toolItemsDic objectForKey:@(DSInputToolItemTypeVoice)]];
        if (array.count < 2) {return;} // 防止崩溃
        _voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_voiceBtn setImage:[UIImage imageNamed:array[0]] forState:UIControlStateNormal];
        [_voiceBtn setImage:[UIImage imageNamed:array[1]] forState:UIControlStateHighlighted];
        [_voiceBtn addTarget:self action:@selector(onTapVoiceBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_voiceBtn sizeToFit];
        
        _recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_recordBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [_recordBtn setBackgroundImage:[[UIImage imageNamed:@"input_text_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(10 ,10, 10, 10) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
        [_recordBtn setTitle:_config.recordTitle forState:UIControlStateNormal];
        [_recordBtn addTarget:self action:@selector(onTapRecordBtnDown:) forControlEvents:UIControlEventTouchDown];
        [_recordBtn addTarget:self action:@selector(onTapRecordBtnDragInside:) forControlEvents:UIControlEventTouchDragInside];
        [_recordBtn addTarget:self action:@selector(onTapRecordBtnDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
        [_recordBtn addTarget:self action:@selector(onTapRecordBtnUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_recordBtn addTarget:self action:@selector(onTapRecordBtnUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        _recordBtn.exclusiveTouch = YES;
        [_recordBtn sizeToFit];
    }

    // 表情按钮
    if ([self.types containsObject:@(DSInputToolItemTypeEmoticon)]) {
        NSArray *array = [NSArray arrayWithArray:[_config.toolItemsDic objectForKey:@(DSInputToolItemTypeEmoticon)]];
        if (array.count < 2) {return;} // 防止崩溃
        _emoticonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_emoticonBtn setImage:[UIImage imageNamed:array[0]] forState:UIControlStateNormal];
        [_emoticonBtn setImage:[UIImage imageNamed:array[1]] forState:UIControlStateHighlighted];
        [_emoticonBtn addTarget:self action:@selector(onTapEmoticonBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_emoticonBtn sizeToFit];
    }
    
    // 更多按钮
    if ([self.types containsObject:@(DSInputToolItemTypeMore)]) {
        NSArray *array = [NSArray arrayWithArray:[_config.toolItemsDic objectForKey:@(DSInputToolItemTypeMore)]];
        if (array.count < 2) {return;} // 防止崩溃
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:[UIImage imageNamed:array[0]] forState:UIControlStateNormal];
        [_moreBtn setImage:[UIImage imageNamed:array[1]] forState:UIControlStateHighlighted];
        [_moreBtn addTarget:self action:@selector(onTapMoreBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_moreBtn sizeToFit];
    }
    
    // 文本框背景图片
    _inputTextBackImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [_inputTextBackImage setImage:[[UIImage imageNamed:@"input_text_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch]];
    //文本输入框
    _inputTextView = [[DSInputScrollTextView alloc] initWithFrame:CGRectZero];
    _inputTextView.textColor = [UIColor blackColor];
    _inputTextView.backgroundColor = [UIColor clearColor];
    _inputTextView.size = [_inputTextView intrinsicContentSize];
    _inputTextView.textViewDelegate = self;
    _inputTextView.returnKeyType = UIReturnKeySend;
}


- (NSString *)contentText {
    return self.inputTextView.text;
}

- (void)setContentText:(NSString *)contentText {
    self.inputTextView.text = contentText;
}


// 计算整个工具栏高度
- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat viewHeight = 0.0f;
    // 如果是在录音状态 则高度默认为54.5
    if (self.status == DSInputToolStatusAudio) {
        viewHeight = 54.5;
    }
    // 其他状态则根据文本框的高度 来决定工具栏的高度
    else {
        // 计算 inputTextView宽度
        [self adjustTextViewWidth:size.width];
        // 计算完后 刷新布局 自适应高度
        [self.inputTextView layoutIfNeeded];
        viewHeight = self.inputTextView.height;
        //ToolView 高度
        viewHeight = viewHeight + 2 * (BtnPadding + TextViewPadding);
    }
    return CGSizeMake(size.width, viewHeight);
}

//计算inputTextView宽度
- (void)adjustTextViewWidth:(CGFloat)width {
    CGFloat textViewWidth = 0;
    for (NSNumber *type in self.types) {
        if (type.integerValue == DSInputToolItemTypeText) {
            continue;
        }
        //获取按钮 计算宽度
        UIView *view = [self subViewForType:type.integerValue];
        textViewWidth += view.width;
    }
    textViewWidth += (BtnPadding * (self.types.count + 1));
    self.inputTextView.width = width - textViewWidth - 2 * TextViewPadding;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ([self.types containsObject:@(DSInputToolItemTypeText)]) {
        self.inputTextBackImage.width = self.inputTextView.width + 2 * TextViewPadding;
        self.inputTextBackImage.height = self.inputTextView.height + 2 * TextViewPadding;
    }
    
    CGFloat left = 0;
    //排版
    for (NSNumber *type in self.types) {
        UIView *view = [self subViewForType:type.integerValue];
        if (!view.superview) {
            [self addSubview:view];
        }
        
        view.left = left + BtnPadding;
        view.centerY = self.height * .5f;
        left = view.right;
    }
    
    [self adjustTextAndRecordView];

}

// 计算inputTextView 和 recordBtn frame
- (void)adjustTextAndRecordView {
    
    if ([self.types containsObject:@(DSInputToolItemTypeText)]) {
        self.inputTextView.center = self.inputTextBackImage.center;
        
        if (!self.inputTextView.superview) {
            [self addSubview:self.inputTextView];
        }
        if (!self.recordBtn.superview) {
            self.recordBtn.frame = self.inputTextBackImage.frame;
            [self addSubview:self.recordBtn];
        }
    }
}

#pragma mark - 对外接口 -

- (BOOL)showsKeyboard {
    return [self.inputTextView isFirstResponder];
}

- (void)setShowsKeyboard:(BOOL)showsKeyboard {
    if (showsKeyboard) {
        [self.inputTextView becomeFirstResponder];
    }else {
        [self.inputTextView resignFirstResponder];
    }
}

- (void)update:(DSInputToolStatus)status {
    self.status = status;
    [self sizeToFit];
    //文本或更多 状态
    if (status == DSInputToolStatusText || status == DSInputToolStatusMore) {
        self.recordBtn.hidden = YES;
        self.inputTextView.hidden = NO;
        self.inputTextBackImage.hidden = NO;
        [self updateVoiceBtnImage:YES];
        [self updateEmojiBtnImage:YES];
    }
    //声音 状态
    else if (status == DSInputToolStatusAudio) {
        self.recordBtn.hidden = NO;
        self.inputTextView.hidden = YES;
        self.inputTextBackImage.hidden = YES;
        [self updateVoiceBtnImage:NO];
        [self updateEmojiBtnImage:YES];
    }
    //表情 状态
    else {
        self.recordBtn.hidden = YES;
        self.inputTextView.hidden = NO;
        self.inputTextBackImage.hidden = NO;
        [self updateVoiceBtnImage:YES];
        [self updateEmojiBtnImage:NO];
    }
}


//更新声音按钮图片
- (void)updateVoiceBtnImage:(BOOL)selected {
    NSArray *voiceImageArray = [NSArray arrayWithArray:[_config.toolItemsDic objectForKey:@(DSInputToolItemTypeVoice)]];
    NSArray *keyboardImageArray = [NSArray arrayWithArray:[_config.toolItemsDic objectForKey:@(DSInputToolItemTypeText)]];
    if (voiceImageArray.count < 2) {return;}
    if (keyboardImageArray.count < 2) {return;}
    [self.voiceBtn setImage:selected ? [UIImage imageNamed:voiceImageArray[0]] : [UIImage imageNamed:keyboardImageArray[0]] forState:UIControlStateNormal];
        [self.voiceBtn setImage:selected ? [UIImage imageNamed:voiceImageArray[1]] : [UIImage imageNamed:keyboardImageArray[1]] forState:UIControlStateHighlighted];
}

//更新表情按钮图片
- (void)updateEmojiBtnImage:(BOOL)selected {
    NSArray *emoticonImageArray = [NSArray arrayWithArray:[_config.toolItemsDic objectForKey:@(DSInputToolItemTypeEmoticon)]];
    NSArray *keyboardImageArray = [NSArray arrayWithArray:[_config.toolItemsDic objectForKey:@(DSInputToolItemTypeText)]];
    if (emoticonImageArray.count < 2) {return;}
    if (keyboardImageArray.count < 2) {return;}
    [self.emoticonBtn setImage:selected ? [UIImage imageNamed:emoticonImageArray[0]] : [UIImage imageNamed:keyboardImageArray[0]] forState:UIControlStateNormal];
    [self.emoticonBtn setImage:selected ? [UIImage imageNamed:emoticonImageArray[1]] : [UIImage imageNamed:keyboardImageArray[1]] forState:UIControlStateHighlighted];
}


- (NSRange)selectedRange {
    return self.inputTextView.selectedRange;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    self.inputTextView.placeholderAttributedText = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
}

- (void)insertText:(NSString *)text {
    NSRange range = self.inputTextView.selectedRange;
    NSString *replaceText = [self.inputTextView.text stringByReplacingCharactersInRange:range withString:text];
    range = NSMakeRange(range.location + text.length, 0);
    self.inputTextView.text = replaceText;
    self.inputTextView.selectedRange = range;
}

- (void)deleteText:(NSRange)range {
    NSString *text = self.contentText;
    if (range.location + range.length <= text.length && range.location != NSNotFound && range.length != 0) {
        NSString *newText = [text stringByReplacingCharactersInRange:range withString:@""];
        NSRange newRange = NSMakeRange(range.location, 0);
        self.inputTextView.text = newText;
        self.inputTextView.selectedRange = newRange;
    }
}

#pragma mark - DSInputToolViewDelegate -

- (BOOL)shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)replacementText {
    BOOL should = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(shouldChangeTextInRange:replacementText:)]) {
        should = [self.delegate shouldChangeTextInRange:range replacementText:replacementText];
    }
    return should;
}

- (BOOL)textViewShouldBeginEditing:(DSInputScrollTextView *)scrollTextView {
    BOOL should = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        should = [self.delegate textViewShouldBeginEditing];
    }
    return should;
}

- (void)textViewDidEndEditing:(DSInputScrollTextView *)scrollTextView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewDidEndEditing)]) {
        [self.delegate textViewDidEndEditing];
    }
}

- (void)textViewDidChange:(DSInputScrollTextView *)scrollTextView {
    if ([self.delegate respondsToSelector:@selector(textViewDidChange)]) {
        [self.delegate textViewDidChange];
    }
}

- (void)willChangeHeight:(CGFloat)height {
    CGFloat toolViewHeight = height + 2 * BtnPadding;
    if (self.delegate && [self.delegate respondsToSelector:@selector(toolViewWillChangeHeight:)]) {
        [self.delegate toolViewWillChangeHeight:toolViewHeight];
    }
}

- (void)didChangeHeight:(CGFloat)height {
    self.height = height + 2 * (BtnPadding + TextViewPadding);
    if (self.delegate && [self.delegate respondsToSelector:@selector(toolViewDidChangeHeight:)]) {
        [self.delegate toolViewDidChangeHeight:self.height];
    }
}

#pragma mark - 按钮事件 -

// 声音按钮
- (void)onTapVoiceBtn:(UIButton *)btn {
    if (self.itemDelegate && [self.itemDelegate respondsToSelector:@selector(onTapVoiceBtn:)]) {
        [self.itemDelegate onTapVoiceBtn:btn];
    }
}
// 表情按钮
- (void)onTapEmoticonBtn:(UIButton *)btn {
    if (self.itemDelegate && [self.itemDelegate respondsToSelector:@selector(onTapEmoticonBtn:)]) {
        [self.itemDelegate onTapEmoticonBtn:btn];
    }
}
// 更多按钮
- (void)onTapMoreBtn:(UIButton *)btn {
    if (self.itemDelegate && [self.itemDelegate respondsToSelector:@selector(onTapMoreBtn:)]) {
        [self.itemDelegate onTapMoreBtn:btn];
    }
}
// 按下录音按钮，开始录音
- (void)onTapRecordBtnDown:(UIButton *)btn {
    if (self.itemDelegate && [self.itemDelegate respondsToSelector:@selector(onTapRecordBtnDown:)]) {
        [self.itemDelegate onTapRecordBtnDown:btn];
    }
}
// 在按钮内手指离开，录音完成
- (void)onTapRecordBtnUpInside:(UIButton *)btn {
    if (self.itemDelegate && [self.itemDelegate respondsToSelector:@selector(onTapRecordBtnUpInside:)]) {
        [self.itemDelegate onTapRecordBtnUpInside:btn];
    }
}
// 在按钮外手指离开，录音取消
- (void)onTapRecordBtnUpOutside:(UIButton *)btn {
    if (self.itemDelegate && [self.itemDelegate respondsToSelector:@selector(onTapRecordBtnUpOutside:)]) {
        [self.itemDelegate onTapRecordBtnUpOutside:btn];
    }
}
// 在按钮内手指还没离开， 提示 "手指上滑，取消发送"
- (void)onTapRecordBtnDragInside:(UIButton *)btn {
    if (self.itemDelegate && [self.itemDelegate respondsToSelector:@selector(onTapRecordBtnDragInside:)]) {
        [self.itemDelegate onTapRecordBtnDragInside:btn];
    }
}
// 在按钮外手指还没离开，提示 "松开手指，取消发送"
- (void)onTapRecordBtnDragOutside:(UIButton *)btn {
    if (self.itemDelegate && [self.itemDelegate respondsToSelector:@selector(onTapRecordBtnDragOutside:)]) {
        [self.itemDelegate onTapRecordBtnDragOutside:btn];
    }
}


#pragma mark - get -
- (UIView *)subViewForType:(DSInputToolItemType)type {
    if (!_itemViewDict) {
        _itemViewDict = @{
                  @(DSInputToolItemTypeVoice) : self.voiceBtn,
                  @(DSInputToolItemTypeText)  : self.inputTextBackImage,
                  @(DSInputToolItemTypeEmoticon) : self.emoticonBtn,
                  @(DSInputToolItemTypeMore)  : self.moreBtn
                  };
    }
    return _itemViewDict[@(type)];
}

@end






