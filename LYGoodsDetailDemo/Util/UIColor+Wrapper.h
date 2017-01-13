//
//  UIColor+Wrapper.h
//  Memedai
//
//  Created by Jerry.li on 15/12/22.
//  Copyright © 2015年 memedai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Wrapper)

/**
 *  十六进制颜色码转换成iOS可用的RGB
 *
 *  @param hexColorString 十六进制颜色码
 *  @param alpha 透明度
 *
 *  @return
 */
+ (UIColor *)colorWithHexString:(NSString *)hexColorString;
+ (UIColor *)colorWithHexString:(NSString *)hexColorString andAlpha:(CGFloat)alpha;

@end
