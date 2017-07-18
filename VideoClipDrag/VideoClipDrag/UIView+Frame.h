//
//  UIView+Frame.h
//  YZUser
//
//  Created by shuni on 2017/5/27.
//  Copyright © 2017年 shuni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (CGFloat)frameX;
- (CGFloat)frameY;
- (CGFloat)frameW;
- (CGFloat)frameH;
- (CGSize)size;
- (CGFloat)centerX;
- (CGFloat)centerY;

- (void)setFrameX:(CGFloat)x;
- (void)setFrameY:(CGFloat)y;
- (void)setFrameW:(CGFloat)width;
- (void)setFrameH:(CGFloat)height;
- (void)setSize:(CGSize)size;
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;

@end
