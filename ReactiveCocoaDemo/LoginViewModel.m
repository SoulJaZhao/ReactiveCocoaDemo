//
//  LoginViewModel.m
//  ReactiveCocoaDemo
//
//  Created by SDPMobile on 2017/10/14.
//  Copyright © 2017年 SoulJa. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel
- (Account *)account
{
    if (_account == nil) {
        _account = [[Account alloc] init];
    }
    return _account;
}
- (instancetype)init
{
    if (self = [super init]) {
        [self initialBind];
    }
    return self;
}

- (void)initialBind {
    // 监听账号的属性值改变，把他们聚合成一个信号。
    _enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.account, account),RACObserve(self.account, password)] reduce:^id _Nullable (NSString *account,NSString *pwd){
        return @(account.length && pwd.length);
    }];
    
    // 处理登录业务逻辑
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"点击了登录");
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 模仿网络延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [subscriber sendNext:@"登录成功"];
                
                // 数据传送完毕，必须调用完成，否则命令永远处于执行状态
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];
    
    // 监听登录产生的数据
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"登录接收到的数据:%@",x);
    }];
    
    // 监听登录状态
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x isEqualToNumber:@(YES)]) {
            
            // 正在登录ing...
            // 用蒙版提示
            NSLog(@"正在登陆");
            
            
        }else
        {
            // 登录成功
            // 隐藏蒙版
            NSLog(@"登录完成");
        }
    }];
}
@end
