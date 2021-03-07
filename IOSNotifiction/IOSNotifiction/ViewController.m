//
//  ViewController.m
//  IOSNotifiction
//
//  Created by Damon on 16/8/24.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

enum{
    LOCALNOTIFICATION1 = 1,  //指定时间
    LOCALNOTIFICATION2,     //时间间隔
};

#define D_ISHight(K) [[UIDevice currentDevice].systemVersion floatValue]>=K
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button =[[UIButton alloc] initWithFrame:CGRectMake(50, 100, 300, 100)];
    [button setTitle:@"添加本地通知(指定时间通知)" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addLocal:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:LOCALNOTIFICATION1];
    [self.view addSubview:button];
    
    UIButton *button1 =[[UIButton alloc] initWithFrame:CGRectMake(50, 250, 300, 100)];
    [button1 setTitle:@"添加本地通知(固定时间间隔通知)" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(addLocal:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTag:LOCALNOTIFICATION2];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 400, 200, 100)];
    [button2 setTitle:@"添加远程通知" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(addRomte) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

-(void)addLocal:(UIButton*)sender
{
    NSLog(@"添加本地通知");
    
    //ios8.0以上的系统需要注册通知
    if (D_ISHight(8.0)) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound|UIUserNotificationTypeBadge categories:nil]];  //注册通知
    }
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    //设置固定时间通知
    if (sender.tag == LOCALNOTIFICATION1) {
        NSDateFormatter * forma = [[NSDateFormatter alloc] init];
        [forma setDateFormat:@"HH:mm"];
        localNotification.fireDate = [forma dateFromString:@"12:00"];   //12点提醒
        [localNotification setRepeatInterval:NSCalendarUnitDay];        //每天12点
    }
    //设置重复间隔时间
    else if (sender.tag == LOCALNOTIFICATION1){
        NSDate *date =[[NSDate alloc] init];
        localNotification.fireDate = [date dateByAddingTimeInterval:10];//重复间隔的时长
        [localNotification setRepeatInterval:NSCalendarUnitSecond];//时间间隔单位，秒
    }
    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];   //时区
    
    //ios8.2以上的系统可以设置标题
    if (D_ISHight(8.2)) {
        [localNotification setAlertTitle:@"提醒标题"];
    }
    [localNotification setAlertBody:@"提醒内容：Damon"];
    [localNotification setAlertAction:@"锁屏时显示的动作标题"]; //在锁屏时显示的动作标题(完整测标题:"滑动来" + alertAction)
    [localNotification setApplicationIconBadgeNumber:1];    //设置提醒的软件右上角的小红点
    [localNotification setSoundName:UILocalNotificationDefaultSoundName];//默认声音
    //或者指定文件名localNotification.soundName = @"123.wav";
    [localNotification setAlertLaunchImage:@"demo.png"];
    [localNotification setUserInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Damon",@"name",@"blog",@"type", nil]];//设置属性
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];    //调用通知
}

-(void)addRomte
{
    //远程在远程那篇文章添加，防止太乱
    NSLog(@"添加远程通知");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
