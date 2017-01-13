//
//  InstallmentsPicker.m
//  LYGoodsDetailDemo
//
//  Created by liuyang on 17/1/11.
//  Copyright © 2017年 Mime. All rights reserved.
//

#import "InstallmentsPicker.h"


@interface InstallmentsPicker ()<UIScrollViewDelegate>
/** nameLabel */
@property (nonatomic, strong) UILabel *nameLabel;
/** monthlyInstall */
@property (nonatomic, strong) UILabel *monthlyInstall;

/** 滚动视图底图, */
@property (nonatomic, strong) UIView *baseView;
/** colorArray */
@property (nonatomic, strong) NSArray *colorArray;
/** 原数据数组 */
@property (nonatomic, strong) NSMutableArray *wholeArray;
/** 存放各分期标签frame */
@property (nonatomic, strong) NSMutableArray *frameArr;

/** 隐藏label的字段 */
@property (nonatomic, strong) NSString *dismissLabelText;


@end

@implementation InstallmentsPicker


- (instancetype)initWithFrame:(CGRect)frame withMonthly:(NSString *)monthly
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _monthly = monthly;
        [self addSubview:self.nameLabel];
        [self addSubview:self.baseView];
        [self addIconView];
        [self addSubview:self.monthlyInstall];
        self.height = self.monthlyInstall.maxY;
        [self addGesture];
        
        //        self.dataArray = (NSMutableArray *)@[@"1", @"3", @"6", @"9", @"12", @"15", @"18"];
        //        self.monthlyArray = (NSMutableArray *)@[@"￥5000", @"￥1700 - ￥2000", @"￥900 - ￥1100", @"￥600 - ￥800", @"￥500 - ￥600"];
    }
    return self;
}

#pragma mark - 添加左右滑手势
- (void)addGesture {
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeRight];
}

#pragma mark - lazy load
- (void)setDataArray:(NSMutableArray *)dataArray {
    _wholeArray = dataArray;
    if (dataArray.count > 5) {
        _dataArray = (NSMutableArray *)[_wholeArray subarrayWithRange:NSMakeRange(0, 5)];
    } else if (dataArray.count == 5) {
        _dataArray = _wholeArray;
        
    } else  if (dataArray.count > 2) {
        _dataArray = [NSMutableArray arrayWithArray:dataArray];
        for (int i = 0; i < 5 - dataArray.count; i++) {
            [_dataArray addObject:@""];
        }
    } else if (dataArray.count == 2) {
        _dataArray = [NSMutableArray arrayWithObjects:@"",dataArray[0], dataArray[1], @"", @"", nil];
    } else if (dataArray.count == 1) {
        _dataArray = [NSMutableArray arrayWithObjects:@"", @"", dataArray[0], @"", @"", nil];
    }
    
    _monthlyArray = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        [_monthlyArray addObject:_monthly];
    }
    
    int count = (int)_dataArray.count;
    int mid = count / 2;
    
    CGFloat labelY = 8;
    CGFloat labelWidth = [UILabel getWidthWithTitle:@"18" font:[UIFont systemFontOfSize:14]];
    CGFloat labelHeight = [UILabel getHeightByWidth:labelWidth title:@"18" font:[UIFont systemFontOfSize:14]];
    CGFloat midX = _baseView.width * 0.5 - labelWidth * 0.5;
    
    CGFloat btnX = _baseView.originX;
    CGFloat btnY = _baseView.originY;
    CGFloat btnWidth = _baseView.width / 5;
    CGFloat btnHeight = _baseView.height;
    
    for (int i = 0; i < count; i++) {
        
        UILabel *view = [[UILabel alloc] init];
        
        CGFloat dd = mid - i;
        if (fabs(dd) <= 1) {
            view.frame = CGRectMake(midX - (50 + labelWidth) * dd, labelY, labelWidth, labelHeight);
        } else if (fabs(dd) == 2) {
            view.frame = CGRectMake(midX - (49 + labelWidth) * dd, labelY, labelWidth, labelHeight);
        }
        
        view.font = [UIFont systemFontOfSize:14];
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.textColor = self.colorArray[i];
        view.text = [NSString stringWithFormat:@"%@",_dataArray[i]];
        view.tag = i + 1;
        [_baseView addSubview:view];
        
        [self.frameArr addObject:NSStringFromCGRect(view.frame)];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnX + btnWidth * i, btnY, btnWidth, btnHeight);
        btn.tag = i;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(chickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:9];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor colorWithHexString:@"#8A9399"];
        _nameLabel.text = @"分期数（期）";
        CGFloat height = [UILabel getHeightByWidth:_nameLabel.width title:_nameLabel.text font:_nameLabel.font];
        _nameLabel.frame = CGRectMake(0, 22, self.width, height);
    }
    return _nameLabel;
}

