//
//  ViewController.m
//  arcTest
//
//  Created by Damon on 2017/4/22.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *aPerson = [[Person alloc] init];
    aPerson.name = @"hu";
    NSLog(@"%@,%lu",aPerson.name,CFGetRetainCount((__bridge CFTypeRef)aPerson));
    
    Person *bPerson = [[Person alloc] init];
    bPerson.name = @"dong";
    NSLog(@"%@,%lu",bPerson.name,CFGetRetainCount((__bridge CFTypeRef)bPerson));

    NSLog(@"========================");
    
    aPerson.person = bPerson;
    NSLog(@"%@,%lu",aPerson.name,CFGetRetainCount((__bridge CFTypeRef)aPerson));
    NSLog(@"%@,%lu",bPerson.name,CFGetRetainCount((__bridge CFTypeRef)bPerson));
    
    NSLog(@"========================");
    
    bPerson = nil;
    NSLog(@"%@,%@",aPerson.person.name,bPerson.name);
    
    NSLog(@"========================");
    
    [self initButton];
}

-(void)initButton{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn setTitle:@"切换" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(changeVC) forControlEvents:UIControlEventTouchUpInside];
}

-(void)changeVC{
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self presentViewController:secondVC animated:true completion:nil];
}

-(void)logCallback:(viewCallBack)callback
{
    self.callBack = callback;
    NSLog(@"回调咯");
    self.callBack(2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
