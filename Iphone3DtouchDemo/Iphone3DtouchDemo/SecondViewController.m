//
//  SecondViewController.m
//  Iphone3DtouchDemo
//
//  Created by damon on 16/10/27.
//  Copyright © 2016年 damon. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(10, 200, 300, 400)];
    [imageView setImage:[UIImage imageNamed:@"dd.png"]];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [label setTextColor:[UIColor redColor]];
    [label setText:@"爱，就一个字"];
    [self.view addSubview:label];
    
    UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(10, 30, 100, 30)];
    [btn setTitle:@"返回上一页" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dis) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)dis{
    [self dismissViewControllerAnimated:true completion:nil];
}

//快捷键弹出窗
- (NSArray <id <UIPreviewActionItem>> *)previewActionItems
{
    NSLog(@"previewActionItems");
    // 普通样式
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"我" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton1我");
    }];
    
    //已被选择的样式 后面有个对勾
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"爱" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton2爱");
    }];
    
    //警示样式（红色字体）
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"你" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Aciton3你");
    }];
    
    //已被选择的样式 后面有个对勾
    UIPreviewAction *action4 = [UIPreviewAction actionWithTitle:@"跳转到第三个页面" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        ThirdViewController *vc =[[ThirdViewController alloc] init];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:true completion:nil];
    }];
    
    NSArray *actions = [NSArray arrayWithObjects:action1,action2,action3,action4, nil];
    
    return actions;
    
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
