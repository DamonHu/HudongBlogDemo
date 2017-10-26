//
//  ViewController.m
//  imgWaterMarkDemo
//
//  Created by Damon on 2017/10/26.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "ViewController.h"
#import "HMImageTools.h"
#import "NSString+Extension.h"

#define kWHScale 1136.0/640.0

@interface ViewController ()
@property (strong,nonatomic)UIImageView *bgImageView;
@property (strong,nonatomic)UIImageView *imageView;
@property (strong,nonatomic)NSString * content; //名言警句
@property (strong,nonatomic)NSString * mrName;  //名人
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _content = @"愿你出走半生\n归来仍是少年";
    _mrName = @"孙衍";
    
    [self CreateUI];
    
    [self createNewImg:[UIImage imageNamed:@"2017-09-15"]];
}

-(void)CreateUI{
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 64)];
    [self.view addSubview:_bgImageView];
    
    _imageView = [[UIImageView alloc] init];
    [self.view addSubview:_imageView];
    [_imageView setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.2,[UIScreen mainScreen].bounds.size.width*kWHScale*0.1, [UIScreen mainScreen].bounds.size.width*0.6,[UIScreen mainScreen].bounds.size.width*kWHScale*0.6)];
}

-(void)createNewImg:(UIImage*)img{
    //先将带二维码的图片拼接到背景图上面
    UIImage *image2 = [UIImage imageNamed:@"qianCover"];
    UIImage *image = [HMImageTools compostBGImg:img withImg:image2 withImgFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(img.size.width/2.0-75, 200, 150, 220)];
    [view.layer setMasksToBounds:YES];
    [view.layer setBorderWidth:1.0f];
    [view.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    //然后将时间拼接到背景图
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:date] integerValue];
    [formatter setDateFormat:@"dd"];
    NSInteger currentDay=[[formatter stringFromDate:date] integerValue];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 150, 90)];
    [titleLabel setText:[NSString stringWithFormat:@"%ld",(long)currentDay]];
    [titleLabel setFont:[UIFont fontWithName:@"AmericanTypewriter" size:70]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [view addSubview:titleLabel];
    
    UILabel *commonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, 150, 120)];
    [commonLabel setNumberOfLines:0];
    [commonLabel setText:[NSString stringWithFormat:@"Oct\n%ld",currentYear]];
    [commonLabel setTextAlignment:NSTextAlignmentCenter];
    [commonLabel setFont:[UIFont fontWithName:@"AmericanTypewriter" size:40]];
    [commonLabel setTextColor:[UIColor whiteColor]];
    [view addSubview:commonLabel];
    
    //将想要显示的文字拼接到带二维码的图片上
    UIImage *image3 = [HMImageTools convertViewToImage:view];
    image = [HMImageTools compostBGImg:image withImg:image3 withImgFrame:CGRectMake(img.size.width/2.0-75, 200, 150, 220)];
    
    NSString *str = [NSString stringWithFormat:@"%@\n-\n%@",self.content,self.mrName];
    UIFont *font = [UIFont systemFontOfSize:40];
    CGSize size = CGSizeMake(img.size.width-200,2000);
    CGSize labelsize = [str boundingRectWithSize:size font:font lineSpacing:10];
    
    
    UIImage *labelImage = [HMImageTools compostImg:image withText:str withTextPoint:CGPointMake(img.size.width/2.0-labelsize.width/2.0, img.size.height - 100 - labelsize.height)];
    [_imageView setImage:labelImage];
    
    [_bgImageView setImage:labelImage];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, _bgImageView.frame.size.width, _bgImageView.frame.size.height);
    [_bgImageView addSubview:effectView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
