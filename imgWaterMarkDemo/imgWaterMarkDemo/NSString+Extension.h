//
//  NSString+Extension.h
//  JianLiXiu
//
//  Created by shuni on 2017/4/9.
//  Copyright © 2017年 damon. All rights reserved.
//http://www.jianshu.com/p/a7f55e456539

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
 计算多行文字高度，可以处理计算带行间距的

 @param size 文字的最大宽度和最大高度，高度不选可以选择MAXFLOAT
 @param font 字号
 @param lineSpacing 行间距
 @return 文字的大小
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;



@end
