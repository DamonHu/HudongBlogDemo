//
//  Person.h
//  arcTest
//
//  Created by Damon on 2017/4/22.
//  Copyright © 2017年 damon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (strong,nonatomic) NSString *name;
//@property (strong,nonatomic) Person *person;  //强引用
@property (weak,nonatomic) Person *person;  //弱引用
@end
