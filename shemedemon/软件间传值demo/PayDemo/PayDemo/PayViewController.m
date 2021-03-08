//
//  PayViewController.m
//  PayDemo
//
//  Created by 卫明阳 on 15/10/8.
//  Copyright (c) 2015年 WeiMingYang. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()

@end

@implementation PayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)payClick:(id)sender
{
    //跳转到另外一个程序 并且传值
    NSURL * url = [NSURL URLWithString:@"AlipayDemo://?gameName=WOW&price=200"];
    
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }

}
@end






