//
//  amomo.h
//  imgTest
//
//  Created by damon on 2017/1/9.
//  Copyright © 2017年 Huaimayi. All rights reserved.
//

#import "GPUImageFourInputFilter.h"
#import "GPUImage.h"

@interface amomo : GPUImageFourInputFilter

@end

@interface AmomoFilter : GPUImageFilterGroup
{
    GPUImagePicture *imageSource1;
    GPUImagePicture *imageSource2;
    GPUImagePicture *imageSource3;
}
@end
