//
//  ViewController.m
//  screenshotDemo
//
//  Created by Damon on 16/9/11.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    UIButton *button =[[UIButton alloc] initWithFrame:CGRectMake(10, 200, 100, 40)];
    [button setTitle:@"截图" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveScreenshotToPhotosAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)saveScreenshotToPhotosAlbum:(UIView *)view
{
    //截图保存到相册
//    UIImageWriteToSavedPhotosAlbum([self captureScreen], nil, nil, nil);
    
    //把一张图片贴到截图上面
    UIImageWriteToSavedPhotosAlbum([self addImage:[UIImage imageNamed:@"demo.jpg"] toImage:[self captureScreen]], nil, nil, nil);
}

- (UIImage *) captureScreen {
    NSLog(@"capture");
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(image2.size);
   
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
