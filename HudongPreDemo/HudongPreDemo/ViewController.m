//
//  ViewController.m
//  HudongPreDemo
//
//  Created by admin on 15/5/21.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //字符串相关[c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，也不区分发音符号
    NSPredicate *ppp=[NSPredicate predicateWithFormat:@"SELF BEGINSWITH[C]'SH'"];
    NSString *m=@"sh";
    if ([ppp evaluateWithObject:m]) {
        NSLog(@"包含 sh");
    }

    //判断是否全部是字母，matches 是整个都需要匹配的
    NSString *ss=@"[A-Za-z]+";
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",ss];
    NSString *aaaa=@"mm";
    if ([pre evaluateWithObject:aaaa]) {
        NSLog(@"全是字母");
    }
    //判断是否包含
    ss=@"mm";
    aaaa=@"mm11";
    pre=[NSPredicate predicateWithFormat:@"SELF CONTAINS %@",ss];
    if ([pre evaluateWithObject:aaaa]) {
        NSLog(@"含有字母mm");
    }
    //批量替换字符串
    NSError* error = NULL;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"(encoding=\")[^\"]+(\")" options:0 error:&error];
    NSString* sample = @"<xml encoding=\"abc\"></xml><xml encoding=\"def\"></xml><xml encoding=\"ttt\"></xml>";
    NSLog(@"Start:%@",sample);
    NSString* result = [regex stringByReplacingMatchesInString:sample options:0 range:NSMakeRange(0, sample.length) withTemplate:@"$1utf-8$2"];
    NSLog(@"Result:%@", result);
    
    //截取字符串
    //组装一个字符串，需要把里面的网址解析出来
    NSString *urlString=@"<meta/><link/><title>1Q84 BOOK1</title></head><body>";
    
    //NSRegularExpression类里面调用表达的方法需要传递一个NSError的参数。下面定义一个
    NSError *error1;
    
    //http+:[^\\s]* 这个表达式是检测一个网址的。(?<=title\>).*(?=</title)截取html文章中的<title></title>中内文字的正则表达式
    NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@"(?<=title\\>).*(?=</title)" options:0 error:&error1];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex1 firstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            
            //从urlString当中截取数据
            NSString *result=[urlString substringWithRange:resultRange];
            //输出结果
            NSLog(@"->%@<-",result);
        }    
        
    }
    
    //对象内容的判断
    person *person1=[[person alloc]init];
    person *person2=[[person alloc]init];
    person *person3=[[person alloc]init];
    [person1 setName:@"hudong"];
    [person1 setNumber:10];
    [person2 setName:@"blog"];
    [person2 setNumber:50];
    [person3 setName:@"com"];
    [person3 setNumber:100];
    NSPredicate *personPre=[NSPredicate predicateWithFormat:@"number > 20"];
    NSArray *personArray=[NSArray arrayWithObjects:person1,person2,person3, nil];
    //这个判断方法是示例，下面有一个 array 的更快捷的判断
    for (int i=0; i<[personArray count]; i++) {
        if ([personPre evaluateWithObject:[personArray objectAtIndex:i]]) {
            NSLog(@"%@",((person*)[personArray objectAtIndex:i]).name);
        }
    }
    
    //筛选含有1的数组 ，contains 是含有
    NSArray *array=[NSArray arrayWithObjects:@"beijing1",@"beijing2",@"beijing3",@"beijing4",@"beijing5", nil];
    NSString *str=@"1";
    NSPredicate *pp=[NSPredicate predicateWithFormat:@"SELF CONTAINS %@",str];
    NSLog(@"%@",[array filteredArrayUsingPredicate:pp]);
    //或者直接判断数组内对象，就是上面说的更快捷的方法
    NSPredicate * pppre = [NSPredicate predicateWithFormat:@"number>20"];
    NSArray *arrayPre=[personArray filteredArrayUsingPredicate: pppre];
    NSLog(@"%@",[[arrayPre objectAtIndex: 0] name]);
    //字典的占位符：
    NSPredicate *preTemplate = [NSPredicate predicateWithFormat:@"name==$NAME"];
    NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys: @"Name1", @"NAME",@"num",@"num",nil];
    NSPredicate *dicpre=[preTemplate predicateWithSubstitutionVariables: dic];//占位符就是字段对象里的key，因此你可以有多个占位符，只要key 不一样就可以了。
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
