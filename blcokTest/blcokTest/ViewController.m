//
//  ViewController.m
//  blcokTest
//
//  Created by damon on 2017/2/7.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "ViewController.h"
#import "BlockTest.h"

typedef void(^testtt2)(int);
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 40)];
    [button setTitle:@"测试回调" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 100, 40)];
    [button2 setTitle:@"声明块使用" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(test2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];

}

//块回调
-(void)test{
    NSLog(@"test");
    BlockTest *bb = [[BlockTest alloc] init];
    [bb touchWithCall:^(int m, NSString *str) {
        NSLog(@"回调了%d,%@",m,str);
    }];
}

//声明块
-(void)test2{
    NSLog(@"test2");
    //声明一个块
    void (^testt)(int) = ^(int count){
        NSLog(@"%d",count);
    };
    //使用
    testt(10);
    
    //使用typedaf块
    testtt2 te = ^(int count){
        NSLog(@"%d",count);
    };
    te(20);
    
    //更改局部变量
    __block int m =0;
    testtt2 te2 = ^(int count){
        m=count;
        NSLog(@"m1: %d",m);
    };
    te2(30);
     NSLog(@"m2: %d",m);
    
    //加不加括号
    void (^test3)()=^{
        NSLog(@"没有变量");
    };
    test3();
    
    void (^test4)()=^(){
        NSLog(@"没有变量2");
    };
    test4();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
