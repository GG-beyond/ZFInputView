//
//  UITextField+RedefinedKeyboard.h
//  NewApp
//
//  Created by 58 on 2019/8/1.
//  Copyright © 2019 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFInputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (RedefinedKeyboard)<ZFInputViewDelegate>

/**
 键盘展示view
 */
@property (nonatomic, strong) ZFInputView *zfInputView;

/**
 键盘类型
 */
@property (nonatomic, assign) ZFInputViewStyle keyboardStyle;


@end

NS_ASSUME_NONNULL_END
