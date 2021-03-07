//
//  ViewController.m
//  Iphone3DtouchDemo
//
//  Created by damon on 16/10/27.
//  Copyright © 2016年 damon. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTouch]; //动态创建快捷菜单
    [self testPeek];    //peek
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)createTouch
{
    //默认样式
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove];
    //自定义图片
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"sa.png"];
    
    NSDictionary *userdic = [NSDictionary dictionaryWithObjectsAndKeys:@"damon",@"name",@"http://www.hudongdong.com",@"blogurl", nil];
    
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"damonText1" localizedTitle:@"动态创建第一个标题" localizedSubtitle:@"这个是动态创建的" icon:icon1 userInfo:nil];
     UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"damonText2" localizedTitle:@"动态创建第二个标题" localizedSubtitle:@"这个也是动态创建的,有用户信息" icon:icon2 userInfo:userdic];
    [UIApplication sharedApplication].shortcutItems=[NSArray arrayWithObjects:item1,item2, nil];
    
    //再重复动态创建会覆盖掉前面动态创建的，但是不会覆盖掉info里面创建的
//     UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] initWithType:@"damonText2" localizedTitle:@"第三个标题" localizedSubtitle:@"这个也是动态创建的" icon:icon2 userInfo:nil];
//    [UIApplication sharedApplication].shortcutItems = [NSArray arrayWithObjects:item3, nil];
}

-(void)testPeek{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 200, 100, 100)];
    [imageView setImage:[UIImage imageNamed:@"sa.png"]];
    [self.view addSubview:imageView];
    [imageView setUserInteractionEnabled:true];
    
    [self registerForPreviewingWithDelegate:self sourceView:imageView];
}

//预览
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0)
{
    SecondViewController *v = [[SecondViewController alloc] init];
    return v;
}

//重按进入
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0)
{
    NSLog(@"重按进入");
    [previewingContext setSourceRect:CGRectMake(10, 10, 100, 200)];
    SecondViewController *v = [[SecondViewController alloc] init];
    [self presentViewController:v animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
