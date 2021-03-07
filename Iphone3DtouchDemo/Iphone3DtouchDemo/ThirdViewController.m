//
//  ThirdViewController.m
//  Iphone3DtouchDemo
//
//  Created by damon on 16/10/27.
//  Copyright © 2016年 damon. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(10, 30, 100, 30)];
    [btn setTitle:@"返回上一页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dis) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(10, 200, 300, 400)];
    [imageView setImage:[UIImage imageNamed:@"tap.png"]];
    [self.view addSubview:imageView];
    [imageView setUserInteractionEnabled:true];
    
    self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 200, 40)];
    [self.myLabel setTextColor:[UIColor redColor]];
    [self.view addSubview:self.myLabel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.myLabel setText:[NSString stringWithFormat:@"%f",touches.anyObject.force]];
    if (touches.anyObject.force< 1.0f) {
        [self.myLabel setText:@"快用力"];
    }
    if (touches.anyObject.force> 5.0f) {
        [self.myLabel setText:@"你太用力了"];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.myLabel setText:[NSString stringWithFormat:@"最大承受压力:%f",touches.anyObject.maximumPossibleForce]];
    NSLog(@"%s",__FUNCTION__);
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    NSLog(@"%s",__FUNCTION__);
}
- (void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches NS_AVAILABLE_IOS(9_1)
{
    NSLog(@"%s",__FUNCTION__);
}

-(void)dis{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
