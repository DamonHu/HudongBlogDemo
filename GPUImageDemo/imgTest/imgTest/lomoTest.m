//
//  lomoTest.m
//  imgTest
//
//  Created by damon on 2017/1/9.
//  Copyright © 2017年 Huaimayi. All rights reserved.
//

#import "lomoTest.h"
NSString *const kFWLomofiShaderString = SHADER_STRING
(
 precision lowp float;
 
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 uniform sampler2D inputImageTexture3;
 
 void main()
 {
     
     vec3 texel = texture2D(inputImageTexture, textureCoordinate).rgb;//获取要处理图像的rgb值向量
     
     vec2 red = vec2(texel.r, 0.16666);
     vec2 green = vec2(texel.g, 0.5);
     vec2 blue = vec2(texel.b, 0.83333);//使要处理的图像和柔光混合，生成新的像素
     
     texel.rgb = vec3(
                      texture2D(inputImageTexture2, red).r,
                      texture2D(inputImageTexture2, green).g,
                      texture2D(inputImageTexture2, blue).b);
     //前面生成新的像素再与第二个输入图像的像素进行混合
     //使用第三个图像作为暗角模板与前面的像素混合
     vec2 tc = (2.0 * textureCoordinate) - 1.0;
     float d = dot(tc, tc);
     vec2 lookup = vec2(d, texel.r);
     texel.r = texture2D(inputImageTexture3, lookup).r;
     lookup.y = texel.g;
     texel.g = texture2D(inputImageTexture3, lookup).g;
     lookup.y = texel.b;
     texel.b    = texture2D(inputImageTexture3, lookup).b;
     //生成最终的LOMO效果
     gl_FragColor = vec4(texel,1.0);
 }
 );

@implementation TestFWFilter1
- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kFWLomofiShaderString]))
    {
        return nil;
    }
    
    return self;
}
@end

@implementation lomoTest
- (id)init
{
    if (!(self = [super init]))
    {
        return nil;
    }
    
    TestFWFilter1 *filter = [[TestFWFilter1 alloc] init];
    [self addFilter:filter];
    //设置第二个输入图像
    UIImage *image = [UIImage imageNamed:@"lomoMap"];
    imageSource1 = [[GPUImagePicture alloc] initWithImage:image];
    [imageSource1 addTarget:filter atTextureLocation:1];
    [imageSource1 processImage];
    //设置第三个输入图像
    UIImage *image1 = [UIImage imageNamed:@"vignetteMap"];
    imageSource2 = [[GPUImagePicture alloc] initWithImage:image1];
    [imageSource2 addTarget:filter atTextureLocation:2];
    [imageSource2 processImage];
    self.initialFilters = [NSArray arrayWithObjects:filter, nil];
    self.terminalFilter = filter;
    return self;
}
@end
