//
//  ViewController+ViewControllerCategory.m
//  CategoryAndExtensionTest
//
//  Created by damon on 2017/1/12.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "ViewController+ViewControllerCategory.h"
#import <objc/runtime.h>
static const void *strKey = &strKey;

@implementation ViewController (ViewControllerCategory)
@dynamic str;

-(void)testCategoty
{
    [self testLog];
}

- (id)str
{
    return objc_getAssociatedObject(self, strKey);
}

-(void)setStr:(id)strs
{
     objc_setAssociatedObject(self, strKey, strs, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
