//
//  UIImage+Crop.m
//  JianLiXiu
//
//  Created by Damon on 2017/3/20.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "UIImage+Crop.h"

@implementation UIImage (Crop)

- (UIImage *)imageByCroppingWithRect:(CGRect)rect {
    CGImageRef imageRef = self.CGImage;
    CGImageRef imagePartRef = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *cropImage = [UIImage imageWithCGImage:imagePartRef];
    CGImageRelease(imagePartRef);
    return cropImage;
}

+(UIImage*)placeholderImgWithSize:(CGSize)size
{
    UIImage *pubimg = [UIImage imageNamed:@"pub_bitmap"];
    pubimg = [pubimg resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    return pubimg;
}

-(BOOL)checkEqual:(UIImage*)img
{
    NSData *data1 = UIImagePNGRepresentation(self);
    NSData *data2 = UIImagePNGRepresentation(img);
    return [data1 isEqual:data2];
}
@end
