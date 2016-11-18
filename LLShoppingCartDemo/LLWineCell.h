//
//  LLWineCell.h
//  LLShoppingCartDemo
//
//  Created by Leo on 11/18/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLWine.h"
@class LLWineCell;

@protocol LLWineCellDelegate <NSObject>
@optional
- (void)wineCellDidClickedPlusButton:(LLWineCell *)cell;
- (void)wineCellDidClickedMinusButton:(LLWineCell *)cell;
@end

@interface LLWineCell : UITableViewCell
@property (strong,nonatomic) LLWine *wine;
@property (weak,nonatomic) id<LLWineCellDelegate> delegate;
@end
