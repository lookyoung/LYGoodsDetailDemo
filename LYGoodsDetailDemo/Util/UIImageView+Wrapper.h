//
//  UIImageView+Wrapper.h
//  Memedai
//
//  Created by liuyang on 16/12/14.
//  Copyright © 2016年 memedai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Wrapper)

/**
 UIImageView 图片自适应，根据图片大小缩放比例来改变View的宽或高（前提：ImageView的宽或高有一个固定）

 @param image image
 */
- (void)resetHeightWhenWidthFixedWithImage:(UIImage *)image;
- (void)resetWidthWhenHeightFixedWithImage:(UIImage *)image;
@end
