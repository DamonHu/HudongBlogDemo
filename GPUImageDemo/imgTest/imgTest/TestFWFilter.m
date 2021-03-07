//
//  TestFWFilter.m
//  imgTest
//
//  Created by damon on 17/1/6.
//  Copyright © 2017年 Huaimayi. All rights reserved.
//

#import "TestFWFilter.h"

NSString *const kFWNashvilleShaderString = SHADER_STRING
(
 precision lowp float;
 
 varying highp vec2 textureCoordinate;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     vec3 texel = texture2D(inputImageTexture, textureCoordinate).rgb;
     texel = vec3(
                  texture2D(inputImageTexture2, vec2(texel.r, .16666)).r,
                  texture2D(inputImageTexture2, vec2(texel.g, .5)).g,
                  texture2D(inputImageTexture2, vec2(texel.b, .83333)).b);
     gl_FragColor = vec4(texel, 1.0);
 }
 );

@implementation TestFWFilter
- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kFWNashvilleShaderString]))
    {
        return nil;
    }
    
    return self;
}
@end

@implementation FWNashvilleFilter

- (id)init
{
    if (!(self = [super init]))
    {
        return nil;
    }
    
    UIImage *image = [UIImage imageNamed:@"nashvilleMap.png"];
    
    imageSource = [[GPUImagePicture alloc] initWithImage:image];
    TestFWFilter *filter = [[TestFWFilter alloc] init];
    
    [self addFilter:filter];
    [imageSource addTarget:filter atTextureLocation:1];
    [imageSource processImage];
    
    self.initialFilters = [NSArray arrayWithObjects:filter, nil];
    self.terminalFilter = filter;
    
    return self;
}

@end

