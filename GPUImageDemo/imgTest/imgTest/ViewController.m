//
//  ViewController.m
//  imgTest
//
//  Created by damon on 17/1/6.
//  Copyright © 2017年 Huaimayi. All rights reserved.
//

#import "ViewController.h"
#import "TestFWFilter.h"
#import "lomoTest.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self baseUse];
//    [self moreUse];
//    [self testVideo];
    
    self.myImg = [UIImage imageNamed:@"llll.png"];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 500, 100, 40)];
    [btn setTitle:@"默认滤镜" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(baseUse) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 400, 200, 40)];
    [btn1 setTitle:@"原图" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(originPic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(150, 500, 200, 40)];
    [btn2 setTitle:@"FWNashvilleFilter" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(moreUse) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 550, 200, 40)];
    [btn3 setTitle:@"ThirdLomo" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(thirdTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(150, 550, 200, 40)];
    [btn4 setTitle:@"forthTest" forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(forthTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [[UIButton alloc] initWithFrame:CGRectMake(220, 600, 200, 40)];
    [btn5 setTitle:@"打开录像" forState:UIControlStateNormal];
    [btn5 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(testVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
    UIButton *btn6 = [[UIButton alloc] initWithFrame:CGRectMake(0, 600, 200, 40)];
    [btn6 setTitle:@"开始录像" forState:UIControlStateNormal];
    [btn6 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn6];
    
    UIButton *btn7 = [[UIButton alloc] initWithFrame:CGRectMake(100, 600, 200, 40)];
    [btn7 setTitle:@"结束录像" forState:UIControlStateNormal];
    [btn7 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn7 addTarget:self action:@selector(end) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn7];
    
    UIButton *btn8 = [[UIButton alloc] initWithFrame:CGRectMake(150, 400, 200, 40)];
    [btn8 setTitle:@"播放" forState:UIControlStateNormal];
    [btn8 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn8 addTarget:self action:@selector(plays) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn8];
    
    UIButton *btn9 = [[UIButton alloc] initWithFrame:CGRectMake(220, 400, 200, 40)];
    [btn9 setTitle:@"打开相机" forState:UIControlStateNormal];
    [btn9 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn9 addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn9];
    
    UIButton *btn10 = [[UIButton alloc] initWithFrame:CGRectMake(10, 440, 200, 40)];
    [btn10 setTitle:@"点击照相" forState:UIControlStateNormal];
    [btn10 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn10 addTarget:self action:@selector(startPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn10];
}

-(void)originPic{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.myImg];
    imageView.frame = CGRectMake(50,50,self.myImg.size.width-200 ,self.myImg.size.height-200);
    [self.view addSubview:imageView];
}

//直接使用
-(void)baseUse{
    
    //使用黑白素描滤镜
    //    GPUImageSketchFilter *disFilter = [[GPUImageSketchFilter alloc] init];
    
    //漩涡
    //    GPUImageSwirlFilter *disFilter = [[GPUImageSwirlFilter alloc] init];
    
    //亮度
    //    GPUImageBrightnessFilter *disFilter = [[GPUImageBrightnessFilter alloc] init];
    //    [disFilter setBrightness:-0.5f];
    
    //曝光度
    //    GPUImageExposureFilter *disFilter = [[GPUImageExposureFilter alloc] init];
    //    [disFilter setExposure:1.5f];
    
    
    //    GPUImageToonFilter *disFilter = [[GPUImageToonFilter alloc] init];
    
    //褐色滤镜
    GPUImageSepiaFilter *disFilter = [[GPUImageSepiaFilter alloc] init];
    
    //设置要渲染的区域
    [disFilter forceProcessingAtSize:self.myImg.size];
    [disFilter useNextFrameForImageCapture];
    
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:self.myImg];
    
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    
    //加载出来
    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
    imageView.frame = CGRectMake(50,50,self.myImg.size.width-200 ,self.myImg.size.height-200);
    [self.view addSubview:imageView];
}

-(void)moreUse{
    
    FWNashvilleFilter *disFilter = [[FWNashvilleFilter alloc] init];
    
    //设置要渲染的区域
    [disFilter forceProcessingAtSize:self.myImg.size];
    [disFilter useNextFrameForImageCapture];
    
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:self.myImg];
    
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    
    //加载出来
    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
    imageView.frame = CGRectMake(50,50,self.myImg.size.width-200 ,self.myImg.size.height-200);
    [self.view addSubview:imageView];
}

-(void)thirdTest{
    lomoTest *disFilter = [[lomoTest alloc] init];
    
    //设置要渲染的区域
    [disFilter forceProcessingAtSize:self.myImg.size];
    [disFilter useNextFrameForImageCapture];
    
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:self.myImg];
    
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    
    //加载出来
    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
    imageView.frame = CGRectMake(50,50,self.myImg.size.width-200 ,self.myImg.size.height-200);
    [self.view addSubview:imageView];
}

-(void)forthTest{
    AmomoFilter *disFilter = [[AmomoFilter alloc] init];
    
    //设置要渲染的区域
    [disFilter forceProcessingAtSize:self.myImg.size];
    [disFilter useNextFrameForImageCapture];
    
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:self.myImg];
    
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    
    //加载出来
    UIImageView *imageView = [[UIImageView alloc] initWithImage:newImage];
    imageView.frame = CGRectMake(50,50,self.myImg.size.width-200 ,self.myImg.size.height-200);
    [self.view addSubview:imageView];
}

