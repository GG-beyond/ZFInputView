//
//  ViewController.m
//  NewApp
//
//  Created by 58 on 2019/8/1.
//  Copyright © 2019 58. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+RedefinedKeyboard.h"

@interface ViewController ()
@property (nonatomic, strong) UITextField *textfield;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.textfield];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textfield resignFirstResponder];
}
#pragma mark - Getter
- (UITextField *)textfield{
    
    if (!_textfield) {
        
        _textfield = [[UITextField alloc] initWithFrame:CGRectMake(20, 300, 200, 20)];
        _textfield.placeholder = @"请输入";
        _textfield.keyboardStyle = ZFInputViewStyleDefault;
    }
    return _textfield;
}

@end
