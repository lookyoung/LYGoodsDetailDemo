//
//  GoodsDetailView.h
//  LYGoodsDetailDemo
//
//  Created by liuyang on 17/1/12.
//  Copyright © 2017年 Mime. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GoodsDetailViewDelegate <NSObject>

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end

@interface GoodsDetailView : UIView
/** 商品详情-规格参数 */
@property (nonatomic, copy) NSDictionary *paramsDictionary;
/** 商品详情-图片列表 */
@property (nonatomic, copy) NSArray *detailImageUrlList;
/** 商品详情-购买说明图片 */
@property (nonatomic, copy) NSString *buyInfoImageUrl;
/** 购买说明里的商户名称 */
@property (nonatomic, strong) NSString *shopName;
/** 购买说明里的商户描述 */
@property (nonatomic, strong) NSString *shopProfile;
/** delegate */
@property (nonatomic, weak) id<GoodsDetailViewDelegate> delegate;
@end
