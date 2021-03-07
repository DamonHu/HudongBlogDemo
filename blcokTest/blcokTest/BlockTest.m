//
//  BlockTest.m
//  blcokTest
//
//  Created by damon on 2017/2/7.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "BlockTest.h"

@implementation BlockTest
-(void)touchWithCall:(testCall)tes
{
    self.tess = tes;
    if (self.tess) {
        self.tess(1,@"hudongdong");
    }
}
@end
