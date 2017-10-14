//
//  TwoViewController.h
//  ReactiveCocoaDemo
//
//  Created by SDPMobile on 2017/10/13.
//  Copyright © 2017年 SoulJa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface TwoViewController : UIViewController
@property (nonatomic, strong) RACSubject *delegateSubject;
@end
