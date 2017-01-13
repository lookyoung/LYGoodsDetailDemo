//
//  UIView+UIView.h
//  ShuaBao
//
//  Created by Jerry.li on 15/5/29.
//  Copyright (c) 2015年 memedai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIView)

- (CGFloat)originX;
- (CGFloat)originY;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)CenterX;
- (CGFloat)CenterY;
- (CGFloat)maxX;
- (CGFloat)maxY;
- (void)setOriginX:(CGFloat)originX;
- (void)setOriginY:(CGFloat)originY;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;
- (UIImage *)creatImageForViewWithFrame:(CGRect)rect;

- (void)setRoundCorners:(UIRectCorner)rectCorner;

- (void)pushView:(UIView *)toView;
- (void)popView:(UIView *)lastView;
- (void)presentView:(UIView *)view;

- (void)dismissViewWithViews:(NSMutableArray *)views completion:(void (^)(BOOL finished))completion;

@end
