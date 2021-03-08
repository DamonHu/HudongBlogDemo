//
//  ViewController.m
//  off
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.path = [[NSUserDefaults standardUserDefaults] stringForKey:@"txtpath"];
    if ([self.path isEqualToString:@""]||!self.path) {
        self.textField=[[NSTextField alloc]initWithFrame:NSRectFromCGRect(CGRectMake(180, 230, 100, 30))];
        [self.view addSubview:self.textField];
        NSButton *button = [[NSButton alloc]initWithFrame:NSRectFromCGRect(CGRectMake(300, 230, 80, 30))];
        [button setTag:10];
        [button setTitle:@"保存"];
        [button setTarget:self];
        [button setAction:@selector(setAdminPath:)];
        [self.view addSubview:button];
    }
    NSButton *button4 = [[NSButton alloc]initWithFrame:NSRectFromCGRect(CGRectMake(390, 230, 80, 30))];
    [button4 setTitle:@"重置目录"];
    [button4 setTarget:self];
    [button4 setAction:@selector(clearAdminPath)];
    [self.view addSubview:button4];
    NSButton *button = [[NSButton alloc]initWithFrame:NSRectFromCGRect(CGRectMake(180, 150, 100, 50))];
    [button setImage:[NSImage imageNamed:@"jiaban.png"]];
    [button setTarget:self];
    [button setTag:1];
    [button setAction:@selector(addWorkTime:)];
    [self.view addSubview:button];
    NSButton *button2 = [[NSButton alloc]initWithFrame:NSRectFromCGRect(CGRectMake(80, 50, 110, 40))];
    [button2 setTitle:@"节假日上班"];
    [button2 setTarget:self];
    [button2 setTag:2];
    [button2 setAction:@selector(addWorkTime:)];
    [self.view addSubview:button2];
    NSButton *button3 = [[NSButton alloc]initWithFrame:NSRectFromCGRect(CGRectMake(280, 50, 110, 40))];
    [button3 setTitle:@"节假日下班"];
    [button3 setTarget:self];
    [button3 setTag:3];
    [button3 setAction:@selector(addWorkTime:)];
    [self.view addSubview:button3];
    // Do any additional setup after loading the view.
}
-(void)setAdminPath:(NSButton*)sender
{
    if ([self.textField.stringValue isEqualToString:@""]) {
        NSAlert *alert = [[NSAlert alloc]init];
        [alert addButtonWithTitle:@"确定"];
        [alert setMessageText:@"请输入mac用户名称"];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert runModal];
    }
    else
    {
    self.path=self.textField.stringValue;
    [[NSUserDefaults standardUserDefaults] setValue:self.path forKey:@"txtpath"];
    [sender setHidden:true];
    [self.textField setHidden:true];
    }
}
-(void)clearAdminPath
{
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"txtpath"];
    [self viewDidLoad];
}
- (void)addWorkTime:(NSButton*)sender
{
    NSDateFormatter *form=[[NSDateFormatter alloc]init];
    [form setDateFormat:@"yyyy-MM"];
    NSString *date=[form stringFromDate:[NSDate date]];
    self.path=[NSString stringWithFormat:@"/Users/%@/%@.txt",self.path,date];
    NSFileManager *filemanager=[NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:self.path]) {
        //NSLog(@"已经存在");
    }
    else
    {
        NSData *data=[[NSString stringWithFormat:@"%@记录\n\n",date] dataUsingEncoding:NSUTF8StringEncoding];
      bool succeed =  [filemanager createFileAtPath:self.path contents:data attributes:nil];
        if (succeed) {
            //NSLog(@"创建成功");
        }
        else
        {
            //NSLog(@"创建失败");
            NSAlert *alert = [[NSAlert alloc]init];
            [alert addButtonWithTitle:@"确定"];
            [alert setMessageText:@"创建文件失败"];
            [alert setAlertStyle:NSWarningAlertStyle];
            [alert runModal];
            return;
        }
    }
    [self writeFile:sender.tag];
}
-(void)writeFile:(NSInteger)tag
{
     NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    if (tag==1) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss EEEE\n"];
    }
    else if (tag==2)
    {
       [formatter setDateFormat:@"\n\t\tyyyy-MM-dd EEEE\n上班时间：HH:mm:ss "];
    }
    else if (tag==3)
    {
        [formatter setDateFormat:@" ==== 下班时间：HH:mm:ss\n\n"];
    }
    NSString *timeStr=[formatter stringFromDate:[NSDate date]];
    NSData *data=[timeStr dataUsingEncoding:NSUTF8StringEncoding];
    NSFileHandle *handle=[NSFileHandle fileHandleForWritingAtPath:self.path];
    [handle seekToEndOfFile];
    [handle writeData:data];
    [handle closeFile];
    NSAlert *alert = [[NSAlert alloc]init];
    [alert addButtonWithTitle:@"确定"];
    [alert setMessageText:@"今天加班记录成功"];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert runModal];
}
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
