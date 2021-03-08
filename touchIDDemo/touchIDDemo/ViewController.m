//
//  ViewController.m
//  touchIDDemo
//
//  Created by damon on 16/10/31.
//  Copyright © 2016年 damon. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建
    LAContext *lacontext = [[LAContext alloc] init];
    NSError* error;
    /**
     LAPolicyDeviceOwnerAuthentication  9.0以上可用，指纹解锁六次错误自动跳转密码输入
     LAPolicyDeviceOwnerAuthenticationWithBiometrics    8.0以上可用，指纹解锁五次错误消失
     */
    //是否支持指纹解锁
    if ([lacontext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
         NSLog(@"支持指纹解锁");
        [lacontext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请按指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"解锁成功");
            }
            else{
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"切换到了其他APP");
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"用户取消验证");
                        lacontext.localizedCancelTitle=@"用户取消";
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        NSLog(@"用户选择输入密码");
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择输入密码，切换主线程处理
                            lacontext.localizedFallbackTitle=@"输入登录密码";
                            NSLog(@"sss");
                        }];
                        break;
                    }
                    default:
                    {
                        NSLog(@"%@",error.localizedDescription);
                    }
                        break;
                }
            }
        }];
    }
    else{
        //不支持指纹识别，LOG出错误详情
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID未录入");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"没有设置密码");
                break;
            }
            case LAErrorTouchIDNotAvailable:
            {
                NSLog(@"TouchID不可用");
                break;
            }
            default:
            {
                NSLog(@"%@",error.localizedDescription);
                break;
            }
        }
    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
