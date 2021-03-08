//
//  MyCollectionViewCell.m
//  collectionDemo
//
//  Created by Damon on 16/8/10.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

//重写初始化方法
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self setCellImage:@"demo.jpg"];
        [self.contentView addSubview:self.myImgView];
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 70, 40)];
        [self setCellLabelText:@"demo"];
        [self.contentView addSubview:self.myLabel];
        //可以设置圆角
        self.layer.cornerRadius = 30;
    }
    return self;
}

//更改图片
-(void)setCellImage:(NSString*)ImgName
{
    [self.myImgView setImage:[UIImage imageNamed:ImgName]];
}

//更改文字
-(void)setCellLabelText:(NSString*)text
{
    [self.myLabel setText:text];
}

@end
