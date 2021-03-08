//
//  ViewController.m
//  checkColor
//
//  Created by Damon on 16/4/28.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorView = [[NSView alloc]initWithFrame:NSMakeRect(120, 165, 200, 100)];
    [self.view addSubview:self.colorView];
    NSImageView *imageView =[[NSImageView alloc]initWithFrame:NSMakeRect(0, 0, 470, 100)];
    NSImage *image =[NSImage imageNamed:@"help.png"];
    [imageView setImage:image];
    [self.view addSubview:imageView];
    [self initTextField];
    [self initButton];
}

-(void)initTextField{
    self.redTextField = [[NSTextField alloc]initWithFrame:NSMakeRect(120, 135, 80, 24)];
    [self.redTextField setPlaceholderString:@"redColor:0"];
    [self.view addSubview:self.redTextField];
    self.greenTextField = [[NSTextField alloc]initWithFrame:NSMakeRect(230, 135, 80, 24)];
    [self.greenTextField setPlaceholderString:@"greenColor:0"];
    [self.view addSubview:self.greenTextField];
    self.blueTextField = [[NSTextField alloc]initWithFrame:NSMakeRect(340, 135, 80, 24)];
    [self.blueTextField setPlaceholderString:@"blueColor:0"];
    [self.view addSubview:self.blueTextField];
    self.hexTextField = [[NSTextField alloc]initWithFrame:NSMakeRect(120, 100, 130, 24)];
    [self.hexTextField setPlaceholderString:@"hexColor:FFB6C1"];
    [self.view addSubview:self.hexTextField];
}

-(void)initButton{
    self.comfirmButton = [[NSButton alloc]initWithFrame:NSMakeRect(340, 100, 80, 24)];
    [self.comfirmButton setTitle:@"查看颜色"];
    [self.comfirmButton setAction:@selector(checkColor)];
    [self.view addSubview:self.comfirmButton];
    self.cleanButton = [[NSButton alloc]initWithFrame:NSMakeRect(10, 100, 70, 24)];
    [self.cleanButton setTitle:@"清空颜色"];
    [self.cleanButton setAction:@selector(cleanColor)];
    [self.view addSubview:self.cleanButton];
}

-(void)cleanColor{
    self.redTextField.stringValue = @"";
    self.greenTextField.stringValue = @"";
    self.blueTextField.stringValue = @"";
    self.hexTextField.stringValue = @"";
}

-(void)checkColor{
    float redColor = 0.0;
    float greenColor = 0.0;
    float blueColor = 0.0;
    NSColor *color;
    if ((![[self.redTextField stringValue] isEqual: @""])&&(![[self.redTextField stringValue] isEqual: @""])&&(![[self.redTextField stringValue] isEqual: @""])) {
       redColor = [[self.redTextField stringValue] floatValue]/255.0;
       greenColor  = [[self.greenTextField stringValue] floatValue]/255.0;
       blueColor  = [[self.blueTextField stringValue] floatValue]/255.0;
       color =[NSColor colorWithRed:redColor green:greenColor blue:blueColor alpha:1.0f];
    }
    else if (![[self.hexTextField stringValue] isEqual:@""])
    {
        color = [self getColor:[self.hexTextField stringValue]];
        NSLog(@"%@",color);
    }
    else{
        NSError * error = [NSError errorWithDomain:@"请输入RGB颜色值或者16进制颜色值" code:1 userInfo:NULL];
        NSAlert * alert = [NSAlert alertWithError:error];
        [alert runModal];
        return;
    }
    [self.colorView.layer setBackgroundColor:color.CGColor];
}
//16进制获取颜色
-(NSColor*) getColor:(NSString*)hexColor
{
    unsigned int red=0,green=0,blue=0;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    //颜色显示
    [self.redTextField setStringValue:[NSString stringWithFormat:@"%u",red]];
    [self.greenTextField setStringValue:[NSString stringWithFormat:@"%u",green]];
    [self.blueTextField setStringValue:[NSString stringWithFormat:@"%u",blue]];
    
    return [NSColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

@end
