//
//  UIImageView+Wrapper.m
//  Memedai
//
//  Created by liuyang on 16/12/14.
//  Copyright © 2016年 memedai. All rights reserved.
//

#import "UIImageView+Wrapper.h"

@implementation UIImageView (Wrapper)
- (void)resetHeightWhenWidthFixedWithImage:(UIImage *)image {
    CGFloat scale = image.size.width / image.size.height;
    
    self.height = self.width / scale;
    if (self.width > image.size.width) {
        self.height = image.size.height;
    }
}

- (void)resetWidthWhenHeightFixedWithImage:(UIImage *)image {
    CGFloat scale = image.size.width / image.size.height;
    
    self.width = self.height * scale;
    if (self.height > image.size.height) {
        self.width = image.size.width;
    }
}
@end
