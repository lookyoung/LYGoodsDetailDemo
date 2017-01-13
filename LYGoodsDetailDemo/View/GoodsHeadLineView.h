//
//  GoodsHeadLineView.h
//  LYGoodsDetailDemo
//
//  Created by liuyang on 17/1/12.
//  Copyright © 2017年 Mime. All rights reserved.
//
/** 【 商品详情 | 规格参数 | 购买说明 】 横标栏*/
#import <UIKit/UIKit.h>

@protocol GoodsHeadLineViewDelegate <NSObject>

@required
- (void)refreshHeadLine:(NSInteger)currentIndex;

@end

@interface GoodsHeadLineView : UIView
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSArray * titleArray;
@property (nonatomic,weak) id<GoodsHeadLineViewDelegate> delegate;


@end
