//
//  ViewController.m
//  app2
//
//  Created by Damon on 16/7/18.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 70, 70)];
    [button setTitle:@"唤醒app" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(awakeother) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)awakeother
{
    NSLog(@"唤醒app");
    NSString * url = @"damon://ssss";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
    NSString *ll = @"damon://sdf?mmmm?ss";
    NSURL * uu = [NSURL URLWithString:ll];
    NSLog(@"uu:%@\n",uu);
    NSLog(@"scheme:%@\n",[uu scheme]);
    NSLog(@"host:%@\n",[uu host]);
    NSLog(@"query:%@\n",[uu query]);
    NSLog(@"%@\n",[uu relativeString]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
