## 原文链接

[IOS视图的碰撞检测](http://www.hudongdong.com/ios/518.html)

## 一、IOS的碰撞检测
游戏中经常会出现主角和怪物的碰撞检测，今天看了下ios，发现也提供了碰撞检测的方案。
IOS中的碰撞检测主要是调用View中的这个方法，判断一个点是否在某个view的区域内

```
- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event; // default returns YES if point is in bounds
```
类似于游戏的本地坐标系和世界坐标系，ios中的坐标在不同的父类view中也是不相同的，所以判断之前可以调用这几个转换函数来转换成自己需要的坐标系。

<!--more-->

### 1.1、坐标转换函数
假如是aView进行调用此方法：

```
//将相对于aView的点point转化为相对于view坐标系的点，并返回
- (CGPoint)convertPoint:(CGPoint)point toView:(nullable UIView *)view;

//将点从view中转换至 aview中并返回一个相对于aView的坐标点
- (CGPoint)convertPoint:(CGPoint)point fromView:(nullable UIView *)view;

//将相对于view的rect转化为相对于view坐标系的rect，并返回一个rect值
- (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;

//将点从aView转换至view中并返回一个相对于aView的尺寸
- (CGRect)convertRect:(CGRect)rect fromView:(nullable UIView *)view;
```

## 二、代码示例

### 2.1、点击的检测

这里在self.view中添加一个imageview，来查看是否点击

```
imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
[imageView setImage:[UIImage imageNamed:@"launchImg"]];
[self.view addSubview:imageView];
```

然后根据点击的坐标，来判断是否点击在imageView中

```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{    
    if ([imageView pointInside:[touches.anyObject locationInView:imageView] withEvent:event]) {
        NSLog(@"点击了图块");
        [tiplabel setText:@"点击了图块"];
    }
    else{
        NSLog(@"没有点击");
        [tiplabel setText:@"没有点击"];
    }
}
```
### 2.2、视图与视图的碰撞检测

先添加一个滚动视图scrollview，然后在scrollview滚动视图中添加一个可移动的滑块

```
UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 250, 50, 250)];
[scrollview setBackgroundColor:[UIColor lightGrayColor]];
scrollview.delegate = self;
[scrollview setContentSize:CGSizeMake(40, 600)];
[self.view addSubview:scrollview];
    
imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 50, 50)];
[imageView2 setImage:[UIImage imageNamed:@"launchImg"]];
[scrollview addSubview:imageView2];
```

然后在view中添加一个视图

```
imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300, 200, 2)];
[imageView3 setImage:[UIImage imageNamed:@"launchImg"]];
[self.view addSubview:imageView3];
```
然后当scrollview滚动时，来检测scrollview中的滑块是否和view视图中的那个横线碰撞了

```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([imageView2 pointInside:[imageView3 convertPoint:imageView3.bounds.origin toView:imageView2] withEvent:nil]) 	{
        [tiplabel setText:@"碰撞了"];
    }
    else{
        [tiplabel setText:@"没有碰撞"];
    }
}
```
注意，因为imageview的锚点是在(0,0)处，所以如果你视图太大，那么只有当两个视图的顶部接触时才会显示检测到了碰撞，解决方案可以设置锚点位置或者设置point的大小范围解决

### 2.3、效果展示

![](## 一、IOS的碰撞检测
游戏中经常会出现主角和怪物的碰撞检测，今天看了下ios，发现也提供了碰撞检测的方案。
IOS中的碰撞检测主要是调用View中的这个方法，判断一个点是否在某个view的区域内

```
- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event; // default returns YES if point is in bounds
```
类似于游戏的本地坐标系和世界坐标系，ios中的坐标在不同的父类view中也是不相同的，所以判断之前可以调用这几个转换函数来转换成自己需要的坐标系。

<!--more-->

### 1.1、坐标转换函数
假如是aView进行调用此方法：

```
//将相对于aView的点point转化为相对于view坐标系的点，并返回
- (CGPoint)convertPoint:(CGPoint)point toView:(nullable UIView *)view;

//将点从view中转换至 aview中并返回一个相对于aView的坐标点
- (CGPoint)convertPoint:(CGPoint)point fromView:(nullable UIView *)view;

//将相对于view的rect转化为相对于view坐标系的rect，并返回一个rect值
- (CGRect)convertRect:(CGRect)rect toView:(nullable UIView *)view;

//将点从aView转换至view中并返回一个相对于aView的尺寸
- (CGRect)convertRect:(CGRect)rect fromView:(nullable UIView *)view;
```

## 二、代码示例

### 2.1、点击的检测

这里在self.view中添加一个imageview，来查看是否点击

```
imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
[imageView setImage:[UIImage imageNamed:@"launchImg"]];
[self.view addSubview:imageView];
```

然后根据点击的坐标，来判断是否点击在imageView中

```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{    
    if ([imageView pointInside:[touches.anyObject locationInView:imageView] withEvent:event]) {
        NSLog(@"点击了图块");
        [tiplabel setText:@"点击了图块"];
    }
    else{
        NSLog(@"没有点击");
        [tiplabel setText:@"没有点击"];
    }
}
```
### 2.2、视图与视图的碰撞检测

先添加一个滚动视图scrollview，然后在scrollview滚动视图中添加一个可移动的滑块

```
UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 250, 50, 250)];
[scrollview setBackgroundColor:[UIColor lightGrayColor]];
scrollview.delegate = self;
[scrollview setContentSize:CGSizeMake(40, 600)];
[self.view addSubview:scrollview];
    
imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 50, 50)];
[imageView2 setImage:[UIImage imageNamed:@"launchImg"]];
[scrollview addSubview:imageView2];
```

然后在view中添加一个视图

```
imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300, 200, 2)];
[imageView3 setImage:[UIImage imageNamed:@"launchImg"]];
[self.view addSubview:imageView3];
```
然后当scrollview滚动时，来检测scrollview中的滑块是否和view视图中的那个横线碰撞了

```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([imageView2 pointInside:[imageView3 convertPoint:imageView3.bounds.origin toView:imageView2] withEvent:nil]) 	{
        [tiplabel setText:@"碰撞了"];
    }
    else{
        [tiplabel setText:@"没有碰撞"];
    }
}
```
注意，因为imageview的锚点是在(0,0)处，所以如果你视图太大，那么只有当两个视图的顶部接触时才会显示检测到了碰撞，解决方案可以设置锚点位置或者设置point的大小范围解决

### 2.3、效果展示

![](http://cdn.hudongdong.com/2017-3-21-09-30.gif)

## 三、demo下载
Github下载：[https://github.com/DamonHu/HitTestDemo](https://github.com/DamonHu/HitTestDemo)

Gitosc下载：[http://git.oschina.net/DamonHoo/HitTestDemo](http://git.oschina.net/DamonHoo/HitTestDemo))

## 三、demo下载
Github下载：[https://github.com/DamonHu/HitTestDemo](https://github.com/DamonHu/HitTestDemo)

Gitosc下载：[http://git.oschina.net/DamonHoo/HitTestDemo](http://git.oschina.net/DamonHoo/HitTestDemo)
