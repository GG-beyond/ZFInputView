//
//  ZFInputView.m
//  testNew
//
//  Created by 58 on 2019/7/31.
//  Copyright © 2019 58. All rights reserved.
//

#import "ZFInputView.h"

@interface ZFInputView ()

@property (nonatomic, assign) ZFInputViewStyle inputStyle;//键盘类型
@property (nonatomic, strong) NSArray *dataSource;//数据源
@property (nonatomic, strong) UIButton *sureBt;//确定按钮
@property (nonatomic, strong) UIButton *deleteBt;//删除按钮
@property (nonatomic, strong) NSTimer *timer;//计时器

@end
@implementation ZFInputView{
    
    // 按钮横向之间的间隙
    CGFloat btnSpace;
    // 按钮纵向之间的间隙
    CGFloat btnLateralSpace;
    // 距离左边的距离
    CGFloat allBtnLeft;
    // 按钮的宽度
    CGFloat btnWidth;
    // 按钮的高度
    CGFloat btnHeight;
}

- (instancetype)initWithStyle:(ZFInputViewStyle)style{

    if (self = [super init]) {
        
        self.inputStyle = style;
        [self createSubView];
    }
    return self;
}
- (void)createSubView{
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    // 阴影偏移，默认(0, -3)
    self.layer.shadowOffset = CGSizeMake(0,-1);
    // 阴影透明度，默认0
    self.layer.shadowOpacity = 0.03;
    // 阴影半径，默认3
    self.layer.shadowRadius = 4;

    self.backgroundColor = [UIColor colorWithRed:0xF7/255.0 green:0xF7/255.0 blue:0xFB/255.0 alpha:1];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    NSArray *showNumberArray = self.dataSource;
    // 按钮横向之间的间隙
    btnSpace = 1;
    // 按钮纵向之间的间隙
    btnLateralSpace = 1;
    // 距离左边的距离
    allBtnLeft = 0;
    // 按钮的宽度
    btnWidth = (width-3*btnSpace-allBtnLeft*2)/4.0;
    // 按钮的高度
    btnHeight = btnWidth*64.0/94.0;
    
    for (NSInteger i = 0; i < showNumberArray.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:showNumberArray[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(i%3*(btnSpace+btnWidth), i/3*(btnLateralSpace+btnHeight), btnWidth, btnHeight);
        btn.tag = 100+i;
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:24];
        [btn setTitleColor: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickKeyborderBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i==11) {
            
            [btn setImage:[UIImage imageNamed:@"keyboard.png"] forState:UIControlStateNormal];
            btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        }
        [self addSubview:btn];
    }
    [self addSubview:self.deleteBt];
    [self addSubview:self.sureBt];
    
    CGFloat btHeight = 0;
    if (@available(iOS 11.0, *)) {//如果是iPhoneX等有安全区系列的手机，键盘高度需要增加34
        
        btHeight = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
    }
    self.frame = CGRectMake(0, 0, width, btnHeight*4+btnLateralSpace*3+btHeight);
}
- (void)deleteBtnLongTapAction:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        self.timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(clickDeleteBtn:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        
    }
    else if (longPress.state == UIGestureRecognizerStateEnded||longPress.state == UIGestureRecognizerStateCancelled||longPress.state == UIGestureRecognizerStateFailed) {
        
        [self.timer invalidate];
        self.timer = nil;
    }
}
//点击键盘上的按钮
- (void)clickKeyborderBtn:(UIButton *)sender{
    
    
    if (sender.tag==111) {
        [self dismissKeyboard];
    }else{
        
        if (self.inputDelegate && [self.inputDelegate respondsToSelector:@selector(numberKeyboard:replacementString:)]) {
            [self.inputDelegate numberKeyboard:self replacementString:sender.currentTitle];
        }
    }
}
//点击键盘“删除”按钮
- (void)clickDeleteBtn:(UIButton *)sender{
    
    if (self.inputDelegate && [self.inputDelegate respondsToSelector:@selector(textFieldShouldDelete:)]) {
        [self.inputDelegate textFieldShouldDelete:self];
    }

}
//点击键盘“确定”按钮
- (void)clickSureBtn:(UIButton *)sender{
    
    if (self.inputDelegate && [self.inputDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        [self.inputDelegate textFieldShouldReturn:self];
    }
}
//点击键盘下去
- (void)dismissKeyboard{
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    [window endEditing:YES];
}
#pragma mark - Setter & Getter
- (NSArray *)dataSource{
    
    if (!_dataSource) {
        
        if (self.inputStyle==ZFInputViewStyleDefault) {
            
            _dataSource = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"",@"0",@""];
        }else if (self.inputStyle==ZFInputViewStyleDigitalNumber) {
            
            _dataSource = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@".",@"0",@""];
        }else if (self.inputStyle==ZFInputViewStyleIDNumber){
            
            _dataSource = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"X",@"0",@""];
        }
    }
    return _dataSource;
}
- (UIButton *)deleteBt{
    
    if (!_deleteBt) {
        
        _deleteBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBt.frame = CGRectMake(3*(btnSpace+btnWidth), 0, btnWidth, btnHeight*2+btnLateralSpace);
        _deleteBt.backgroundColor = [UIColor whiteColor];
        _deleteBt.titleLabel.font = [UIFont systemFontOfSize:24];
        [_deleteBt setTitleColor: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0] forState:UIControlStateNormal];
        [_deleteBt setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
        _deleteBt.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_deleteBt addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteBtnLongTapAction:)];
        longPress.minimumPressDuration = 0.5; //定义按的时间
        [_deleteBt addGestureRecognizer:longPress];

    }
    return _deleteBt;
}
- (UIButton *)sureBt{
    
    if (!_sureBt) {
        
        _sureBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBt.frame = CGRectMake(3*(btnSpace+btnWidth), (btnHeight+btnLateralSpace)*2, btnWidth, btnHeight*2);
        _sureBt.backgroundColor =  [UIColor colorWithRed:71/255.0 green:103/255.0 blue:175/255.0 alpha:1/1.0];;
        _sureBt.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_sureBt setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBt setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBt addTarget:self action:@selector(clickSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBt;
}
- (void)dealloc{
    
    if (_timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
@end
