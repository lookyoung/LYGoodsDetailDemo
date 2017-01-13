//
//  GoodsParameterCell.m
//  LYGoodsDetailDemo
//
//  Created by liuyang on 17/1/12.
//  Copyright © 2017年 Mime. All rights reserved.
//

#import "GoodsParameterCell.h"
#import "UILabel+StringFrame.h"
#define ScreenWidth      [UIScreen mainScreen].bounds.size.width

@interface GoodsParameterCell()
/** nameLabel */
@property (nonatomic, strong) UILabel *nameLabel;
/** dataLabel */
@property (nonatomic, strong) UILabel *dataLabel;
/** seperateLine */
@property (nonatomic, strong) UIView *seperateLine;
@end

@implementation GoodsParameterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.dataLabel];
        [self addSubview:self.seperateLine];
    }
    return self;
}

- (void)setParameterName:(NSString *)parameterName parameterData:(NSString *)parameterData {
    _nameLabel.text = parameterName;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 6;
    style.alignment = NSTextAlignmentRight;
    NSMutableAttributedString *attributeData = [[NSMutableAttributedString alloc] initWithString:parameterData];
    [attributeData addAttributes:@{NSFontAttributeName : _dataLabel.font, NSForegroundColorAttributeName : _dataLabel.textColor,NSParagraphStyleAttributeName : style} range:NSMakeRange(0, parameterData.length)];
    _dataLabel.attributedText = attributeData;
    
    
    CGFloat nameWidth = [UILabel getWidthWithTitle:_nameLabel.text font:_nameLabel.font];
    CGFloat nameHeight = [UILabel getHeightByWidth:nameWidth title:_nameLabel.text font:_nameLabel.font];
    _nameLabel.frame = CGRectMake(15, 18, nameWidth, nameHeight);
    
    _dataLabel.frame = CGRectMake(130, 18, ScreenWidth - 130 - 15, 100);
    [_dataLabel sizeToFit];
    _dataLabel.originX = ScreenWidth - _dataLabel.width - 15;
}

- (CGFloat)cellHeight {
    // 1 - 14       - 48 + 0*8
    // 2 - 33.6667  - 66 = 48 + 1*18
    // 3 - 53.6667  - 84 = 48 + 2*18
    
    return 48 + 18 * ((int)(_dataLabel.height / 18));
}

- (void)layoutSubviews {
    _seperateLine.frame = CGRectMake(15, self.contentView.height - 0.5, ScreenWidth - 30, 0.5);
}

#pragma mark - lazy load
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = [UIColor colorWithHexString:@"#475966"];
    }
    return _nameLabel;
}

-(UILabel *)dataLabel {
    if (!_dataLabel) {
        _dataLabel = [[UILabel alloc] init];
        _dataLabel.textAlignment = NSTextAlignmentRight;
        _dataLabel.font = [UIFont systemFontOfSize:12];
        _dataLabel.textColor = [UIColor colorWithHexString:@"#475966"];
        _dataLabel.numberOfLines = 0;
    }
    return _dataLabel;
}

- (UIView *)seperateLine {
    if (!_seperateLine) {
        _seperateLine = [[UIView alloc] init];
        _seperateLine.backgroundColor = [UIColor colorWithHexString:@"#eaeaea"];
    }
    return _seperateLine;
}


@end
