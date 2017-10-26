//
//  HMImageTools.h
//  lifeTool
//
//  Created by Damon on 2017/9/15.
//  Copyright © 2017年 damon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HMImageTools : NSObject



/**
 合成两张图片

 @param bgImg 背景图片
 @param img 上面的图片
 @param rect 图片2在画布中的大小和位置
 @return 生成的图片
 */
+(UIImage*)compostBGImg:(UIImage*)bgImg withImg:(UIImage*)img withImgFrame:(CGRect)rect;


/**
 合成图片和文字

 @param bgImg 图片
 @param text 文字
 @param point 文字在画布中的位置
 @return 生成的图片
 */
+(UIImage*)compostImg:(UIImage*)bgImg withText:(NSString*)text withTextPoint:(CGPoint)point;


/**
 view转换为图片

 @param view 要转换的view
 @return 生成的图片
 */
+(UIImage*)convertViewToImage:(UIView*)view;

@end
