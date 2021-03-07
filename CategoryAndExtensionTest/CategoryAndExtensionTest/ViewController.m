//
//  ViewController.m
//  CategoryAndExtensionTest
//
//  Created by damon on 2017/1/12.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+ViewControllerCategory.h"
#import "ViewController_ViewControllerExtension.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setStr:@"mm"];
    
    [self changeBlog];
    
    
    //测试类别Categoty
    [self testCategoty];
    
    SecondViewController *view = [[SecondViewController alloc] init];
    view.delegate = self;
    [view changeName];
    [view changeTime];
}


-(void)testLog
{
    NSLog(@"testLog");
    NSLog(@"%@",self.str);
    NSLog(@"%@",self.blog);
}


-(void)changeBlog
{
    self.blog = @"hudong";
}

#pragma mark --代理里面的函数
-(void)showTime:(NSString*)myTime
{
    NSLog(@"%@",myTime);
}

-(void)showName:(NSString*)myName
{
    NSLog(@"%@",myName);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
