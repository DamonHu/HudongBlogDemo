//
//  KeyChainTool.h
//  KeyChainDemo
//
//  Created by Damon on 16/9/10.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
@interface KeyChainTool : NSObject
+(void)save:(NSString*)string;
+(void)load:(NSString*)Key;
@end
