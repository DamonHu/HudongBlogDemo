//
//  SecondViewController.h
//  CategoryAndExtensionTest
//
//  Created by damon on 2017/1/12.
//  Copyright © 2017年 damon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ViewControllerTestDelegate <NSObject>

@required
-(void)showTime:(NSString*)myTime;

@optional
-(void)showName:(NSString*)myName;

@end


@interface SecondViewController : UIViewController
@property(strong,nonatomic) id<ViewControllerTestDelegate> delegate;

-(void)changeName;
-(void)changeTime;
@end
