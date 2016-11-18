//
//  LLWine.h
//  LLShoppingCartDemo
//
//  Created by Leo on 11/18/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLWine : NSObject
/** 价格 */
@property (copy,nonatomic) NSString *money;
/** 名称 */
@property (copy,nonatomic) NSString *name;
/** 图片 */
@property (copy,nonatomic) NSString *image;
/** 图片 */
@property (assign,nonatomic) NSUInteger count;
@end