-(void)testVideo{
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    

    //GPUImageFilter *customFilter = [[GPUImageFilter alloc] initWithFragmentShaderFromFile:@"CustomShader"];
    self.customFilter = [[AmomoFilter alloc] init];
    GPUImageView *filteredVideoView = [[GPUImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300, 400)];

    // Add the view somewhere so it's visible
    [self.view addSubview:filteredVideoView];
    
    
    [self.videoCamera addTarget:self.customFilter];
    [self.customFilter addTarget:filteredVideoView];
    
    [self.videoCamera startCameraCapture];
}

-(void)start{
    self.pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie4.mov"];
    unlink([self.pathToMovie UTF8String]); // 如果已经存在文件，AVAssetWriter会有异常，删除旧文件
    NSURL *movieURL = [NSURL fileURLWithPath:self.pathToMovie];
    NSLog(@"%@",movieURL);
    self.movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 640.0)];
    self.movieWriter.encodingLiveVideo = YES;
    [self.customFilter addTarget:_movieWriter];
    _videoCamera.audioEncodingTarget = self.movieWriter;
    [self.movieWriter startRecording];
}

-(void)end{
    [self.customFilter removeTarget:self.movieWriter];
    _videoCamera.audioEncodingTarget = nil;
    [self.movieWriter finishRecording];
}

-(void)plays{
    NSURL *sourceMovieUrl = [NSURL fileURLWithPath:self.pathToMovie];
    NSLog(@"sourceMovieUrl：%@",sourceMovieUrl);
    NSLog(@"%@",[NSURL URLWithString:self.pathToMovie]);
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:sourceMovieUrl];
    //或者下面这样创建playerItem
    //AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieUrl options:nil];
    //AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    
    //通过playerItem创建AVPlayer
    self.playss = [AVPlayer playerWithPlayerItem:playerItem];
    //或者直接使用URL创建AVPlayer
    //self.playss = [AVPlayer playerWithURL:sourceMovieUrl];
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.playss];
    layer.frame = CGRectMake(0, 0, 400, 600);
    layer.videoGravity =AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:layer];
    [self.playss play];
}

#pragma mark --相机照相
-(void)takePhoto{
    self.stillCamera = [[GPUImageStillCamera alloc] init];
    self.stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.customFilter = [[AmomoFilter alloc] init];
    [self.stillCamera addTarget:self.customFilter];
    
    GPUImageView *filterView = [[GPUImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 400)];
    [self.view addSubview:filterView];
    [self.customFilter addTarget:filterView];
    
    [self.stillCamera startCameraCapture];
}

-(void)startPhoto{
//    [self.stillCamera capturePhotoProcessedUpToFilter:filter withCompletionHandler:^(UIImage *processedImage, NSError *error){
//        NSData *dataForJPEGFile = UIImageJPEGRepresentation(processedImage, 0.8);
//        
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        
//        NSError *error2 = nil;
//        if (![dataForJPEGFile writeToFile:[documentsDirectory stringByAppendingPathComponent:@"FilteredPhoto.jpg"] options:NSAtomicWrite error:&error2])
//        {
//            return;
//        }
//    }];
    [self.stillCamera capturePhotoAsPNGProcessedUpToFilter:self.customFilter withCompletionHandler:^(NSData *processedPNG, NSError *error) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSError *error2 = nil;
        if (![processedPNG writeToFile:[documentsDirectory stringByAppendingPathComponent:@"FilteredPhoto.png"] options:NSAtomicWrite error:&error2])
        {
            return;
        }
        //加载出来
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:processedPNG]];
        imageView.frame = CGRectMake(50,50,self.myImg.size.width-200 ,self.myImg.size.height-200);
        [self.view addSubview:imageView];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
