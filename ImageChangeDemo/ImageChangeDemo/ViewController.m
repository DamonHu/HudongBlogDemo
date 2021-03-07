//
//  ViewController.m
//  ImageChangeDemo
//
//  Created by damon on 2017/2/14.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ChangeColor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 140, 40)];
    [button setTitle:@"渲染红色" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(setColorsRed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 160, 140, 40)];
    [button2 setTitle:@"渲染橘色" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(setColorsOrange) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

-(void)setColorsRed{
    UIImage *img =  [UIImage imageNamed:@"test.png"];
    
    UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 300, 300)];
    [imgview setImage:[img imageChangeColor:[UIColor redColor]]];//brownColor
    [self.view addSubview:imgview];
}

-(void)setColorsOrange{
    UIImage *img =  [UIImage imageNamed:@"test.png"];
    
    UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 400, 300, 300)];
    [imgview setImage:[img imageChangeColor:[UIColor orangeColor]]];
    [self.view addSubview:imgview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
