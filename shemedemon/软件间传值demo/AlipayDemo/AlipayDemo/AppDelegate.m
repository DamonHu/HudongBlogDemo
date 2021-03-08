//
//  AppDelegate.m
//  AlipayDemo
//
//  Created by 卫明阳 on 15/10/8.
//  Copyright (c) 2015年 WeiMingYang. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate


//被外部程序调用打开的时候  会调用这个方法
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    //把url转换成字符串类型
    NSString * urlString = url.absoluteString;
    
    //分割字符串  得到所有的参数
    NSString * parmarts = [[urlString componentsSeparatedByString:@"?"] lastObject];
    
    //分割字符串  分别得到每一个参数
    NSArray * parmartsArray = [parmarts componentsSeparatedByString:@"&"];

    NSMutableArray * valuesArray = [NSMutableArray array];
    for (int i = 0; i < [parmartsArray count]; i ++)
    {
        NSString * string = parmartsArray[i];
        
        NSString * value = [[string componentsSeparatedByString:@"="] lastObject];
        
        [valuesArray addObject:value];
    }
    
    
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"你将要购买%@游戏点卡，价值%@元",valuesArray[0],valuesArray[1]] delegate:self cancelButtonTitle:@"支付" otherButtonTitles:@"取消支付", nil];
    [alertView show];
    
    [self.window setBackgroundColor:[UIColor orangeColor]];
    
    return YES;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSURL * url = nil;
    if (buttonIndex == 0)
    {
        url = [NSURL URLWithString:@"xiaoMing://?result=success"];
    }
    else
    {
        url = [NSURL URLWithString:@"xiaoMing://?result=failure"];
    }
    
    [[UIApplication sharedApplication] openURL:url];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    [self.window setBackgroundColor:[UIColor redColor]];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
