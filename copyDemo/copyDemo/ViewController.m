//
//  ViewController.m
//  copyDemo
//
//  Created by Damon on 16/9/13.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 300, 40)];
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitle:@"斯蒂芬森的发" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(testssss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 300, 40)];
    [self.label setText:@"哈哈哈"];
    [self.label setTextColor:[UIColor grayColor]];
    [self.view addSubview:self.label];
    [self.label setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testLabel:)];
    [self.label addGestureRecognizer:tap];
    
    self.text1 = [[UITextField alloc] initWithFrame:CGRectMake(100, 400, 300, 40)];
    [self.text1 setText:@"东东的博客"];
    [self.text1 setTextColor:[UIColor grayColor]];
    [self.view addSubview:self.text1];
    [self.text1 setAdjustsFontSizeToFitWidth:YES];
    self.text1.tintColor=[UIColor clearColor];//隐藏输入光标
    self.text1.delegate = self;
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(100,500,300,40)];
    [self.textView setText:@"Damon胡东东"];
    self.textView.delegate = self;
    [self.textView setTextColor:[UIColor redColor]];
    [self.view addSubview:self.textView];
    self.textView.editable =NO;
    UITapGestureRecognizer *tap2 =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testView)];
    [self.textView addGestureRecognizer:tap2];
}

-(void)testLabel:(id)sender{
    NSLog(@"Label的手势");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击拷贝Label信息" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *al = [UIAlertAction actionWithTitle:@"拷贝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //复制
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:self.label.text];
        NSLog(@"拷贝成功");
    }];
    UIAlertAction *al2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:al];
    [alert addAction:al2];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)testView{
    NSLog(@"textView的手势");
    [self.textView selectAll:self];
}

-(void)testssss:(UIButton*)sender
{
    NSLog(@"按钮");

}
#pragma mark UItextFieldDelegate
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    return NO;
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing");
    textField.inputView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    [textField selectAll:textField];//并不是每次都调用，所以需要用performselector
    [textField performSelector:@selector(selectAll:) withObject:textField afterDelay:0.f];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
