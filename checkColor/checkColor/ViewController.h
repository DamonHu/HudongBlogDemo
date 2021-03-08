//
//  ViewController.h
//  checkColor
//
//  Created by Damon on 16/4/28.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (strong,nonatomic) NSView *colorView;
@property (strong,nonatomic) NSTextField * redTextField;
@property (strong,nonatomic) NSTextField * greenTextField;
@property (strong,nonatomic) NSTextField * blueTextField;



@property (strong,nonatomic) NSTextField * hexTextField;
@property (strong,nonatomic) NSButton * comfirmButton;
@property (strong,nonatomic) NSButton * cleanButton;
@end

