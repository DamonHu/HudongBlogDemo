//
//  HMImageTools.m
//  lifeTool
//
//  Created by Damon on 2017/9/15.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "HMImageTools.h"
#import "NSString+Extension.h"

@implementation HMImageTools

+(UIImage*)compostBGImg:(UIImage*)bgImg withImg:(UIImage*)img withImgFrame:(CGRect)rect
{
    //以1.png的图大小为底图
    CGImageRef imgRef1 = bgImg.CGImage;
    CGFloat w1 = bgImg.size.width;
    CGFloat h1 = bgImg.size.height;
//    CGFloat w1 = CGImageGetWidth(imgRef1);
//    CGFloat h1 = CGImageGetHeight(imgRef1);
    
    CGImageRef imgRef = img.CGImage;
    
    //以1.png的图大小为画布创建上下文
    UIGraphicsBeginImageContext(CGSizeMake(w1, h1));
    [bgImg drawInRect:CGRectMake(0, 0, w1, h1)];//先把1.png 画到上下文中
    [img drawInRect:rect];//再把小图放在上下文中
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
    UIGraphicsEndImageContext();//关闭上下文
    
    return resultImg;
}

+(UIImage*)compostImg:(UIImage*)bgImg withText:(NSString*)text withTextPoint:(CGPoint)point
{
    UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, bgImg.size.width, bgImg.size.height)];
    view.image = bgImg;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor blackColor]];
    [label setText:text];
    [label setNumberOfLines:0];
    UIFont *font = [UIFont systemFontOfSize:40];
    [label setFont:font];
    CGSize size = CGSizeMake(bgImg.size.width-200,2000);
    CGSize labelsize = [text boundingRectWithSize:size font:font lineSpacing:10];
    label.frame = CGRectMake(point.x,point.y, labelsize.width, labelsize.height);
    [view addSubview:label];
    return [self convertViewToImage:view];
}

+(UIImage*)convertViewToImage:(UIView*)view
{
    CGSize s = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    view.layer.contents = nil;
    return image;
}

@end
