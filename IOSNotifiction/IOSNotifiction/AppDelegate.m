//
//  AppDelegate.m
//  IOSNotifiction
//
//  Created by Damon on 16/8/24.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UILocalNotification * local = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if ([local.userInfo[@"name"] isEqualToString:@"Damon"]) {
        NSLog(@"damon");
        [self jump:2];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"Application did receive local notifications");
    // 在这里写跳转代码
    // 如果是应用程序在前台,依然会收到通知,但是收到通知之后不应该跳转
    if (application.applicationState == UIApplicationStateActive)
    {
        return;
    }
    if (application.applicationState == UIApplicationStateInactive) {
        // 当应用在后台收到本地通知时执行的跳转代码
        //可以通过设置通知时的userinfo过滤某条通知
        if ([notification.userInfo[@"name"] isEqualToString:@"Damon"]) {
            NSLog(@"damon");
        }
        //可以得到所有的通知
        for (UILocalNotification *noti in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
            NSLog(@"%@",noti.fireDate);
        }
        //通知之后可以取消对应的通知
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
    [self jump:1];
}

-(void)jump:(int)key
{
    //不同的状态进来，打开不同的网页
    if (key == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.hudongdong.com"]];
    }
    else if (key == 2){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.hudongdong.com/webList.html"]];
    }

}
@end
