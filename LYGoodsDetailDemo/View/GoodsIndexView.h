//
//  GoodsIndexView.h
//  LYGoodsDetailDemo
//
//  Created by liuyang on 17/1/12.
//  Copyright © 2017年 Mime. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, GoodsIndexStyle) {
    GoodsIndexStyleCoupon,      // 领优惠券
    GoodsIndexStyleSpecify,     // 选择规格
    GoodsIndexStyleDistribute   // 物流配送
};

// 配送范围
#define GoodsLogisticsRangeContentName @"GoodsLogisticsRangeContentName"
// 配送运费
#define GoodsLogisticsMoneyContentName @"GoodsLogisticsMoneyContentName"
// 规格参数
#define GoodsParamsAttrsContentName @"GoodsParamsAttrsContentName"

@class GoodsIndexView;
@protocol GoodsIndexViewDelegate <NSObject>

@required
- (void)GoodsIndexView:(GoodsIndexView *)goodsIndexView didSelectedAtIndexStyle:(GoodsIndexStyle)style;

@end

@interface GoodsIndexView : UIView
/** delegate */
@property (nonatomic, weak) id<GoodsIndexViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame goodsIndexStyle:(GoodsIndexStyle)style;
/** 重设content内容 */
- (void)resetContentDictionary:(NSDictionary<NSString *, id> *)dic;
@end
