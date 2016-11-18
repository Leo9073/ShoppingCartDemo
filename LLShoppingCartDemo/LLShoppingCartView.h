//
//  LLShoppingCartView.h
//  LLShoppingCartDemo
//
//  Created by Leo on 11/18/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLShoppingCartViewDelegate <NSObject>
@optional
- (void)buyButtonDidClicked;
- (void)clearButtonDidClicked;
@end

@interface LLShoppingCartView : UIView
/** 物品总价 */
@property (weak,nonatomic) UILabel *totalPriceLabel;
/** 购买按钮 */
@property (weak,nonatomic) UIButton *buyButton;
/** 清空按钮 */
@property (weak,nonatomic) UIButton *clearButton;

@property (weak,nonatomic) id<LLShoppingCartViewDelegate> delegate;
@end
