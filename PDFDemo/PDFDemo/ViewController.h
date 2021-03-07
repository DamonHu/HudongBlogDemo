//
//  ViewController.h
//  PDFDemo
//
//  Created by damon on 2017/2/6.
//  Copyright © 2017年 damon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFService.h"

@interface ViewController : UIViewController<PDFServiceDelegate>

@property (strong,nonatomic)NSString *m_filePath;
@end

