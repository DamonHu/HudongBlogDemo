//
//  ItemModel.m
//  CellDequeueReusableDemo
//
//  Created by Damon on 2017/11/24.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel
-(instancetype)initWithDictionary:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
