//
//  Touch.h
//  hudongdong
//
//  Created by admin on 15/2/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Touch : UIWindow
{
    UIImageView *_imageView;
}
@property(nonatomic,assign)BOOL isShowMenu;
-(id)initWithFrame:(CGRect)frame imageName:(NSString*)name;
@end
