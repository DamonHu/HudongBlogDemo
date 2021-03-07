//
//  lomoTest.h
//  imgTest
//
//  Created by damon on 2017/1/9.
//  Copyright © 2017年 Huaimayi. All rights reserved.
//

#import "GPUImageFilterGroup.h"
#import "GPUImageTwoInputFilter.h"
#import "GPUImage.h"
@interface TestFWFilter1 : GPUImageThreeInputFilter

@end

@interface lomoTest : GPUImageFilterGroup
{
    GPUImagePicture *imageSource1;
    GPUImagePicture *imageSource2;
}
@end
