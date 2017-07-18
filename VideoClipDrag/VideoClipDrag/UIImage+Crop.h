//
//  UIImage+Crop.h
//  JianLiXiu
//
//  Created by Damon on 2017/3/20.
//  Copyright © 2017年 damon. All rights reserved.
//
//图片裁剪类

#import <UIKit/UIKit.h>

@interface UIImage (Crop)

/**
 裁剪图片

 @param rect 裁剪图片的范围
 @return 裁剪过的图片
 */
-(UIImage *)imageByCroppingWithRect:(CGRect)rect;


/**
 返回占位图

 @param size 占位图大小
 @return 返回的占位图
 */
+(UIImage*)placeholderImgWithSize:(CGSize)size;


/**
 检测两个image是否相同

 @param img 对比的image
 @return 是否相等
 */
-(BOOL)checkEqual:(UIImage*)img;
@end
