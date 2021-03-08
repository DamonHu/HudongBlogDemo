//
//  ViewController.h
//  collectionDemo
//
//  Created by Damon on 16/8/10.
//  Copyright © 2016年 Damon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UICollectionView * myCollection;
@property(strong,nonatomic)NSMutableArray * myArray;

@end

