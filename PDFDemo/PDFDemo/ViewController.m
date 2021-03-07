//
//  ViewController.m
//  PDFDemo
//
//  Created by damon on 2017/2/6.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 100, 40)];
    [label setText:@"pdf测试"];
    [label setTextColor:[UIColor redColor]];
    [self.view addSubview:label];
    
    
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 160, 100, 40)];
    [btn1 setTitle:@"creatPDF" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(creatPDF) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 220, 100, 40)];
    [btn2 setTitle:@"getPDF" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(getPDF) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(10, 280, 100, 40)];
    [btn3 setTitle:@"sharePDF" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(sharePDF) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];

}

-(void)creatPDF{
    NSLog(@"creatPDF");
    
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    self.m_filePath = [path stringByAppendingPathComponent:@"test.pdf"];
    NSLog(@"path: %@",path);
    PDFService *service = [PDFService instance];
    service.delegate = self;
    [service createPDFFile:self.m_filePath];
}

-(void)getPDF{
    NSLog(@"getPDF");

    NSURL *url = [NSURL fileURLWithPath:self.m_filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(10, 300, 300, 300)];
    [self.view addSubview:web];
    [web loadRequest:request];
}

-(void)sharePDF{
    NSLog(@"需要注意pdf文件是否存在，这里是需要先creatPDF生成文件,否则会抛出NSInternalInconsistencyException异常");
    UIDocumentInteractionController *documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:self.m_filePath]];
//    documentController.delegate = self;
    
    documentController.UTI = @"com.adobe.pdf";
    [documentController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
}

#pragma mark -
#pragma mark delegate method


- (void)service:(PDFService *)service
didFailedCreatingPDFFile:(NSString *)filePath
        errorNo:(HPDF_STATUS)errorNo
       detailNo:(HPDF_STATUS)detailNo
{
    NSString *message = [NSString stringWithFormat:@"Couldn't create a PDF file at %@\n errorNo:0x%04x detalNo:0x%04x",
                         filePath,
                         errorNo,
                         detailNo];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"PDF creation error"
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
