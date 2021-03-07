//
//  BlockTest.h
//  blcokTest
//
//  Created by damon on 2017/2/7.
//  Copyright © 2017年 damon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^testCall)(int m,NSString*str);
@interface BlockTest : NSObject
@property(copy,nonatomic)testCall tess;
-(void)touchWithCall:(testCall)tes;
@end
