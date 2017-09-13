//
//  ViewController.m
//  ImgBlur
//
//  Created by Damon on 2017/9/13.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "ViewController.h"
#import "ImgTool.h"

@interface ViewController ()
@property (strong,nonatomic) UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 300, 400)];
    [_imgView setImage:[UIImage imageNamed:@"demo"]];
    [self.view addSubview:_imgView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 80, 40)];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTag:1];
    [button setTitle:@"CoreImage高斯模糊" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeImg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 30, 80, 40)];
    [button2 setBackgroundColor:[UIColor redColor]];
    [button2 setTag:2];
    [button2 setTitle:@"vImage高斯模糊" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(changeImg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(190, 30, 80, 40)];
    [button3 setBackgroundColor:[UIColor redColor]];
    [button3 setTag:3];
    [button3 setTitle:@"毛玻璃" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(changeImg:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}

-(void)changeImg:(UIButton*)sender{
    switch (sender.tag) {
        case 1:
        {
            [_imgView setImage:[ImgTool coreBlurImage:[UIImage imageNamed:@"demo"] withBlurNumber:2]];
        }
            break;
        case 2:
        {
            [_imgView setImage:[ImgTool imageBlurImage:[UIImage imageNamed:@"demo"] WithBlurNumber:0.99]];
        }
            break;
        case 3:
        {
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            effectView.frame = CGRectMake(0, 0, _imgView.frame.size.width*0.5, _imgView.frame.size.height);
            [_imgView addSubview:effectView];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
