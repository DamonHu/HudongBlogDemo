//
//  Touch.m
//  hudongdong
//
//  Created by admin on 15/2/12.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "Touch.h"
#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
UIButton *button[4];//button数组
CGPoint touchpoint;//触摸点的位置
@implementation Touch
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame imageName:(NSString *)name
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelAlert;
        [self makeKeyAndVisible];
        _imageView = [[UIImageView alloc]initWithFrame:(CGRect){0, 0,frame.size.width, frame.size.height}];
        _imageView.image = [UIImage imageNamed:name];
        _imageView.alpha = 0.3;
        [self addSubview:_imageView];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(locationChange:)];
        pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:pan];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [self addGestureRecognizer:tap];
        touchpoint=self.frame.origin;
        [self initbutton];
        self.isShowMenu=false;
    }
    return self;
}
//初始化button
-(void)initbutton
{
    for (int i=0; i<4; i++) {
        button[i]=[UIButton buttonWithType:UIButtonTypeCustom];
        [button[i] setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [button[i] setTag:(100+i)];
        [button[i] addTarget:self action:@selector(buttonfunc:) forControlEvents:UIControlEventTouchUpInside];
        [button[i] setHidden:true];
        [self addSubview:button[i]];
    }
}
-(void)buttonfunc:(UIButton*)sender
{
    switch (sender.tag) {
        case 100:
        {
            NSLog(@"100");
        }
            break;
        case 101:
        {
            NSLog(@"101");
        }
            break;
        case 102:
        {
            NSLog(@"102");
        }
            break;
        case 103:
        {
            NSLog(@"103");
        }
            break;
        default:
            break;
    }
}
-(void)buttonchange
{
    if (self.isShowMenu) {
        [self setFrame:CGRectMake(touchpoint.x, touchpoint.y, 40, 40)];
        for (int i=0; i<4; i++) {
            [button[i] setHidden:true];
            NSLog(@"%f,%f",self.center.x, self.center.y);
            
        }
        self.isShowMenu=false;
    }
    else
    {
        for (int i=0; i<4; i++) {
            [button[i] setHidden:false];
            if (touchpoint.x<kScreenWidth/2) {
                [self setFrame:CGRectMake(touchpoint.x, touchpoint.y, 250, 40)];
                [button[i] setFrame:CGRectMake((i+1)*50, 0, 40, 40)];
            }
            else
            {
                [self setFrame:CGRectMake(touchpoint.x-210, touchpoint.y, 250, 40)];
                [button[i] setFrame:CGRectMake((i+1)*50, 0, 40, 40)];
            }
        }
        self.isShowMenu=true;
    }
}
//改变位置
-(void)locationChange:(UIPanGestureRecognizer*)p
{
    [[UIApplication sharedApplication] keyWindow];
    CGPoint panPoint = [p locationInView:[[UIApplication sharedApplication] keyWindow]];
    if(p.state == UIGestureRecognizerStateBegan)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(changeColor) object:nil];
        _imageView.alpha = 0.8;
    }
    else if (p.state == UIGestureRecognizerStateEnded)
    {
        [self performSelector:@selector(changeColor) withObject:nil afterDelay:4.0];
    }
    if(p.state == UIGestureRecognizerStateChanged)
    {
        self.center = CGPointMake(panPoint.x, panPoint.y);
    }
    else if(p.state == UIGestureRecognizerStateEnded)
    {
        if(panPoint.x <= kScreenWidth/2)
        {
            if(panPoint.y <= 40+HEIGHT/2 && panPoint.x >= 20+WIDTH/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, HEIGHT/2);
                }];
            }
            else if(panPoint.y >= kScreenHeight-HEIGHT/2-40 && panPoint.x >= 20+WIDTH/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, kScreenHeight-HEIGHT/2);
                }];
            }
            else if (panPoint.x < WIDTH/2+15 && panPoint.y > kScreenHeight-HEIGHT/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(WIDTH/2, kScreenHeight-HEIGHT/2);
                }];
            }
            else
            {
                CGFloat pointy = panPoint.y < HEIGHT/2 ? HEIGHT/2 :panPoint.y;
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(WIDTH/2, pointy);
                }];
            }
        }
        else if(panPoint.x > kScreenWidth/2)
        {
            if(panPoint.y <= 40+HEIGHT/2 && panPoint.x < kScreenWidth-WIDTH/2-20 )
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, HEIGHT/2);
                }];
            }
            else if(panPoint.y >= kScreenHeight-40-HEIGHT/2 && panPoint.x < kScreenWidth-WIDTH/2-20)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(panPoint.x, 480-HEIGHT/2);
                }];
            }
            else if (panPoint.x > kScreenWidth-WIDTH/2-15 && panPoint.y < HEIGHT/2)
            {
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(kScreenWidth-WIDTH/2, HEIGHT/2);
                }];
            }
            else
            {
                CGFloat pointy = panPoint.y > kScreenHeight-HEIGHT/2 ? kScreenHeight-HEIGHT/2 :panPoint.y;
                [UIView animateWithDuration:0.2 animations:^{
                    self.center = CGPointMake(320-WIDTH/2, pointy);
                }];
            }
        }
    }
    touchpoint=self.frame.origin;
}
//点击事件
-(void)click:(UITapGestureRecognizer*)t
{
    _imageView.alpha = 0.8;
    [self buttonchange];
    [self performSelector:@selector(changeColor) withObject:nil afterDelay:4.0];
}
-(void)changeColor
{
    [UIView animateWithDuration:2.0 animations:^{
        _imageView.alpha = 0.3;
    }];
}

@end
