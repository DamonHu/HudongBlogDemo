//
//  ItemModel.h
//  CellDequeueReusableDemo
//
//  Created by Damon on 2017/11/24.
//  Copyright © 2017年 damon. All rights reserved.
//

#import <Foundation/Foundation.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
typedef NS_ENUM(NSUInteger, ItemType) {
    ItemTypeLeftImg,
    ItemTypeRightImg,
    ItemTypeNoImg,
};

@interface ItemModel : NSObject
@property (strong,nonatomic) NSString *itemTitle;   //标题
@property (strong,nonatomic) NSString *itemDetail;  //介绍
@property (strong,nonatomic) NSString *price;       //价格
@property (strong,nonatomic) NSString *image;       //预览图
@property (strong,nonatomic) NSString *payUrl;      //支付链接
@property (assign,nonatomic) ItemType itemType;     //展示类型

-(instancetype)initWithDictionary:(NSDictionary*)dic;
@end