- (UIView *)baseView {
    if (!_baseView) {
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, _nameLabel.maxY, 262.667, 33)];
        _baseView.CenterX = self.width * 0.5;
        _baseView.backgroundColor = [UIColor whiteColor];
    }
    return _baseView;
}

- (NSArray *)colorArray {
    if (!_colorArray) {
        _colorArray = [NSArray arrayWithObjects:
                       [UIColor colorWithHexString:@"#D6DADC"],
                       [UIColor colorWithHexString:@"#8A9399"],
                       [UIColor colorWithHexString:@"#FFC600"],
                       [UIColor colorWithHexString:@"#8A9399"],
                       [UIColor colorWithHexString:@"#D6DADC"],
                       nil];
    }
    return _colorArray;
}

- (NSMutableArray *)frameArr {
    if (!_frameArr) {
        _frameArr = [NSMutableArray array];
    }
    return _frameArr;
}

- (void)addIconView {
    UIImageView *lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenqi_line"]];
    lineView.frame = CGRectMake(0, 0, lineView.image.size.width, lineView.image.size.height);
    lineView.CenterX = self.width * 0.5;
    lineView.originY = _baseView.maxY;
    [self addSubview:lineView];
    
    UIImageView *selectedView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenqi_selected"]];
    selectedView.frame = CGRectMake(0, 0, selectedView.image.size.width, selectedView.image.size.height);
    selectedView.CenterX = self.width * 0.5;
    selectedView.originY = _baseView.maxY - selectedView.image.size.height;
    [self addSubview:selectedView];
}

- (UILabel *)monthlyInstall {
    if (!_monthlyInstall) {
        _monthlyInstall = [[UILabel alloc] initWithFrame:CGRectMake(0, _baseView.maxY + 12, self.width, 16)];
        _monthlyInstall.textAlignment = NSTextAlignmentCenter;
        
        [self monthlyResetWithAmount:_monthly];
    }
    return _monthlyInstall;
}

