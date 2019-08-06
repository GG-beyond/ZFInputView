# ZFInputView
UITextfield 自定义InputView键盘


![image](https://github.com/GG-beyond/ZFInputView/blob/master/NewApp/ZFInputView/xzf_input.gif)
![image](https://github.com/GG-beyond/ZFInputView/blob/master/NewApp/ZFInputView/xzf_input2.gif)
![image](https://github.com/GG-beyond/ZFInputView/blob/master/NewApp/ZFInputView/xzf_input3.gif)





- (UITextField *)textfield{
    
    if (!_textfield) {
        
        _textfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, 200, 20)];
        _textfield.placeholder = @"请输入";
        _textfield.keyboardStyle = ZFInputViewStyleIDNumber;
    }
    return _textfield;
}

- (UITextView *)textView{
    
    if (!_textView) {
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 300, 300, 50)];
        _textView.backgroundColor = [UIColor redColor];
        _textView.placeholder = @"请输入内容";
        _textView.keyboardStyle = ZFInputViewStyleIDNumber;
        _textView.font = [UIFont systemFontOfSize:12];
    }
    return _textView;
}

