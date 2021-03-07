//
//  ViewController.h
//  arcTest
//
//  Created by Damon on 2017/4/22.
//  Copyright © 2017年 damon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^viewCallBack)(int);

@interface ViewController : UIViewController
@property(copy,nonatomic) viewCallBack callBack;

-(void)logCallback:(viewCallBack)callback;
@end

