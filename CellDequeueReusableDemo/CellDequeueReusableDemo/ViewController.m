//
//  ViewController.m
//  CellDequeueReusableDemo
//
//  Created by Damon on 2017/11/24.
//  Copyright © 2017年 damon. All rights reserved.
//

#import "ViewController.h"
#import "ItemModel.h"
#import "TableViewCellImgLeft.h"
#import "TableViewCellImgRight.h"
#import "TableViewCellNoImg.h"
#import "Masonry.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
}

-(void)initData{
    _dataArray = [NSMutableArray array];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                         @"纪念日记本",@"itemTitle",
                         @"文具手账小清新便携空白本",@"itemDetail",
                         @"￥15",@"price",
                         @"pic_rjb",@"image",
                         @"",@"payUrl",
                         @(ItemTypeLeftImg),@"itemType",
                         nil];
    ItemModel *itemModel = [[ItemModel alloc] initWithDictionary:dic];
    NSDictionary *dic1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                         @"没有介绍",@"itemTitle",
                         @"￥15",@"price",
                         @"pic_rjb",@"image",
                         @"",@"payUrl",
                         @(ItemTypeLeftImg),@"itemType",
                         nil];
    ItemModel *itemModel1 = [[ItemModel alloc] initWithDictionary:dic1];
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"明信片",@"itemTitle",
                          @"diy包邮信文艺告白明信片",@"itemDetail",
                          @"￥1",@"price",
                          @"pic_mxp",@"image",
                          @"",@"payUrl",
                          @(ItemTypeRightImg),@"itemType",
                          nil];
    ItemModel *itemModel2 = [[ItemModel alloc] initWithDictionary:dic2];
    NSDictionary *dic3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          @"玩偶抱枕",@"itemTitle",
                          @"玩偶抱枕diy包邮",@"itemDetail",
                          @"￥100",@"price",
                          @"",@"payUrl",
                          @(ItemTypeNoImg),@"itemType",
                          nil];
    ItemModel *itemModel3 = [[ItemModel alloc] initWithDictionary:dic3];
    for (int i =0; i<10; i++) {
        [_dataArray addObject:itemModel];
        [_dataArray addObject:itemModel1];
        [_dataArray addObject:itemModel2];
        [_dataArray addObject:itemModel3];
        
        [_dataArray addObject:itemModel3];
        [_dataArray addObject:itemModel2];
        [_dataArray addObject:itemModel];
        
        [_dataArray addObject:itemModel];
        [_dataArray addObject:itemModel2];
        [_dataArray addObject:itemModel2];
        
        [_dataArray addObject:itemModel3];
        [_dataArray addObject:itemModel2];
        [_dataArray addObject:itemModel3];
    }
}

-(void)createUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _tableView.scrollsToTop = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ItemLeftImg";
    static NSString *identifier2 = @"ItemRightImg";
    static NSString *identifier3 = @"ItemNoImg";
    UITableViewCell *cell;
    switch (((ItemModel *)[_dataArray objectAtIndex:indexPath.row]).itemType) {
        case ItemTypeLeftImg:
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[TableViewCellImgLeft alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            [(TableViewCellImgLeft*)cell configWithModel:[_dataArray objectAtIndex:indexPath.row]];
            break;
        case ItemTypeRightImg:
            cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
            if (!cell) {
                cell = [[TableViewCellImgRight alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            [(TableViewCellImgRight*)cell configWithModel:[_dataArray objectAtIndex:indexPath.row]];
            break;
        case ItemTypeNoImg:
            cell = [tableView dequeueReusableCellWithIdentifier:identifier3];
            if (!cell) {
                cell = [[TableViewCellNoImg alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier3];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            [(TableViewCellNoImg*)cell configWithModel:[_dataArray objectAtIndex:indexPath.row]];
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
