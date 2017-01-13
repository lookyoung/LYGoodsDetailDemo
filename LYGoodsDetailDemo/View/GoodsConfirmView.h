//
//  GoodsConfirmView.h
//  LYGoodsDetailDemo
//
//  Created by liuyang on 17/1/12.
//  Copyright © 2017年 Mime. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsConfirmView;
@protocol GoodsConfirmViewDelegate <NSObject>

@required
- (void)goodsConfirmView:(GoodsConfirmView *)goodsConfirmView confirmClick:(id)sender;

- (void)goodsConfirmView:(GoodsConfirmView *)goodsConfirmView fenqiSelectClick:(id)sender;

@end

@interface GoodsConfirmView : UIView
/** delegate */
@property (nonatomic, weak) id<GoodsConfirmViewDelegate> delegate;
/** 重设分期数和月供金额 */
- (void)reSetFenqiNum:(NSString *)fenqiNum andYuegong:(NSString *)yuegong;
@end

