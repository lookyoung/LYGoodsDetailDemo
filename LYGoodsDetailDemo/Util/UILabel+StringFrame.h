//
//  UILabel+StringFrame.h
//  Memedai
//
//  Created by wgs on 16/1/27.
//  Copyright © 2016年 memedai. All rights reserved.
//

@interface UILabel (StringFrame)

- (CGSize)boundingRectWithSize:(CGSize)size;
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end
