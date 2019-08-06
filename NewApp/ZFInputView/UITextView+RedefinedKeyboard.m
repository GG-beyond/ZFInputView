//
//  UITextView+RedefinedKeyboard.m
//  NewApp
//
//  Created by 58 on 2019/8/6.
//  Copyright © 2019 58. All rights reserved.
//

#import "UITextView+RedefinedKeyboard.h"
#import <objc/runtime.h>

static  char key_inputView;
static  char key_style;
static  char key_placeholder;
static  char key_placeholderLabel;

@implementation UITextView (RedefinedKeyboard) 

- (NSRange)selectedRange{
    
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}
- (void)textChanged:(NSNotification *)notf{
    
    if (self.text.length>0) {
        
        self.placeholderLabel.hidden = YES;
    }else{
        self.placeholderLabel.hidden = NO;
    }
    
}

#pragma mark - ZFInputViewDelegate

- (BOOL)textFieldShouldDelete:(ZFInputView *)keyboardView{
    
    BOOL canDelete = YES;
    if ([self.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        
        canDelete = [self.delegate textView:self shouldChangeTextInRange:[self selectedRange] replacementText:@""];
    }
    if (canDelete) {
        
        [self deleteBackward];
    }
    return canDelete;
}
- (BOOL)textFieldShouldReturn:(ZFInputView *)keyboardView{
    
    BOOL canReturn = YES;
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        
        canReturn = [self.delegate textView:self shouldChangeTextInRange:[self selectedRange] replacementText:@"\n"];
    }
    if (canReturn) {
        
        [self numberKeyboard:keyboardView replacementString:@"\n"];
    }
    return canReturn;
    
}
- (void)numberKeyboard:(ZFInputView *)numberKeyboard replacementString:(NSString *)string{
    
    BOOL canEdit = YES;
    if ([self.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        
        canEdit = [self.delegate textView:self shouldChangeTextInRange:[self selectedRange] replacementText:string];
    }
    if (canEdit) {
        
        [self insertText:string];
    }
}

#pragma mark - Getter && Setter

//键盘控件
- (void)setZfInputView:(ZFInputView *)zfInputView{
    
    objc_setAssociatedObject(self, &key_inputView, zfInputView, OBJC_ASSOCIATION_RETAIN);
}
- (ZFInputView *)zfInputView{
    
    return objc_getAssociatedObject(self, &key_inputView);
}
//键盘类型
- (void)setKeyboardStyle:(ZFInputViewStyle)keyboardStyle{
    
    objc_setAssociatedObject(self, &key_style, @(keyboardStyle), OBJC_ASSOCIATION_ASSIGN);
    if (!self.zfInputView) {
        
        self.zfInputView = [[ZFInputView alloc] initWithStyle:keyboardStyle];
        self.zfInputView.inputDelegate = self;
    }
    self.inputView = self.zfInputView;
    
}
- (ZFInputViewStyle)keyboardStyle{
    
    return [objc_getAssociatedObject(self, &key_style) integerValue];
}
// 默认展示文案
- (void)setPlaceholder:(NSString *)placeholder{
    
    objc_setAssociatedObject(self, &key_placeholder, placeholder, OBJC_ASSOCIATION_RETAIN);
    if (!self.placeholderLabel) {
        
#warning mark - 目前placeholder只支持单行，可自行修改
        //注意
        UIEdgeInsets inset = self.textContainerInset;
        CGFloat borderWidth = self.layer.borderWidth;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(inset.left+borderWidth+lineFragmentPadding, inset.top, 100, 20)];
        self.placeholderLabel.font = self.font;
        self.placeholderLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:self.placeholderLabel];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    self.placeholderLabel.text = placeholder;
}
- (NSString *)placeholder{
    
    return objc_getAssociatedObject(self, &key_placeholder);
}
//默认文案label
- (void)setPlaceholderLabel:(UILabel *)placeholderLabel{
    
    objc_setAssociatedObject(self, &key_placeholderLabel, placeholderLabel, OBJC_ASSOCIATION_RETAIN);
}
- (UILabel *)placeholderLabel{
    
    return objc_getAssociatedObject(self, &key_placeholderLabel);
}
- (void)setFont:(UIFont *)font{
    
    //获取内容偏移量
    UIEdgeInsets inset = self.textContainerInset;
    //获取borderwidth
    CGFloat borderWidth = self.layer.borderWidth;
    //获取光标默认左边距
    CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;

    self.placeholderLabel.frame = CGRectMake(inset.left+lineFragmentPadding+borderWidth, inset.top, 100, font.lineHeight);
    self.placeholderLabel.font = font;
    [self setNeedsDisplay];
}
@end
