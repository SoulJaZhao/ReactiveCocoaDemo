//
//  LoginViewModel.h
//  ReactiveCocoaDemo
//
//  Created by SDPMobile on 2017/10/14.
//  Copyright © 2017年 SoulJa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface LoginViewModel : NSObject
@property (nonatomic, strong) Account *account;
@property (nonatomic, strong) RACSignal *enableLoginSignal;
@property (nonatomic, strong) RACCommand *loginCommand;
@end
