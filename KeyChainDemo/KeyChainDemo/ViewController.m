//
//  ViewController.m
//  KeyChainDemo
//
//  Created by Damon on 16/9/10.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "ViewController.h"
#import "KeychainItemWrapper.h"
#import "SSKeychain.h"
#import "customKeyChainTool.h"

#define DAMON @"damons"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 240, 40)];
    [button1 setTitle:@"苹果官方KeychainItemWrapper使用" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(AppleKeyChain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 300, 240, 40)];
    [button2 setTitle:@"SSKeychain使用方法" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(SSKeychain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(10, 500, 240, 40)];
    [button3 setTitle:@"SecurityKeychain使用方法" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(SecurityKeychain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
}

//苹果官方keychain使用
-(void)AppleKeyChain
{
    NSLog(@"AppleKeyChain");
    //标识符（Identifier）在后面我们要从keychain中取数据的时候会用到。如果你想要在应用之间共享信息，那么你需要指定访问组（access group）。有同样的访问组 的应用能够访问同样的keychain信息。
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:DAMON accessGroup:nil];

    if (![wrapper objectForKey:(id)kSecValueData]) {
        NSLog(@"没有blog这个key");
    }
    else{
        NSLog(@"%@",[wrapper objectForKey:(id)kSecValueData]);
    }
//    设置service 必须
    [wrapper setObject:DAMON forKey:(id)kSecAttrService];
    //设置account 必须
    [wrapper setObject:DAMON forKey:(id)kSecAttrAccount];
    
    [wrapper setObject:@"hudongdongspp" forKey:(id)kSecValueData];
    
    //设置访问权限
    [wrapper setObject:(id)kSecAttrAccessibleAlwaysThisDeviceOnly forKey:(id)kSecAttrAccessible];
    
}

//SSKeychain使用方法
-(void)SSKeychain
{
    NSLog(@"SSKeychain");
    //读取
    if (![SSKeychain passwordForService:@"blog" account:@"hu"]) {
        NSLog(@"没有");
    }
    else{
        NSLog(@"%@",[SSKeychain passwordForService:@"blog" account:@"hu"]);
    }
    //写入
    [SSKeychain setPassword:@"damon" forService:@"blog" account:@"hu"];
    [SSKeychain setAccessibilityType:kSecAttrAccessibleAlwaysThisDeviceOnly];
}
//SecurityKeychain使用方法
-(void)SecurityKeychain
{
    NSLog(@"SecurityKeychain");
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:@"damon" forKey:@"key"];
    [customKeyChainTool save:@"mmmmm" data:usernamepasswordKVPairs];
    NSLog(@"%@",[(NSMutableDictionary*)[customKeyChainTool load:@"mmmmm"] objectForKey:@"key"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
