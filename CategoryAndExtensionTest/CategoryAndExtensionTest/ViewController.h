//
//  ViewController.h
//  CategoryAndExtensionTest
//
//  Created by damon on 2017/1/12.
//  Copyright © 2017年 damon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"

@interface ViewController : UIViewController<ViewControllerTestDelegate>
@property(strong,readonly) NSString *blog;

//输出
-(void)testLog;
@end

