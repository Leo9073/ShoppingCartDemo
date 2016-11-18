//
//  LLWineCell.m
//  LLShoppingCartDemo
//
//  Created by Leo on 11/18/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "LLWineCell.h"
#import <Masonry.h>

@interface LLWineCell ()
/** 酒的图片 */
@property (weak,nonatomic) UIImageView *wineImageView;
/** 酒的简介 */
@property (weak,nonatomic) UILabel *wineLabel;
/** 酒的价格 */
@property (weak,nonatomic) UILabel *winePriceLabel;
/** 酒的减少 */
@property (weak,nonatomic) UIButton *minusButton;
/** 酒的数量 */
@property (weak,nonatomic) UILabel *wineCountLabel;
/** 酒的增加 */
@property (weak,nonatomic) UIButton *plusButton;
@end

@implementation LLWineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

/**
 *  配置模型
 *
 *  @param wine 模型参数
 */
- (void)setWine:(LLWine *)wine {
    
    _wine = wine;
    self.wineImageView.image = [UIImage imageNamed:wine.image];
    self.wineLabel.text = wine.name;
    self.winePriceLabel.text = wine.money;
    self.wineCountLabel.text = [NSString stringWithFormat:@"%ld",wine.count];
    
    self.minusButton.enabled = (wine.count > 0);
}

/**
 *  配置子视图
 */
- (void)setupSubviews {
    
    UIImageView *wineImageView = [[UIImageView alloc] init];
    [self addSubview:wineImageView];
    self.wineImageView = wineImageView;
    
    UILabel *wineLabel = [[UILabel alloc] init];
    wineLabel.font = [UIFont systemFontOfSize:13];
    wineLabel.numberOfLines = 0;
    [self addSubview:wineLabel];
    self.wineLabel = wineLabel;
    
    UILabel *winePriceLabel = [[UILabel alloc] init];
    winePriceLabel.font = [UIFont systemFontOfSize:13];
    winePriceLabel.textColor = [UIColor orangeColor];
    [self addSubview:winePriceLabel];
    self.winePriceLabel = winePriceLabel;
    
    UIButton *minusButton = [UIButton buttonWithType:UIButtonTypeSystem];
    minusButton.layer.cornerRadius = 15.0;
    minusButton.layer.borderWidth = 1.0;
    minusButton.layer.borderColor = [UIColor cyanColor].CGColor;
    [minusButton setTitle:@"-" forState:UIControlStateNormal];
//    [minusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [minusButton addTarget:self action:@selector(minusButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:minusButton];
    self.minusButton = minusButton;
    
    UILabel *wineCountLabel = [[UILabel alloc] init];
    wineCountLabel.font = [UIFont systemFontOfSize:13];
    wineCountLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:wineCountLabel];
    self.wineCountLabel = wineCountLabel;
    
    UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeSystem];
    plusButton.layer.cornerRadius = 15.0;
    plusButton.layer.borderWidth = 1.0;
    plusButton.layer.borderColor = [UIColor cyanColor].CGColor;
    [plusButton setTitle:@"+" forState:UIControlStateNormal];
//    [plusButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [plusButton addTarget:self action:@selector(plusButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:plusButton];
    self.plusButton = plusButton;
}

/**
 *  布局子视图
 */
- (void)layoutSubviews {
    
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    [self.wineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf).offset(10);
        make.bottom.equalTo(weakSelf).offset(-10);
        make.width.equalTo(@(50));
    }];
    
    [self.wineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(10);
        make.left.equalTo(self.wineImageView.mas_right).offset(5);
        make.height.equalTo(weakSelf).multipliedBy(0.5);
        make.width.equalTo(weakSelf).multipliedBy(0.5);
    }];
    
    [self.winePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wineLabel.mas_bottom).offset(5);
        make.left.equalTo(self.wineImageView.mas_right).offset(5);
        make.height.equalTo(weakSelf).multipliedBy(0.2);
        make.width.equalTo(weakSelf).multipliedBy(0.1);
//        make.bottom.equalTo(weakSelf).offset(-5);
    }];
    
    [self.plusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(20);
        make.right.equalTo(weakSelf).offset(-10);
        make.bottom.equalTo(weakSelf).offset(-20);
        make.width.equalTo(@(30));
    }];
    
    [self.wineCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(20);
        make.bottom.equalTo(weakSelf).offset(-20);
        make.right.equalTo(self.plusButton.mas_left).offset(-5);
        make.width.equalTo(@(25));
    }];
    
    [self.minusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(20);
        make.bottom.equalTo(weakSelf).offset(-20);
        make.right.equalTo(self.wineCountLabel.mas_left).offset(-5);
        make.width.equalTo(@(30));
    }];
}

/**
 *  减号按钮点击事件
 */
- (void)minusButtonClicked {
    
    self.wine.count--;
    
    self.wineCountLabel.text = [NSString stringWithFormat:@"%ld",self.wine.count];
    if (self.wine.count == 0) {
        self.minusButton.enabled = NO;
//        self.minusButton.hidden = YES;
//        self.wineCountLabel.hidden = YES;
    }
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(wineCellDidClickedMinusButton:)]) {
        [self.delegate wineCellDidClickedMinusButton:self];
    }
}

/**
 *  加号按钮点击事件
 */
- (void)plusButtonClicked {
    
    self.wine.count++;
    
    self.wineCountLabel.text = [NSString stringWithFormat:@"%ld",self.wine.count];
    
    self.minusButton.enabled = YES;
//    self.minusButton.hidden = NO;
//    self.wineCountLabel.hidden = NO;
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(wineCellDidClickedPlusButton:)]) {
        [self.delegate wineCellDidClickedPlusButton:self];
    }
}

@end
