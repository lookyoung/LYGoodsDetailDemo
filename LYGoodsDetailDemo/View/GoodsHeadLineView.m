//
//  GoodsHeadLineView.m
//  LYGoodsDetailDemo
//
//  Created by liuyang on 17/1/12.
//  Copyright © 2017年 Mime. All rights reserved.
//

#import "GoodsHeadLineView.h"

@interface GoodsHeadLineView ()
{
    UIButton *currentSelected;
    UIColor *textColor;
    UIFont *labelFont;
}
/** labelArray */
@property (nonatomic, copy) NSMutableArray *labelArray;
/** circleSelectedView */
@property (nonatomic, strong) UIImageView *circleSelectedView;
/** barSelectedView */
@property (nonatomic, strong) UIImageView *barSelectedView;
@end


@implementation GoodsHeadLineView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        labelFont = [UIFont systemFontOfSize:13];
        textColor = [UIColor colorWithHexString:@"#8A9399"];
        self.titleArray = @[@"商品详情", @"规格参数", @"购买说明"];
        self.currentIndex = 0;
    }
    return self;
}

//传入currentIndex
- (void)setCurrentIndex:(NSInteger)CurrentIndex {
    _currentIndex=CurrentIndex;//改变currentIndex
    [self shuaxinJiemian:_currentIndex];
    if ([_delegate respondsToSelector:@selector(refreshHeadLine:)]) {
        [_delegate refreshHeadLine:_currentIndex];
    }
}

//刷新界面
- (void)shuaxinJiemian:(NSInteger)index;
{
    for (UILabel *label in _labelArray) {
        label.textColor = textColor;
    }
    currentSelected = [self viewWithTag:index + 1300];
    
    UILabel *selectedLabel = ((UILabel *)_labelArray[index]);
    selectedLabel.textColor = [UIColor colorWithHexString:@"1A2833"];
    
    _circleSelectedView.originX = selectedLabel.originX - 6 - _circleSelectedView.width;
    [UIView animateWithDuration:0.2 animations:^{
        _barSelectedView.CenterX = selectedLabel.CenterX;
    }];
}

//按钮点击 传入代理
- (void)buttonClick:(UIButton *)button {
    NSInteger viewTag=[button tag];
    if ([button isEqual:currentSelected]) {
        return;
    }
    self.currentIndex=viewTag-1300;
}

//传入顶部的title
- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    
    CGFloat labelWidth = [UILabel getWidthWithTitle:titleArray[0] font:labelFont];
    CGFloat labelHeight = self.height;
    CGFloat labelMidX = (self.width - labelWidth) * 0.5;
    CGFloat labelMidY = 0;
    
    CGFloat buttonWidth = self.width / _titleArray.count;
    CGFloat buttonHeight = labelHeight;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    
    _labelArray = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelMidX + (62 + labelWidth) * (i - 1), labelMidY, labelWidth, labelHeight)];
        label.font = labelFont;
        label.textColor = textColor;
        label.text = _titleArray[i];
        
        [_labelArray addObject:label];
        [self addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX + buttonWidth * i, buttonY, buttonWidth, buttonHeight);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1300 + i;
        [self addSubview:button];
    }
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"#eaeaea"];
    [self addSubview:bottomLine];
    
    _circleSelectedView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"goods_selectedCircle"]];
    CGFloat circleWidth = _circleSelectedView.image.size.width;
    CGFloat circleHeight = _circleSelectedView.image.size.height;
    CGFloat circleX = ((UILabel *)_labelArray[0]).originX - circleWidth - 6;
    CGFloat circleY = ((UILabel *)_labelArray[0]).CenterY - circleHeight * 0.5;
    _circleSelectedView.frame = CGRectMake(circleX, circleY, circleWidth, circleHeight);
    [self addSubview:_circleSelectedView];
    
    _barSelectedView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"goods_selectedBar"]];
    CGFloat barWidth = _barSelectedView.image.size.width;
    CGFloat barHeight = _barSelectedView.image.size.height;
    CGFloat barX = ((UILabel *)_labelArray[0]).CenterX - barWidth * 0.5;
    CGFloat barY = self.height - barHeight;
    _barSelectedView.frame = CGRectMake(barX, barY, barWidth, barHeight);
    [self addSubview:_barSelectedView];
    
}
@end