#pragma mark - 重置月供金额
- (void)monthlyResetWithAmount:(NSString *)amount {
    //@"月供 ￥500 -￥800"
    NSString *yuegong = [NSString stringWithFormat:@"月供 %@",amount];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:yuegong];
    [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#1A2833"]} range:NSMakeRange(0, 2)];
    [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16], NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#1A2833"]} range:NSMakeRange(2, str.length - 2)];
    
    NSRange iconRange1 = [yuegong rangeOfString:@"￥" options:NSLiteralSearch];
    NSRange iconRange2 = [yuegong rangeOfString:@"￥" options:NSBackwardsSearch];
    [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]} range:iconRange1];
    [str addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]} range:iconRange2];
    
    
    _monthlyInstall.attributedText = str;
}
#pragma mark - 左右滑事件
- (void)swipeAction:(UISwipeGestureRecognizer *)guester {
    
    switch (guester.direction) {
        case UISwipeGestureRecognizerDirectionRight:
        {
            // 右滑
            [self setAllFrame:0];
        }
            break;
        case UISwipeGestureRecognizerDirectionLeft:
        {
            // 左滑
            [self setAllFrame:3];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 点击事件
- (void)chickBtn:(UIButton *)btn
{
    if (btn.tag == 2) {
        
    } else {
        [self setAllFrame:(int)btn.tag];
    }
}
#pragma mark - 重置frame
- (void)setAllFrame:(int)tag
{
    unsigned long count = 5;//_baseView.subviews.count;
    CGFloat div = _baseView.width / count;
    
    
    [self.frameArr removeAllObjects];
    
    __block UILabel *dismissLabel;
    for (int i = 1; i < count + 1; i++) {
        CGRect frame = [_baseView viewWithTag:i].frame;
        [_frameArr addObject:NSStringFromCGRect(frame)];
    }
    
    // 判断点击处所在的标签是否text为空，空的话，不可右（左）移
    for (int i = 0; i < _frameArr.count; i ++) {
        CGFloat x = CGRectFromString(_frameArr[i]).origin.x;
        if (x >= tag * div && x < (tag+1)*div) {
            NSString *text = ((UILabel *)[_baseView viewWithTag:i+1]).text;
            if (text == nil || text == NULL || [text isEqualToString:@""]) {
                return;
            }
        }
    }
    switch (tag) {
        case 0:
        case 1:
        {
            for (int i = 1; i < count + 1; i++)
            {
                // i对应arr[n], 1-1, 2-2, 3-3, 4-4, 5-0
                CGRect newFrame;
                if (i == count) {
                    newFrame = CGRectFromString(_frameArr[i - count]);
                } else {
                    newFrame = CGRectFromString(_frameArr[i]);
                }
                
                CGFloat oldFrameX = [_baseView viewWithTag:i].originX;
                if (oldFrameX > newFrame.origin.x) {
                    dismissLabel = (UILabel *)[_baseView viewWithTag:i];
                    [dismissLabel setAlpha:0];
                    
                    // 4条分期的话，隐藏置空的label显示
                    if (_wholeArray.count == 4 && dismissLabel.tag == 1) {
                        dismissLabel.text = _dismissLabelText;
                    }
                    
                }
                
                [UIView animateWithDuration:0.4 animations:^{
                    [[_baseView viewWithTag:i] setFrame:newFrame];
                } completion:^(BOOL finished) {
                    
                    [dismissLabel setAlpha:1];
                    int n = (int)([_baseView viewWithTag:i].originX / div);
                    [(UILabel *)[_baseView viewWithTag:i] setTextColor:(UIColor *)[self.colorArray objectAtIndex:n]];
                    // 月供数额做相应改变
                    if (2 == n) {
                        [self monthlyResetWithAmount:self.monthlyArray[i-1]];
                    }
                }];
            }
            // 4条分期的话，隐藏的label置空
            if (_wholeArray.count == 4 && dismissLabel.tag == 4) {
                _dismissLabelText = dismissLabel.text;
                dismissLabel.text = @"";
            }
        }
            break;
        case 3:
        case 4:
        {
            for (int i=1; i<count+1; i++)
            {
                // i对应arr[n], 1-4, 2-0, 3-1, 4-2, 5-3
                CGRect newFrame;
                if (i == 1) {
                    newFrame = CGRectFromString(_frameArr[i - 2 + count]);
                } else {
                    newFrame = CGRectFromString(_frameArr[i - 2]);
                }
                
                CGFloat oldFrameX = [_baseView viewWithTag:i].originX;
                if (oldFrameX < newFrame.origin.x) {
                    dismissLabel = (UILabel *)[_baseView viewWithTag:i];
                    [dismissLabel setAlpha:0];
                    
                    // 4条分期的话，隐藏置空的label恢复
                    if (_wholeArray.count == 4  && dismissLabel.tag == 4) {
                        dismissLabel.text = _dismissLabelText;
                    }
                    
                }
                
                [UIView animateWithDuration:0.4 animations:^{
                    [[_baseView viewWithTag:i] setFrame:newFrame];
                } completion:^(BOOL finished) {
                    //                    if (dismissLabel.tag == i) {
                    //
                    //                        NSUInteger index = [_wholeArray indexOfObject:dismissLabel.text];
                    //                        _dataArray = [NSMutableArray arrayWithArray:[_wholeArray subarrayWithRange:NSMakeRange(index+1, 5)]];
                    //                        for (int i = 1; i <= 5; i++) {
                    //                            UILabel *label = (UILabel *)[_baseView viewWithTag:i];
                    //                            label.text = [NSString stringWithFormat:@"%@",_dataArray[i-1]];
                    //
                    //                        }
                    //                    }
                    //                    dismissLabel.text = [NSString stringWithFormat:@"%@",_dataArray[i-1]];
                    [dismissLabel setAlpha:1];
                    int n = (int)([_baseView viewWithTag:i].originX / div);
                    [(UILabel *)[_baseView viewWithTag:i] setTextColor:(UIColor *)[self.colorArray objectAtIndex:n]];
                    // 月供数额做相应改变
                    if (2 == n) {
                        [self monthlyResetWithAmount:self.monthlyArray[i-1]];
                    }
                }];
            }
            
            // 4条分期的话，隐藏的label置空
            if (_wholeArray.count == 4 && dismissLabel.tag == 1) {
                _dismissLabelText = dismissLabel.text;
                dismissLabel.text = @"";
            }
        }
            break;
        default:
            break;
    }
    
}

@end
