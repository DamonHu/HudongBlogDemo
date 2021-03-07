//
//  AppDelegate.m
//  Iphone3DtouchDemo
//
//  Created by damon on 16/10/27.
//  Copyright © 2016年 damon. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //判断是通过桌面打开软件还是通过快捷按钮打开
    //快捷按钮打开软件 显示快捷按钮的type
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsShortcutItemKey]) {
        UIApplicationShortcutItem*item = [launchOptions objectForKey:UIApplicationLaunchOptionsShortcutItemKey];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 300, 300)];
        [label setText:[NSString stringWithFormat:@"%@",item.type]];
        [label setTextColor:[UIColor redColor]];
        [self.window.rootViewController.view addSubview:label];
        //可以传值
        if (item.userInfo) {
            [label setText:[NSString stringWithFormat:@"%@,%@",[item.userInfo objectForKey:@"name"],[item.userInfo objectForKey:@"blogurl"]]];
        }
        //return NO的话开启不再执行响应快捷按钮的函数
        //return YES的话执行响应快捷按钮的函数
        return NO;
    }
    return YES;
}

//响应快捷按钮的函数
// except when -application:willFinishLaunchingWithOptions: or -application:didFinishLaunchingWithOptions returns NO.
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler NS_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED
{
    NSLog(@"%@",shortcutItem.type);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 300, 300)];
    [label setText:[NSString stringWithFormat:@"%@",shortcutItem.localizedTitle]];
    [label setTextColor:[UIColor redColor]];
    [self.window.rootViewController.view addSubview:label];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
