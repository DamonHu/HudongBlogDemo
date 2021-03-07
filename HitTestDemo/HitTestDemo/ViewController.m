//
//  ViewController.m
//  HitTestDemo
//
//  Created by Damon on 2017/3/20.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImageView *imageView;
    UIImageView* imageView2;
    UIImageView* imageView3;
    UILabel *tiplabel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 200, 40)];
    [label setText:@"检测屏幕点击"];
    [label setTextColor:[UIColor redColor]];
    [self.view addSubview:label];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    [imageView setImage:[UIImage imageNamed:@"launchImg"]];
    [self.view addSubview:imageView];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 300, 40)];
    [label2 setText:@"不在一个view上检测两个物体碰撞，拖动下面粉红色滑块往上拉"];
    [label2 setNumberOfLines:2];
    [label2 setTextColor:[UIColor redColor]];
    [self.view addSubview:label2];
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 250, 50, 250)];
    [scrollview setBackgroundColor:[UIColor lightGrayColor]];
    scrollview.delegate = self;
    [scrollview setContentSize:CGSizeMake(40, 600)];
    [self.view addSubview:scrollview];
    
    imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 50, 50)];
    [imageView2 setImage:[UIImage imageNamed:@"launchImg"]];
    [scrollview addSubview:imageView2];
    
    imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300, 200, 2)];
    [imageView3 setImage:[UIImage imageNamed:@"launchImg"]];
    [self.view addSubview:imageView3];
    
    //状态提示Tip
    tiplabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 100, 100, 40)];
    [tiplabel setTextColor:[UIColor blueColor]];
    [self.view addSubview:tiplabel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    NSLog(@"相对于view的坐标：%f,%f",[touches.anyObject locationInView:self.view].x,[touches.anyObject locationInView:self.view].y);
    NSLog(@"在imageview上的坐标：%f,%f",[touches.anyObject locationInView:imageView].x,[touches.anyObject locationInView:imageView].y);
    
    if ([imageView pointInside:[touches.anyObject locationInView:imageView] withEvent:event]) {
        NSLog(@"点击了图块");
        [tiplabel setText:@"点击了图块"];
    }
    else{
        NSLog(@"没有点击");
        [tiplabel setText:@"没有点击"];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //这个是判断的origin，更精确的可以使用image的中心判断
//    [imageView2 pointInside:[imageView3 convertPoint:CGPointMake(imageView3.bounds.origin.x+imageView3.bounds.size.width/2, imageView3.bounds.origin.y) toView:imageView2] withEvent:nil]
    if ([imageView2 pointInside:[imageView3 convertPoint:imageView3.bounds.origin toView:imageView2] withEvent:nil]) {
        [tiplabel setText:@"碰撞了"];
    }
    else{
        [tiplabel setText:@"没有碰撞"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
