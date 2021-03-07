//
//  TestFWFilter.h
//  imgTest
//
//  Created by damon on 17/1/6.
//  Copyright © 2017年 Huaimayi. All rights reserved.
//

#import "GPUImageTwoInputFilter.h"
#import "GPUImage.h"

@interface TestFWFilter : GPUImageTwoInputFilter

@end

@interface FWNashvilleFilter : GPUImageFilterGroup
{
    GPUImagePicture *imageSource ;
}

@end
