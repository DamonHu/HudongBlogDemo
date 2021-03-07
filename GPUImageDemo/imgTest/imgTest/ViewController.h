//
//  ViewController.h
//  imgTest
//
//  Created by damon on 17/1/6.
//  Copyright © 2017年 Huaimayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"
#import "amomo.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController
@property (strong,nonatomic) UIImage *myImg;
@property (strong,nonatomic) GPUImageVideoCamera *videoCamera;
@property (strong,nonatomic) AmomoFilter *customFilter;
@property (strong,nonatomic) GPUImageMovieWriter *movieWriter;
@property (strong,nonatomic) NSString *pathToMovie;
@property (strong,nonatomic) AVPlayer *playss;
@property (strong,nonatomic) GPUImageStillCamera *stillCamera;
@end

