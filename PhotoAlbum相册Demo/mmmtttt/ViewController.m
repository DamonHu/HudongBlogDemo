//
//  ViewController.m
//  mmmtttt
//
//  Created by Damon on 2017/7/7.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "ViewController.h"
#import "PhotoAlbums.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(taaaaa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)taaaaa{
    [PhotoAlbums photoMultiSelectWithMaxImagesCount:1 delegate:nil didFinishPhotoBlock:^(NSArray<UIImage *> *photos) {
        NSLog(@"%@",photos);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
