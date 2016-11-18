//
//  LLShoppingCartView.m
//  LLShoppingCartDemo
//
//  Created by Leo on 11/18/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "LLShoppingCartView.h"
#import <Masonry.h>

@interface LLShoppingCartView ()
/** 总价 */
@property (weak,nonatomic) UILabel *label;
/** RMB符号 */
@property (weak,nonatomic) UILabel *RMBLabel;
@end

@implementation LLShoppingCartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubviews];
    }
    return self;
}

/**
 *  配置子视图
 */
- (void)configSubviews {
    
    UILabel *label  = [[UILabel alloc] init];
    label.text = @"总价:";
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    UILabel *RMBLabel  = [[UILabel alloc] init];
    RMBLabel.text = @"¥";
    RMBLabel.textAlignment = NSTextAlignmentCenter;
    RMBLabel.textColor = [UIColor orangeColor];
    [self addSubview:RMBLabel];
    self.RMBLabel = RMBLabel;
    
    UILabel *totalPriceLabel = [[UILabel alloc] init];
    totalPriceLabel.textAlignment = NSTextAlignmentCenter;
    totalPriceLabel.text = @"0";
    totalPriceLabel.textColor = [UIColor orangeColor];
    [self addSubview:totalPriceLabel];
    self.totalPriceLabel = totalPriceLabel;
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [buyButton setTitle:@"购买" forState:UIControlStateNormal];
    [buyButton addTarget:self action:@selector(buyButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    buyButton.enabled = NO;
    [self addSubview:buyButton];
    self.buyButton = buyButton;
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [clearButton setTitle:@"清空购物车" forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clearButton];
    self.clearButton = clearButton;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf).offset(10);
        make.bottom.equalTo(weakSelf).offset(-10);
    }];
    
    [self.RMBLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(10);
        make.bottom.equalTo(weakSelf).offset(-10);
        make.left.equalTo(self.label.mas_right).offset(5);
    }];
    
    [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(10);
        make.bottom.equalTo(weakSelf).offset(-10);
        make.left.equalTo(self.RMBLabel.mas_right).offset(5);
    }];
    
    [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(10);
        make.bottom.equalTo(weakSelf).offset(-10);
        make.right.equalTo(weakSelf).offset(-10);
    }];
    
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(10);
        make.bottom.equalTo(weakSelf).offset(-10);
        make.right.equalTo(self.clearButton.mas_left).offset(-5);
    }];
}

/**
 *  购买按钮点击事件
 */
- (void)buyButtonClicked {
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(buyButtonDidClicked)]) {
        [self.delegate buyButtonDidClicked];
    }
}

/**
 *  清空按钮点击事件
 */
- (void)clearButtonClicked {
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(clearButtonDidClicked)]) {
        [self.delegate clearButtonDidClicked];
    }
}


@end
