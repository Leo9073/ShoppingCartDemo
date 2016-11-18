//
//  ViewController.m
//  LLShoppingCartDemo
//
//  Created by Leo on 11/18/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "ViewController.h"
#import "LLWineCell.h"
#import "LLWine.h"
#import <MJExtension.h>
#import "LLShoppingCartView.h"

#define LLRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
static NSString *cellID = @"ID";


@interface ViewController () <UITableViewDelegate,UITableViewDataSource,LLShoppingCartViewDelegate,LLWineCellDelegate>

@property (strong,nonatomic) NSMutableArray *wineArray;
@property (weak,nonatomic) LLShoppingCartView *shoppingCartView;
@property (strong,nonatomic) NSMutableArray *shoppingCart;
@property (weak,nonatomic) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupShoppingCartView];
}

#pragma mark -- 懒加载
- (NSMutableArray *)wineArray {
    
    if (!_wineArray) {
        _wineArray = [LLWine mj_objectArrayWithFilename:@"wine.plist"];
    }
    return _wineArray;
}

- (NSMutableArray *)shoppingCart {
    
    if (!_shoppingCart) {
        _shoppingCart = [NSMutableArray array];
    }
    return _shoppingCart;
}

#pragma mark -- 其他方法

/**
 *  配置表视图
 */
- (void)setupTableView {
    
    CGRect rect = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height-20);
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[LLWineCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

/**
 *  配置购物车视图
 */
- (void)setupShoppingCartView {
    
    CGRect shoppingCartViewFrame = CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44);
    LLShoppingCartView *shoppingCartView = [[LLShoppingCartView alloc] initWithFrame:shoppingCartViewFrame];
    shoppingCartView.backgroundColor = [UIColor whiteColor];
    shoppingCartView.delegate = self;
    [self.view addSubview:shoppingCartView];
    self.shoppingCartView = shoppingCartView;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-45, self.view.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.3;
    [self.view addSubview:lineView];
}


#pragma mark -- UITableViewDelegate和UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.wineArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LLWineCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.wine = self.wineArray[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

#pragma mark -- LLWineCellDelegate
- (void)wineCellDidClickedPlusButton:(LLWineCell *)cell {
    
    NSUInteger totalPrice = self.shoppingCartView.totalPriceLabel.text.integerValue + cell.wine.money.integerValue;
    self.shoppingCartView.totalPriceLabel.text = [NSString stringWithFormat:@"%ld",totalPrice];
    self.shoppingCartView.buyButton.enabled = YES;
    if (![self.shoppingCart containsObject:cell.wine]) {
        [self.shoppingCart addObject:cell.wine];
    }
}

- (void)wineCellDidClickedMinusButton:(LLWineCell *)cell {
    
    NSUInteger totalPrice = self.shoppingCartView.totalPriceLabel.text.integerValue - cell.wine.money.integerValue;
    self.shoppingCartView.totalPriceLabel.text = [NSString stringWithFormat:@"%ld",totalPrice];
    self.shoppingCartView.buyButton.enabled = (totalPrice > 0);
    if (cell.wine.count == 0) {
        [self.shoppingCart removeObject:cell.wine];
    }
}


#pragma mark -- LLShoppingCartViewDelegate
- (void)buyButtonDidClicked {
    
    NSLog(@"buy");
}

- (void)clearButtonDidClicked {
    
    for (LLWine *wine in self.shoppingCart) {
        wine.count = 0;
    }
    
    //刷新表格
    [self.tableView reloadData];
    
    //总价清零
    self.shoppingCartView.totalPriceLabel.text = @"0";
    
    //清空购物车
    [self.shoppingCart removeAllObjects];
    
    //购物按钮不能点击
    self.shoppingCartView.buyButton.enabled = NO;
}

@end
