//
//  ViewController.h
//  copyDemo
//
//  Created by Damon on 16/9/13.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>

@property (strong,nonatomic)UITextField *text1 ;
@property (strong,nonatomic)UITextView *textView;
@property (strong,nonatomic)UILabel *label;
@end

