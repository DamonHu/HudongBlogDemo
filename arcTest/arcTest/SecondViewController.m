//
//  SecondViewController.m
//  arcTest
//
//  Created by Damon on 2017/4/22.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "SecondViewController.h"
#import "ViewController.h"

@interface SecondViewController ()
{
    NSString *name;
}
@end

@implementation SecondViewController
-(void)dealloc{
    NSLog(@"dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.m_person = [[Person alloc] init];
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
    __weak typeof(self) weakSelf = self;
    [((ViewController*)[self presentingViewController]) logCallback:^(int s) {
        weakSelf.m_person.name = [NSString stringWithFormat:@"%d",s];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf->name = [NSString stringWithFormat:@"%d",s];
        NSLog(@"%d",s);
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
