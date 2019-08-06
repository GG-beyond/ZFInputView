//
//  ViewController.m
//  NewApp
//
//  Created by 58 on 2019/8/1.
//  Copyright © 2019 58. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+RedefinedKeyboard.h"
#import "UITextView+RedefinedKeyboard.h"

@interface ViewController ()
@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.textfield];
    [self.view addSubview:self.textView];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textfield resignFirstResponder];
}
#pragma mark - Getter
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
@end
