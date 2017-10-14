//
//  TwoViewController.m
//  ReactiveCocoaDemo
//
//  Created by SDPMobile on 2017/10/13.
//  Copyright © 2017年 SoulJa. All rights reserved.
//

#import "TwoViewController.h"
#import "LoginViewModel.h"

@interface TwoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfUsername;

@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@property (nonatomic, strong) LoginViewModel *loginViewModel;
- (IBAction)onClickBtn;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [[self.view rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:self] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"改变了");
//    }];
//    
//    self.view.center = CGPointZero;
    [self bindModel];
    
}

- (void)bindModel {
    // 给模型的属性绑定信号
    // 只要账号文本框一改变，就会给account赋值
    RAC(self.loginViewModel.account, account) = _tfUsername.rac_textSignal;
    RAC(self.loginViewModel.account, password) = _tfPassword.rac_textSignal;
    
    // 绑定登录按钮
    RAC(self.loginBtn, enabled) = self.loginViewModel.enableLoginSignal;
    
    // 监听登录按钮点击
    // 监听登录按钮点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        // 执行登录事件
        [self.loginViewModel.loginCommand execute:nil];
    }];

}

- (LoginViewModel *)loginViewModel {
    if (_loginViewModel == nil) {
        _loginViewModel = [[LoginViewModel alloc] init];
    }
    return _loginViewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickBtn {
    // 通知第一个控制器，告诉它，按钮被点了
    
    // 通知代理
    // 判断代理信号是否有值
//    if (_delegateSubject) {
//        // 有值，才需要通知
//        [_delegateSubject sendNext:nil];
//    }
}
@end
