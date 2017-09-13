//
//  ImgTool.h
//  ImgBlur
//
//  Created by Damon on 2017/9/13.
//  Copyright © 2017年 damon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImgTool : NSObject

///CoreImage
+(UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

///vImage
+(UIImage*)imageBlurImage:(UIImage *)image WithBlurNumber:(CGFloat)blur;

@end
