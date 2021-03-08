下午说了他最基础的使用方法，现在说一下详细的使用方法，通过自定义cell，来实现个性化点的UICollectionView

## 项目Demo下载  

GitHub下载地址：[https://github.com/DamonHu/HudongBlogDemo/tree/master/collectionDemo](https://github.com/DamonHu/HudongBlogDemo/tree/master/collectionDemo)


## 项目说明  

### 1、通过自定义cell来实现自己的UICollectionView中一个一个的item

建立一个MyCollectionViewCell类，这个类就是自定义的，简单的实现方法

MyCollectionViewCell.h文件

```
#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell

@property (strong,nonatomic) UILabel* myLabel;
@property (strong,nonatomic) UIImageView *myImgView;
@end
```

MyCollectionViewCell.m文件  

```
#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

//重写初始化方法
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self setCellImage:@"demo.jpg"];
        [self.contentView addSubview:self.myImgView];
        self.myLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 70, 40)];
        [self setCellLabelText:@"demo"];
        [self.contentView addSubview:self.myLabel];
        //可以设置圆角
        self.layer.cornerRadius = 30;
    }
    return self;
}

//更改图片
-(void)setCellImage:(NSString*)ImgName
{
    [self.myImgView setImage:[UIImage imageNamed:ImgName]];
}

//更改文字
-(void)setCellLabelText:(NSString*)text
{
    [self.myLabel setText:text];
}

@end
```

这个类主要就是图片和文字，并且设置成圆角的cell，更多个性化需要自己来写

### 2、使用这个cell来定义UICollectionView

在ViewController中加载  

ViewController.h文件，这个文件就是声明一个CollectionView和暂存数据的一个可变数组Array  

```

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UICollectionView * myCollection;
@property(strong,nonatomic)NSMutableArray * myArray;

@end
```

ViewController.m文件  

```
- (void)viewDidLoad {
    [super viewDidLoad];

    self.myArray = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
    //定义flowLayout
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //可选定义item的其他选项，在UICollectionViewFlowLayout类里面，也可以在代理中单独指定
    flowLayout.itemSize = CGSizeMake(100, 100);
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    flowLayout.headerReferenceSize = CGSizeMake(100, 100);
    flowLayout.footerReferenceSize = CGSizeMake(100, 100);
    
    
    self.myCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
    self.myCollection.delegate = self;
    self.myCollection.dataSource = self;
    [self.myCollection setBackgroundColor:[UIColor redColor]];
    
    //注册cell
    [self.myCollection registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:CELL_INDI];
    
    //注册sectionHeader和footer，以调用- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
    [self.myCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_INDI];
    [self.myCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTER_INDI];
    
    
    [self.view addSubview:self.myCollection];
    
}
```

在ViewDidLoad中，把这个collectionView加载到视图中，其中flowLayout是定义的一个一个item的排列顺序，跳转类进去可以看到它有这几个参数

```
@property (nonatomic) CGFloat minimumLineSpacing;
@property (nonatomic) CGFloat minimumInteritemSpacing;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGSize estimatedItemSize NS_AVAILABLE_IOS(8_0); // defaults to CGSizeZero - setting a non-zero size enables cells that self-size via -preferredLayoutAttributesFittingAttributes:
@property (nonatomic) UICollectionViewScrollDirection scrollDirection; // default is UICollectionViewScrollDirectionVertical
@property (nonatomic) CGSize headerReferenceSize;
@property (nonatomic) CGSize footerReferenceSize;
@property (nonatomic) UIEdgeInsets sectionInset;
```

这几个参数都是可以用来微调Cell的大小、样式、排列方式的，当然，如果是要通用的样式，那么直接修改这几个参数就可以了，如果是要根据不同的Section和row来实现一个collectionView不同的cell的样式不同的话，需要把这个类加上UICollectionViewDelegateFlowLayout这个代理，

### 3、通过代理方法来个性化样式

他的代理方法可以按照demo中的个性话设置。在UICollectionViewDelegateFlowLayout代理方法中。

通过实现它的代理方式，来分不同的section和row来个性话，就像下面这样，几乎他的每一个参数都可以在代理中个性话定制。

```
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //自定义item大小
    if (indexPath.section == 1 && indexPath.row == 1) {
        return CGSizeMake(20, 20);
    }
    else
        return CGSizeMake(100, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //自定义item的UIEdgeInsets
    if (section == 1) {
        return  UIEdgeInsetsMake(90, 90, 90, 90);
    }
    return UIEdgeInsetsMake(20, 20, 20, 20);
}
```

UICollectionViewDataSource是定义cell的样式，和tableview一样

```
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
         return self.myArray.count;
    }
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_INDI forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

//和UITableView类似，UICollectionView也可设置段头段尾，设置头和尾的大小才会调用这个函数
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [self.myCollection dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HEADER_INDI forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor whiteColor];
        
        return headerView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *footerView = [self.myCollection dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FOOTER_INDI forIndexPath:indexPath];
        if(footerView == nil)
        {
            footerView = [[UICollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor blackColor];
        
        return footerView;
    }
    
    return nil;
}
//下面这两个函数ios9.0不能用
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
   // 指定第一个不让移动，其他的让移动
    if (indexPath.row ==0) {
        return false;
    }
    else
        return true;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    //哪个item移动了
    NSLog(@"%ld,%ld",(long)sourceIndexPath.row,(long)sourceIndexPath.section);
}
```

在UICollectionViewDelegate可以控制逻辑等，比如高亮，剪切等

```
#pragma mark - UICollectionViewDelegate
//是否高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return true;
}
// 点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
}

//选择的哪个
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld,%ld",(long)indexPath.row,(long)indexPath.section);
}

//不选择哪个了，就变成原来的颜色
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
}

//当松开鼠标的时候会调用
//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
//}
//下面这三个函数是长按之后，显示剪切，复制，粘贴按钮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return true;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    return true;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    //打印操作名称
    NSLog(@"%@",NSStringFromSelector(action));
    //删除操作
//    [collectionView performBatchUpdates:^{
//         [collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
//    } completion:nil];
    //或者这样  注意，删除的这个indexpath的item数必须要同步更新，并且不能影响其他section的item数，所以最好就是删除的这个单独写一个数组。否则删除会直接报错，插入也是
    //删除
    if ([NSStringFromSelector(action) isEqualToString:@"cut:"]) {
        if (indexPath.section == 0) {
            [self.myArray removeObjectAtIndex:indexPath.row];
            [collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        }
    }
    //插入
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"]) {
        if (indexPath.section == 0) {
            [self.myArray addObject:@"1"];
            [collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        }
    }
}
```

然后即可达到这种显示效果：  

![](/ueditor/php/upload/image/20160810/1470831435359315.gif)

  

## 参考文章

* [UICollectionView（一）——整体总结](http://www.jianshu.com/p/c59a5c92f859)
* [自定义Collection View布局](http://www.cocoachina.com/industry/20131122/7401.html)
* [纯代码创建UICollectionView步骤以及简单使用](http://www.jianshu.com/p/16c9d466f88c#)