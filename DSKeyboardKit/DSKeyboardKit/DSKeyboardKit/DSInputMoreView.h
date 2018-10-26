//
//  DSInputMoreView.h
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/25.
//  Copyright © 2018 HelloAda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSInputMoreConfig.h"
NS_ASSUME_NONNULL_BEGIN

@protocol DSInputMoreViewDelegate <NSObject>

- (BOOL)didTapMediaItem:(DSMediaItem *)item;

@end

@interface DSInputMoreView : UIView

// 代理
@property (nonatomic, weak) id<DSInputMoreViewDelegate> delegate;

/**
 初始化

 @param frame 布局
 @param config 配置信息
 @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame config:(DSInputMoreConfig *)config;

@end

NS_ASSUME_NONNULL_END
