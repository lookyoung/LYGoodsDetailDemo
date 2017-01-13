//
//  GoodsConfirmView.m
//  LYGoodsDetailDemo
//
//  Created by liuyang on 17/1/12.
//  Copyright © 2017年 Mime. All rights reserved.
//

#import "GoodsConfirmView.h"
#import "UILabel+StringFrame.h"

@interface GoodsConfirmView ()
/** 顶部横线 */
@property (nonatomic, strong) UIView *topLine;
/** 分期数/月供数的分割线 */
@property (nonatomic, strong) UIView *divLine;
/** 分期数标签 */
@property (nonatomic, strong) UILabel *fenqiLabel;
/** 分期数 */
@property (nonatomic, strong) UILabel *fenqiNum;
/** 展开箭头图标 */
@property (nonatomic, strong) UIImageView *upIconView;
/** 分期数选择 */
@property (nonatomic, strong) UIButton *fenqiSelectBtn;
/** 月供标签 */
@property (nonatomic, strong) UILabel *yuegongLabel;
/** 月供数 */
@property (nonatomic, strong) UILabel *yuegongNum;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *confirmBtn;
@end

@implementation GoodsConfirmView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.height = 65.0;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.topLine];
        [self addSubview:self.divLine];
        [self addSubview:self.fenqiLabel];
        [self addSubview:self.fenqiNum];
        [self addSubview:self.upIconView];
        [self addSubview:self.yuegongLabel];
        [self addSubview:self.yuegongNum];
        [self addSubview:self.confirmBtn];
        [self addSubview:self.fenqiSelectBtn];
    }
    return self;
}

#pragma mark - lazy load
- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        _topLine.backgroundColor = [UIColor colorWithHexString:@"#eaeaea"];
    }
    return _topLine;
}

- (UIView *)divLine {
    if (!_divLine) {
        _divLine = [[UIView alloc] initWithFrame:CGRectMake(72.5, 0, 0.5, self.height)];
        _divLine.backgroundColor = [UIColor colorWithHexString:@"#eaeaea"];
    }
    return _divLine;
}

- (UILabel *)fenqiLabel {
    if (!_fenqiLabel) {
        _fenqiLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 60, 9)];
        _fenqiLabel.font = [UIFont systemFontOfSize:9];//FONT_PF_REGULAR(9);
        _fenqiLabel.textColor = [UIColor colorWithHexString:@"#8A9399"];
        _fenqiLabel.text = @"分期数（期）";
    }
    return _fenqiLabel;
}

- (UILabel *)fenqiNum {
    if (!_fenqiNum) {
        _fenqiNum = [[UILabel alloc] initWithFrame:CGRectMake(15, _fenqiLabel.maxY + 8, 60, 18)];
        _fenqiNum.font = [UIFont systemFontOfSize:18];
        _fenqiNum.textColor = [UIColor colorWithHexString:@"#1A2833"];
        _fenqiNum.text = @"12";
        _fenqiNum.width = [UILabel getWidthWithTitle:_fenqiNum.text font:_fenqiNum.font];
    }
    return _fenqiNum;
}

- (UIImageView *)upIconView {
    if (!_upIconView) {
        _upIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenqishu_up"]];
        _upIconView.frame = CGRectMake(_fenqiNum.maxX + 8, 0, _upIconView.image.size.width, _upIconView.image.size.height);
        _upIconView.CenterY = _fenqiNum.CenterY;
    }
    return _upIconView;
}

- (UILabel *)yuegongLabel {
    if (!_yuegongLabel) {
        _yuegongLabel = [[UILabel alloc] initWithFrame:CGRectMake(_divLine.maxX + 15, 14, 60, 9)];
        _yuegongLabel.font = [UIFont systemFontOfSize:9];
        _yuegongLabel.textColor = [UIColor colorWithHexString:@"#8A9399"];
        _yuegongLabel.text = @"月供（元）";
    }
    return _yuegongLabel;
}

- (UILabel *)yuegongNum {
    if (!_yuegongNum) {
        _yuegongNum = [[UILabel alloc] initWithFrame:CGRectMake(_yuegongLabel.originX, _yuegongLabel.maxY + 8, 100, 20)];
        _yuegongNum.font = [UIFont systemFontOfSize:20];
        _yuegongNum.textColor = [UIColor colorWithHexString:@"#FFC600"];
        _yuegongNum.text = @"5,00";
    }
    return _yuegongNum;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        //确认按钮
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(self.width - 80 - 15, 0, 80., 40.);
        _confirmBtn.layer.cornerRadius = 5.0;
        _confirmBtn.layer.masksToBounds = YES;
        _confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];//FONT_PF_BOLD(15.0);
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"btnDisEnable"] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"btnPress"] forState:UIControlStateSelected];
        _confirmBtn.CenterY = self.height * 0.5;
        [_confirmBtn setTitle:@"已售罄" forState:UIControlStateNormal];
        _confirmBtn.layer.cornerRadius = 38 / 2.0;
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"btnNormol"] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UIButton *)fenqiSelectBtn {
    if (!_fenqiSelectBtn) {
        _fenqiSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fenqiSelectBtn.frame = CGRectMake(0, 0, _divLine.originX, self.height);
        [_fenqiSelectBtn addTarget:self action:@selector(fenqiSelectClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _fenqiSelectBtn;
}

#pragma mark - 点击确认
- (void)confirmClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(goodsConfirmView:confirmClick:)]) {
        [self.delegate goodsConfirmView:self confirmClick:sender];
    }
}

#pragma mark - 点击选择分期数
- (void)fenqiSelectClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(goodsConfirmView:fenqiSelectClick:)]) {
        [self.delegate goodsConfirmView:self fenqiSelectClick:sender];
    }
}

#pragma mark - 重设分期数和月供金额
- (void)reSetFenqiNum:(NSString *)fenqiNum andYuegong:(NSString *)yuegong {
    _fenqiNum.text = fenqiNum;
    _yuegongNum.text = yuegong;
}
@end
