//
//  GoodsParameterCell.h
//  LYGoodsDetailDemo
//
//  Created by liuyang on 17/1/12.
//  Copyright © 2017年 Mime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsParameterCell : UITableViewCell
- (void)setParameterName:(NSString *)parameterName parameterData:(NSString *)parameterData;
- (CGFloat)cellHeight;
@end
