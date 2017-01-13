//
//  InstallmentsPicker.h
//  LYGoodsDetailDemo
//
//  Created by liuyang on 17/1/11.
//  Copyright © 2017年 Mime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InstallmentsPicker : UIView
/** 数据数组dataArray */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 月供金额数据数组 */
@property (nonatomic, strong) NSMutableArray *monthlyArray;
/** 月供金额数据 */
//@property (nonatomic, strong) NSString *monthly;
- (instancetype)initWithFrame:(CGRect)frame withMonthlyArray:(NSMutableArray *)monthlyArray;
@end
