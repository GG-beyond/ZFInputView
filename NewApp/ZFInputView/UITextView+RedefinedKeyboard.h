//
//  UITextView+RedefinedKeyboard.h
//  NewApp
//
//  Created by 58 on 2019/8/6.
//  Copyright © 2019 58. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFInputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (RedefinedKeyboard)<ZFInputViewDelegate>
/**
 键盘展示view
 */
@property (nonatomic, strong) ZFInputView *zfInputView;

/**
 键盘类型
 */
@property (nonatomic, assign) ZFInputViewStyle keyboardStyle;

/**
 默认文字
 */
@property(nullable, nonatomic,copy)NSString *placeholder;// default is nil. string is drawn 70% gray

@property(strong, nonatomic,)UILabel *placeholderLabel; 


@end

NS_ASSUME_NONNULL_END
