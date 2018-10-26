//
//  DSInputMoreConfig.h
//  DSKeyboardKit
//
//  Created by HelloAda on 2018/10/26.
//  Copyright © 2018 HelloAda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSMediaItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface DSInputMoreConfig : NSObject

// 点击更多按钮后 显示的Button
@property (nonatomic, strong) NSArray <DSMediaItem *>* mediaItems;

@end

NS_ASSUME_NONNULL_END
