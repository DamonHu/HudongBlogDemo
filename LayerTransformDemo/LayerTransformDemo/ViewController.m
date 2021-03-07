//
//  ViewController.m
//  LayerTransformDemo
//
//  Created by damon on 2017/2/15.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 40)];
    [testBtn setTitle:@"T E S T" forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [testBtn addTarget:self action:@selector(startTransformAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
    
    self.m_addView = [[UIView alloc] initWithFrame:CGRectMake(10, 400, 300, 300)];
    [self.m_addView setHidden:true];
    [self.view addSubview:self.m_addView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    imgView.image = [UIImage imageNamed:@"1.png"];
    [self.m_addView addSubview:imgView];
  
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 40)];
    [doneBtn setTitle:@"D O N E" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [doneBtn addTarget:self action:@selector(endTransformAction) forControlEvents:UIControlEventTouchUpInside];
    [self.m_addView addSubview:doneBtn];
}

-(void)startTransformAction{
    NSLog(@"startTransformAction");
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    [CATransaction setAnimationDuration:2.0f];
//    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
//    self.view.layer.position = CGPointMake(20, 20);
//    [CATransaction commit];
    
    //原始变色
//    [UIView beginAnimations:@"test" context:nil];
//    [UIView setAnimationDuration:2.0f];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    self.view.backgroundColor = [UIColor redColor];
//    [UIView commitAnimations];
    
    
    //使用block块变色
//    [UIView animateWithDuration:2.0f animations:^{
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//        self.view.backgroundColor = [UIColor redColor];
//    }];
    
    
    //使用CABasicAnimation变色
//    CABasicAnimation *baseAnimation = [CABasicAnimation animation];
//    [baseAnimation setKeyPath:@"backgroundColor"];
//    
//    //结束后保持状态
//    [baseAnimation setRemovedOnCompletion:NO];
//    [baseAnimation setFillMode:kCAFillModeForwards];
//    //更改位置
////    [baseAnimation setKeyPath:@"position"];
////    [baseAnimation setFromValue:[NSValue valueWithCGRect:CGRectMake(0, 200, 100, 100)]];
////    [baseAnimation setToValue:[NSValue valueWithCGRect:CGRectMake(0, 400, 100, 100)]];
//
//    
//    [baseAnimation setToValue:(id)[UIColor redColor].CGColor];
//    
//    [self.view.layer addAnimation:baseAnimation forKey:@"ss"];
    
    //使用动画组groupAnimation，组合动画同时运行
    CABasicAnimation *baseAnimation = [CABasicAnimation animation];
    [baseAnimation setKeyPath:@"backgroundColor"];
    [baseAnimation setToValue:(id)[UIColor redColor].CGColor];
    
    CABasicAnimation *baseAnimation2 = [CABasicAnimation animation];
    [baseAnimation2 setKeyPath:@"position"];
    [baseAnimation2 setToValue:[NSValue valueWithCGRect:CGRectMake(0, 200, 100, 100)]];
    
    CABasicAnimation *baseAnimation3 = [CABasicAnimation animation];
    [baseAnimation3 setKeyPath:@"transform.rotation.y"];
    [baseAnimation3 setToValue:[NSNumber numberWithDouble:M_PI*200]];
    
    CAAnimationGroup *groupAniation = [[CAAnimationGroup alloc] init];
    [groupAniation setAnimations:[NSArray arrayWithObjects:baseAnimation,baseAnimation2,baseAnimation3, nil]];
    [groupAniation setDuration:2.0f];
    [groupAniation setRepeatCount:1];
    [groupAniation setRemovedOnCompletion:NO];
    [groupAniation setFillMode:kCAFillModeForwards];
    [self.view.layer addAnimation:groupAniation forKey:@"ss"];
    
    
    //转场动画
//    [self.m_addView setHidden:false];
//    [UIView beginAnimations:@"FlipAni" context:nil];
//    [UIView setAnimationDuration:1.0];
//    [UIView setAnimationDelegate:self];
////    [UIView setAnimationWillStartSelector:@selector(startAni:)];
////    [UIView setAnimationDidStopSelector:@selector(stopAni:)];
//    [UIView setAnimationRepeatCount:1];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.m_addView cache:NO];
//   
//    [UIView commitAnimations];
    
    //block块转场动画
    [self.m_addView setHidden:false];
    [UIView transitionWithView:self.m_addView duration:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        [UIView setAnimationRepeatCount:1];
    } completion:^(BOOL finished) {
        if (finished) {
             NSLog(@"compltion");
        }
    }];
}

-(void)endTransformAction{
    NSLog(@"endTransformAction");
    [UIView beginAnimations:@"FlipAnis" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatCount:1];
    [UIView setAnimationDidStopSelector:@selector(stopAni:)];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.m_addView cache:NO];
    [UIView commitAnimations];
}

- (void)stopAni:(NSString *)aniID {
    NSLog(@"%@ stop",aniID);
    [self.m_addView setHidden:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
