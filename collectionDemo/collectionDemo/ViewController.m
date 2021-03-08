//
//  ViewController.m
//  collectionDemo
//
//  Created by Damon on 16/8/10.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

#define CELL_INDI @"cellIndi"
#define HEADER_INDI @"headerId"
#define FOOTER_INDI @"footerId"

- (void)viewDidLoad {
    [super viewDidLoad];

    self.myArray = [NSMutableArray arrayWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
    //定义flowLayout
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    //可选定义item的其他选项，在UICollectionViewFlowLayout类里面，也可以在代理中单独指定
    flowLayout.itemSize = CGSizeMake(100, 100);
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    flowLayout.headerReferenceSize = CGSizeMake(100, 100);
    flowLayout.footerReferenceSize = CGSizeMake(100, 100);
    
    
    self.myCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
    self.myCollection.delegate = self;
    self.myCollection.dataSource = self;
    [self.myCollection setBackgroundColor:[UIColor redColor]];
    
    //注册cell
    [self.myCollection registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:CELL_INDI];
    
    //注册sectionHeader和footer，以调用- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
    [self.myCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_INDI];
    [self.myCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTER_INDI];
    
    
    [self.view addSubview:self.myCollection];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
         return self.myArray.count;
    }
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_INDI forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

//和UITableView类似，UICollectionView也可设置段头段尾，设置头和尾的大小才会调用这个函数
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [self.myCollection dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HEADER_INDI forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor whiteColor];
        
        return headerView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *footerView = [self.myCollection dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FOOTER_INDI forIndexPath:indexPath];
        if(footerView == nil)
        {
            footerView = [[UICollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor blackColor];
        
        return footerView;
    }
    
    return nil;
}
//下面这两个函数ios9.0不能用
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
   // 指定第一个不让移动，其他的让移动
    if (indexPath.row ==0) {
        return false;
    }
    else
        return true;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    //哪个item移动了
    NSLog(@"%ld,%ld",(long)sourceIndexPath.row,(long)sourceIndexPath.section);
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //自定义item大小
    if (indexPath.section == 1 && indexPath.row == 1) {
        return CGSizeMake(20, 20);
    }
    else
        return CGSizeMake(100, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //自定义item的UIEdgeInsets
    if (section == 1) {
        return  UIEdgeInsetsMake(90, 90, 90, 90);
    }
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

/*  其他的自定义，和上面一样，只需要返回值就可以了
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
}
*/

#pragma mark - UICollectionViewDelegate
//是否高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return true;
}
// 点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
}

//选择的哪个
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld,%ld",(long)indexPath.row,(long)indexPath.section);
}

//不选择哪个了，就变成原来的颜色
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
}

//当松开鼠标的时候会调用
//- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor blueColor];
//}
//下面这三个函数是长按之后，显示剪切，复制，粘贴按钮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return true;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    return true;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
    //打印操作名称
    NSLog(@"%@",NSStringFromSelector(action));
    //删除操作
//    [collectionView performBatchUpdates:^{
//         [collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
//    } completion:nil];
    //或者这样  注意，删除的这个indexpath的item数必须要同步更新，并且不能影响其他section的item数，所以最好就是删除的这个单独写一个数组。否则删除会直接报错，插入也是
    //删除
    if ([NSStringFromSelector(action) isEqualToString:@"cut:"]) {
        if (indexPath.section == 0) {
            [self.myArray removeObjectAtIndex:indexPath.row];
            [collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        }
    }
    //插入
    if ([NSStringFromSelector(action) isEqualToString:@"copy:"]) {
        if (indexPath.section == 0) {
            [self.myArray addObject:@"1"];
            [collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
