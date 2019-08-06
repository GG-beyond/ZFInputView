//
//  UITextField+RedefinedKeyboard.m
//  NewApp
//
//  Created by 58 on 2019/8/1.
//  Copyright © 2019 58. All rights reserved.
//

#import "UITextField+RedefinedKeyboard.h"
#import <objc/runtime.h>

static  char key_inputView;
static  char key_style;

@implementation UITextField (RedefinedKeyboard)

#pragma mark PrivateMehtod
- (NSRange)selectedRange{
    
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}

#pragma mark - ZFInputViewDelegate
- (BOOL)textFieldShouldDelete:(ZFInputView *)keyboardView{
    
    BOOL canDelete = YES;
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        
        canDelete = [self.delegate textField:self shouldChangeCharactersInRange:[self selectedRange] replacementString:@""];
    }
    if (canDelete) {
        
        [self deleteBackward];
    }
    return canDelete;
}
- (BOOL)textFieldShouldReturn:(ZFInputView *)keyboardView{
    
    BOOL canReturn = YES;
    if ([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        
        canReturn = [self.delegate textFieldShouldReturn:self];
    }
    if (canReturn) {
    }
    return canReturn;

}
- (void)numberKeyboard:(ZFInputView *)numberKeyboard replacementString:(NSString *)string{
    
    BOOL canEdit = YES;
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        
        canEdit = [self.delegate textField:self shouldChangeCharactersInRange:[self selectedRange] replacementString:string];
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
@end
