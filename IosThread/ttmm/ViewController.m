//
//  ViewController.m
//  ttmm
//
//  Created by Damon on 16/8/29.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *array = [[NSArray alloc] initWithObjects:@"performTest",@"NSThread",@"NSOperation",@"GCD", nil];
    self.m_check = [[UISegmentedControl alloc] initWithItems:array];
    [self.m_check addTarget:self action:@selector(startTest:) forControlEvents:UIControlEventValueChanged];
    [self.m_check setFrame:CGRectMake(10, 100, 360, 40)];
    [self.view addSubview:self.m_check];
    
}
-(void)startTest:(UISegmentedControl*) seg{
    NSInteger i = seg.selectedSegmentIndex;
    switch (i) {
        case 0:
        {
            NSLog(@"performTest");
            [self performTest];
            [self log2];
        }
            break;
        case 1:
        {
            NSLog(@"NSThread");
            [self ThreadTest];
            [self log2];
        }
            break;
        case 2:
        {
            NSLog(@"NSOperation");
            [self OperationTest];
            [self log2];
        }
            break;
        case 3:
        {
            NSLog(@"GCD");
            [self GCDTest];
            [self log2];
        }
            break;
        default:
            break;
    }
}

-(void)performTest
{
    //1.延迟多长时间执行
//    [self performSelector:@selector(log3:) withObject:@"Damon" afterDelay:2.0f];
    //2.或者下面这种带mode参数的,mode参数请看NSRunLoop详解
//    [self performSelector:@selector(log3:) withObject:@"Damon2" afterDelay:2.0f inModes:[NSArray arrayWithObject:NSDefaultRunLoopMode]];
    //3.阻塞主线程，执行完毕之后才执行后面的其他函数
    [self performSelectorOnMainThread:@selector(log3:) withObject:@"Damon" waitUntilDone:true];
    //4.后台线程执行，异步执行
    [self performSelectorInBackground:@selector(log3:) withObject:@"Hu"];
    
}

-(void)ThreadTest
{
    //1.直接类方法开启后台线程
//    [NSThread detachNewThreadSelector:@selector(log1) toTarget:self withObject:nil];
    //2.使用成员方法
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(log4:) object:@"Damon"];
    [thread1 setName:@"thread1"];//设置线程名字
    [thread1 start];//开始执行
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(log4:) object:@"Hu"];
    [thread2 setName:@"thread2"];
    [thread2 start];
    //创建线程锁
    self.m_lock = [[NSLock alloc] init];
    //3.比较常用的函数
    [NSThread currentThread];//获取当前线程
    [NSThread mainThread];//获取主线程
    
}

-(void)OperationTest
{
    //1.直接开一个线程并使用
//    NSInvocationOperation *opera = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(log3:) object:@"Damon"];
//    [opera start];
    //2.多个线程依赖
    NSOperationQueue *quene = [[NSOperationQueue alloc] init];
    NSInvocationOperation *opera1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(log3:) object:@"Damon"];//可以直接alloc
    NSBlockOperation *opera2 =[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"opera2");   //可以使用块
    }];
    NSBlockOperation *opera3 =[NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"opera3");   //可以使用块
    }];
    [opera1 addDependency:opera2];//1依赖2,所谓“依赖”关系，就是等待前一个任务完成后，后一个任务才能启动
    [opera3 addDependency:opera1];//3依赖1
    [quene addOperation:opera2];//可以新线程里面加任务
    [quene addOperation:opera1];
    [[NSOperationQueue mainQueue] addOperation:opera3];//也可以在UI主线程里面加任务
    //常用函数
    [quene setMaxConcurrentOperationCount:4];//最大并发线程数
    [quene setSuspended:YES];//暂停
    [quene cancelAllOperations];//取消所有任务
}

-(void)GCDTest
{
    //1.只执行一次,可以用来构建类的单例
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"gcd");
    });
    //2.同步线程，阻塞主线程，执行完毕之后才继续往下执行
    //global全局,queue队列,async异步,sync同步
    //获取全局队列
    dispatch_queue_t quene =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(quene, ^{
        NSLog(@"sync");
    });
    //3.异步
    dispatch_queue_t quene2 =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(quene2, ^{
        NSLog(@"async");
    });
    //在main主队列,只能同步
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"main_quene,sync");
    });
    //创建队列
    dispatch_queue_t quene3 = dispatch_queue_create("Damon", nil);
    dispatch_sync(quene3, ^{
        NSLog(@"quene3");
    });
    
    //和[self performSelector:@selector(log1) withObject:nil afterDelay:5.0f];等价
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        [self log1];
    });
    
}

-(void)log1
{
    for (int i = 0; i<100000; i++) {
        
    }
    NSLog(@"log1");
}

-(void)log2
{
    NSLog(@"log2");
}

-(void)log3:(id)obj
{
    NSLog(@"log3");
    NSLog(@"%@",obj);
}

-(void)log4:(id)obj
{
    NSLog(@"log4");
    static int  i =10;
    [self.m_lock lock];
    if (i>0) {
        i--;
    }
    [self.m_lock unlock];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
