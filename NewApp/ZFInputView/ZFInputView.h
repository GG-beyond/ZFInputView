//
//  ZFInputView.h
//  testNew
//
//  Created by 58 on 2019/7/31.
//  Copyright © 2019 58. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZFInputViewStyle) {
    ZFInputViewStyleDefault = 0,//不带小数点的数字键盘
    ZFInputViewStyleDigitalNumber, //带小数点的数字键盘
    ZFInputViewStyleIDNumber,//身份证键盘
} NS_ENUM_AVAILABLE_IOS(7_0);

NS_ASSUME_NONNULL_BEGIN
@class ZFInputView;

@protocol ZFInputViewDelegate <NSObject>
@optional

/**
 返回值为Bool
 @param keyboardView ZFInputView
 @return 是否可以删除
 */
- (BOOL)textFieldShouldDelete:(ZFInputView *)keyboardView;

/**
 返回值为Bool
 @param keyboardView ZFInputView
 @return 是否有Return
 */
- (BOOL)textFieldShouldReturn:(ZFInputView *)keyboardView;

/**
 用于添加字符
 @param numberKeyboard ZFInputView
 @param string 添加字符
 */
- (void)numberKeyboard:(ZFInputView *)numberKeyboard replacementString:(NSString *)string;

@end
@interface ZFInputView : UIView

@property (nonatomic, weak) id<ZFInputViewDelegate> inputDelegate;
- (instancetype)initWithStyle:(ZFInputViewStyle)style;
- (void)dismissKeyboard;
@end

NS_ASSUME_NONNULL_END
