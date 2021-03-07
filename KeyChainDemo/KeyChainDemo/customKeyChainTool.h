//
//  customKeyChainTool.h
//  KeyChainDemo
//
//  Created by Damon on 16/9/10.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface customKeyChainTool : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;
@end
