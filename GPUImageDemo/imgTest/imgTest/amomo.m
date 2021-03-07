//
//  amomo.m
//  imgTest
//
//  Created by damon on 2017/1/9.
//  Copyright © 2017年 Huaimayi. All rights reserved.
//

#import "amomo.h"

NSString *const kFWAmaroShaderString = SHADER_STRING
(
 precision lowp float;
 
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2; //blowout;
 uniform sampler2D inputImageTexture3; //overlay;
 uniform sampler2D inputImageTexture4; //map
 
 void main()
 {
     
     vec4 texel = texture2D(inputImageTexture, textureCoordinate);
     vec3 bbTexel = texture2D(inputImageTexture2, textureCoordinate).rgb;
     
     texel.r = texture2D(inputImageTexture3, vec2(bbTexel.r, texel.r)).r;
     texel.g = texture2D(inputImageTexture3, vec2(bbTexel.g, texel.g)).g;
     texel.b = texture2D(inputImageTexture3, vec2(bbTexel.b, texel.b)).b;
     
     vec4 mapped;
     mapped.r = texture2D(inputImageTexture4, vec2(texel.r, .16666)).r;
     mapped.g = texture2D(inputImageTexture4, vec2(texel.g, .5)).g;
     mapped.b = texture2D(inputImageTexture4, vec2(texel.b, .83333)).b;
     mapped.a = 1.0;
     
     gl_FragColor = mapped;
 }
 );

@implementation amomo
- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kFWAmaroShaderString]))
    {
        return nil;
    }
    
    return self;
}
@end

@implementation AmomoFilter
- (id)init
{
    if (!(self = [super init]))
    {
        return nil;
    }
    
    amomo *filter = [[amomo alloc] init];
    [self addFilter:filter];
    //设置第二个输入图像
    UIImage *image = [UIImage imageNamed:@"blackboard1024.png"];
    imageSource1 = [[GPUImagePicture alloc] initWithImage:image];
    [imageSource1 addTarget:filter atTextureLocation:1];
    [imageSource1 processImage];
    //设置第三个输入图像
    UIImage *image1 = [UIImage imageNamed:@"overlayMap.png"];
    imageSource2 = [[GPUImagePicture alloc] initWithImage:image1];
    [imageSource2 addTarget:filter atTextureLocation:2];
    [imageSource2 processImage];
    //设置第四个输入图像
    UIImage *image2 = [UIImage imageNamed:@"amaroMap.png"];
//    UIImage *image2 = [UIImage imageNamed:@"lomoMap.png"];
    imageSource3 = [[GPUImagePicture alloc] initWithImage:image2];
    [imageSource3 addTarget:filter atTextureLocation:3];
    [imageSource3 processImage];
    self.initialFilters = [NSArray arrayWithObjects:filter, nil];
    self.terminalFilter = filter;
    return self;
}
@end

