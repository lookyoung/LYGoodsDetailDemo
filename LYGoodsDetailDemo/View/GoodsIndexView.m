//
//  GoodsIndexView.m
//  LYGoodsDetailDemo
//
//  Created by liuyang on 17/1/12.
//  Copyright © 2017年 Mime. All rights reserved.
//

#import "GoodsIndexView.h"
#import "UILabel+StringFrame.h"

@interface GoodsIndexView ()
/** style */
@property (nonatomic, assign) GoodsIndexStyle style;
/** nameLabel */
@property (nonatomic, strong) UILabel *nameLabel;
/** contentLabel */
@property (nonatomic, strong) UILabel *contentLabel;
/** UIImageView */
@property (nonatomic, strong) UIImageView *rightIcon;
@end

@implementation GoodsIndexView


- (instancetype)initWithFrame:(CGRect)frame goodsIndexStyle:(GoodsIndexStyle)style {
    self.style = style;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.nameLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.rightIcon];
        
        [self setContent];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapAction {
    if ([self.delegate respondsToSelector:@selector(GoodsIndexView:didSelectedAtIndexStyle:)]) {
        [self.delegate GoodsIndexView:self didSelectedAtIndexStyle:self.style];
    }
}

- (void)setContent {
    switch (self.style) {
        case GoodsIndexStyleCoupon:
            _nameLabel.text = @"领优惠券";
            break;
        case GoodsIndexStyleSpecify:
            _nameLabel.text = @"选择规格";
            break;
        case GoodsIndexStyleDistribute:
        {
            _nameLabel.text = @"物流配送";
            //            _contentLabel.text = @"配送范围：除西藏、新疆地区可配送\n配送运费：￥5-￥10";
            //
            //            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            //            style.lineSpacing = 6.0;
            //            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text attributes:@{NSFontAttributeName : _contentLabel.font, NSForegroundColorAttributeName : _contentLabel.textColor, NSParagraphStyleAttributeName : style}];
            //            _contentLabel.attributedText = str;
            //            [_contentLabel sizeToFit];
            
            _rightIcon.hidden = YES;
            
        }
            break;
            
        default:
            break;
    }
}

- (void)resetContentDictionary:(NSMutableDictionary *)dic {
    switch (self.style) {
        case GoodsIndexStyleSpecify:
        {
            // 选择规格栏内容
        }
            break;
        case GoodsIndexStyleDistribute:
        {
            // 物流配送栏内容
            NSString *range = [dic objectForKey:GoodsLogisticsRangeContentName];
            NSString *money = [dic objectForKey:GoodsLogisticsMoneyContentName];
            _contentLabel.text = [NSString stringWithFormat:@"配送范围：%@\n配送运费：%@",range,money];
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = 6.0;
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text attributes:@{NSFontAttributeName : _contentLabel.font, NSForegroundColorAttributeName : _contentLabel.textColor, NSParagraphStyleAttributeName : style}];
            _contentLabel.attributedText = str;
            [_contentLabel sizeToFit];
        }
            break;
        default:
            break;
    }
}

#pragma mark - lazy load
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.text = @"领优惠券";
        _nameLabel.textColor = [UIColor colorWithHexString:@"#8A9399"];
        CGFloat width = [UILabel getWidthWithTitle:_nameLabel.text font:_nameLabel.font];
        _nameLabel.frame = CGRectMake(15, 15, width, 12);
    }
    return _nameLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.maxX + 15, _nameLabel.originY, self.width - _nameLabel.maxX - 15 - 37, 12)];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#475966"];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIImageView *)rightIcon {
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenqi_rightIcon"]];
        _rightIcon.frame = CGRectMake(self.width - 15 - 22, 0, 22, 22);
        _rightIcon.CenterY = self.height * 0.5;
    }
    return _rightIcon;
}


@end
