//
//  GoodsViewController.m
//  LYGoodsDetailDemo
//
//  Created by liuyang on 17/1/11.
//  Copyright © 2017年 Mime. All rights reserved.
//

#import "GoodsViewController.h"
#import "InstallmentsPicker.h"
#import "GoodsIndexView.h"
#import "GoodsDetailView.h"
#import "GoodsConfirmView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface GoodsViewController ()
<
    UIScrollViewDelegate,
    GoodsIndexViewDelegate,
    GoodsDetailViewDelegate,
    GoodsIndexViewDelegate,
    GoodsConfirmViewDelegate
>
{
    CGFloat minY;
    CGFloat maxY;
}
/** 商品图片 */
@property (nonatomic, strong) UIImageView *goodsImagesView;
/** scrollView */
@property (nonatomic, strong) UIScrollView *backScrollView;
/** backBaseView */
@property (nonatomic, strong) UIView *backBaseView;
/** nameLabelView */
@property (nonatomic, strong) UIView *nameView;
/** 商品名 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 分期数选择 */
@property (nonatomic, strong) InstallmentsPicker *installmentsPicker;
/** 确认购买按钮 */
@property (nonatomic, strong) UIView *ensureBuyView;
/** 领优惠券 */
@property (nonatomic, strong) GoodsIndexView *receiveCouponView;
/** 选择规格 */
@property (nonatomic, strong) GoodsIndexView *selectSpecifyView;
/** 物流配送 */
@property (nonatomic, strong) GoodsIndexView *goodsDistributeView;
/** 上拉查看图文详情 */
@property (nonatomic, strong) UIView *pullUpView;
/** 商品详情页 */
@property (nonatomic, strong) GoodsDetailView *detailView;
/** 商品详情页 底部确认视图 */
@property (nonatomic, strong) GoodsConfirmView *confirmView;
@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"商品详情";

    [self.view addSubview:self.backBaseView];
}

- (UIScrollView *)backScrollView {
    if (!_backScrollView) {
        _backScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _backScrollView.showsVerticalScrollIndicator = NO;
        _backScrollView.delegate = self;
        
        [_backScrollView addSubview:self.goodsImagesView];
        
        [_backScrollView addSubview:self.nameView];
        
        [_backScrollView addSubview:self.installmentsPicker];
        
        [_backScrollView addSubview:self.ensureBuyView];
        
        UIView *backIndexView = [[UIView alloc] initWithFrame:CGRectMake(0, _ensureBuyView.maxY, ScreenWidth, 500)];
        backIndexView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
        [_backScrollView addSubview:backIndexView];
        
        [backIndexView addSubview:self.receiveCouponView];
        
        [backIndexView addSubview:self.selectSpecifyView];
        
        [backIndexView addSubview:self.goodsDistributeView];
        
        [backIndexView addSubview:self.pullUpView];
        
        // pullUpView在backIndexView上的frame转化成相对于_backScrollView的frame
        CGRect rect = [backIndexView convertRect:self.pullUpView.frame toView:_backScrollView];
        _backScrollView.contentSize = CGSizeMake(ScreenWidth, rect.origin.y + rect.size.height);
    }
    return _backScrollView;
}

#pragma mark - lazy load
- (UIView *)backBaseView {
    if (!_backBaseView) {
        _backBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight * 2)];
        [_backBaseView addSubview:self.backScrollView];
        [_backBaseView addSubview:self.detailView];
        [_backBaseView addSubview:self.confirmView];
    }
    return _backBaseView;
}
- (UIView *)nameView {
    if (!_nameView) {
        _nameView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_goodsImagesView.frame), ScreenWidth, 0)];
        _nameView.backgroundColor = [UIColor whiteColor];
        [_nameView addSubview:self.nameLabel];
        _nameView.height = CGRectGetMaxY(_nameLabel.frame);
    }
    return _nameView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"测试这是一个商品";
        CGFloat height = [UILabel getHeightByWidth:ScreenWidth title:_nameLabel.text font:_nameLabel.font];
        
        _nameLabel.numberOfLines = 2;
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 6.0;
        style.lineBreakMode = NSLineBreakByTruncatingTail;
        style.alignment = NSTextAlignmentCenter;
        NSMutableAttributedString *name = [[NSMutableAttributedString alloc] initWithString:_nameLabel.text];
        [name addAttributes:@{NSFontAttributeName : _nameLabel.font, NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : _nameLabel.textColor} range:NSMakeRange(0, _nameLabel.text.length)];
        _nameLabel.attributedText = name;
        _nameLabel.frame = CGRectMake(0, 4, ScreenWidth, height);
        [_nameLabel sizeToFit];
        _nameLabel.CenterX = ScreenWidth * 0.5;
        
    }
    return _nameLabel;
}

- (UIImageView *)goodsImagesView {
    if (!_goodsImagesView) {
        _goodsImagesView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 375)];
        _goodsImagesView.backgroundColor = [UIColor whiteColor];

        [_goodsImagesView setImage:[UIImage
                                     imageNamed:@"demo1"]];
        
    }
    return _goodsImagesView;
}
- (InstallmentsPicker *)installmentsPicker {
    if (!_installmentsPicker) {
        NSString *monthly = [NSString stringWithFormat:@"￥%@ - ￥%@",@"1700", @"2000"];//￥1700 - ￥2000
        NSArray *terms = @[@1, @3, @6, @9, @12];
        _installmentsPicker = [[InstallmentsPicker alloc] initWithFrame:CGRectMake(0, _nameView.maxY, ScreenWidth, 100 + 22) withMonthly:monthly];
        _installmentsPicker.dataArray = [NSMutableArray arrayWithArray:terms];
    }
    return _installmentsPicker;
}

- (UIView *)ensureBuyView {
    if (!_ensureBuyView) {
        _ensureBuyView = [[UIView alloc] initWithFrame:CGRectMake(0, _installmentsPicker.maxY, ScreenWidth, 22 + 45 + 30)];
        _ensureBuyView.backgroundColor = [UIColor whiteColor];
        
        UIButton *ensureBuyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        ensureBuyButton.frame = CGRectMake(15.0, 22.f, ScreenWidth - 30, 45);
        ensureBuyButton.layer.cornerRadius = 5.0;
        ensureBuyButton.layer.masksToBounds = YES;
        ensureBuyButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [ensureBuyButton setBackgroundImage:[UIImage imageNamed:@"btnDisEnable"] forState:UIControlStateNormal];
        [ensureBuyButton setBackgroundImage:[UIImage imageNamed:@"btnPress"] forState:UIControlStateSelected];
        // 暂时注掉，本迭代不卖货12.17
        [ensureBuyButton setTitle:@"确认购买" forState:UIControlStateNormal];
        [ensureBuyButton setBackgroundImage:[UIImage imageNamed:@"btnNormol"] forState:UIControlStateNormal];
        [ensureBuyButton addTarget:self action:@selector(ensureBuyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_ensureBuyView addSubview:ensureBuyButton];
    }
    return _ensureBuyView;
}

- (GoodsIndexView *)receiveCouponView {
    if (!_receiveCouponView) {
        _receiveCouponView = [[GoodsIndexView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 44) goodsIndexStyle:GoodsIndexStyleCoupon];
        _receiveCouponView.delegate = self;
    }
    return _receiveCouponView;
}

- (GoodsIndexView *)selectSpecifyView {
    if (!_selectSpecifyView) {
        _selectSpecifyView = [[GoodsIndexView alloc] initWithFrame:CGRectMake(0, _receiveCouponView.maxY + 10, ScreenWidth, 44) goodsIndexStyle:GoodsIndexStyleSpecify];
        _selectSpecifyView.delegate = self;
    }
    return _selectSpecifyView;
}

- (GoodsIndexView *)goodsDistributeView {
    if (!_goodsDistributeView) {
        _goodsDistributeView = [[GoodsIndexView alloc] initWithFrame:CGRectMake(0, _selectSpecifyView.maxY + 10, ScreenWidth, 60) goodsIndexStyle:GoodsIndexStyleDistribute];
        _goodsDistributeView.delegate = self;
        
        [self.goodsDistributeView resetContentDictionary:@{GoodsLogisticsRangeContentName : @"除西藏、新疆地区可配送", GoodsLogisticsMoneyContentName : @"￥5-￥10"}];
        
    }
    return _goodsDistributeView;
}

- (UIView *)pullUpView {
    if (!_pullUpView) {
        _pullUpView = [[UIView alloc] initWithFrame:CGRectMake(0, _goodsDistributeView.maxY + 10, ScreenWidth, 51)];
        _pullUpView.backgroundColor = [UIColor whiteColor];
        
        UILabel *pullLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, _pullUpView.width, 11)];
        pullLabel.textAlignment = NSTextAlignmentCenter;
        pullLabel.textColor = [UIColor colorWithHexString:@"#8A9399"];
        pullLabel.font = [UIFont systemFontOfSize:11];
        pullLabel.text = @"上拉查看图文详情";
        [_pullUpView addSubview:pullLabel];
        
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenqi_pullUp"]];
        iconView.frame = CGRectMake((_pullUpView.width - iconView.image.size.width) * 0.5, pullLabel.maxY + 8, iconView.image.size.width, iconView.image.size.height);
        [_pullUpView addSubview:iconView];
        
    }
    return _pullUpView;
}

- (GoodsDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[GoodsDetailView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight)];
        _detailView.delegate = self;
        _detailView.detailImageUrlList = @[@"detailImage"];
        _detailView.paramsDictionary = @{@"规格":@"KM-183mm",@"容量":@"1000ML",@"颜色":@"尊贵金黄"};
        _detailView.buyInfoImageUrl = @"detailImage";
        
    }
    return _detailView;
}

- (GoodsConfirmView *)confirmView {
    if (!_confirmView) {
        _confirmView = [[GoodsConfirmView alloc] initWithFrame:CGRectMake(0, ScreenHeight * 2 - 65, ScreenWidth, 65)];
        _confirmView.delegate = self;

        [_confirmView reSetFenqiNum:@"12" andYuegong:@"22.00"];
    }
    return _confirmView;
}

#pragma mark - 确认购买
- (void)ensureBuyButtonClick:(id)sender {
    // 确认购买
}

#pragma mark - GoodsIndexViewDelegate
- (void)GoodsIndexView:(GoodsIndexView *)goodsIndexView didSelectedAtIndexStyle:(GoodsIndexStyle)style {
    switch (style) {
        case GoodsIndexStyleCoupon:
            // 领优惠券
        {
        }
            break;
        case GoodsIndexStyleSpecify:
            // 选择规格
        {
        }
            break;
        case GoodsIndexStyleDistribute:
            // 物流配送
        {
            
        }
            break;
    }
}

#pragma mark - MMDGoodsConfirmViewDelegate
- (void)goodsConfirmView:(GoodsConfirmView *)goodsConfirmView confirmClick:(id)sender {
    // 确认购买
}

- (void)goodsConfirmView:(GoodsConfirmView *)goodsConfirmView fenqiSelectClick:(id)sender {
    // 点击弹出 选择分期数
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    //计算往下拖拽的高度
    CGFloat down = offsetY + scrollView.contentInset.top;
    CGFloat scale = 1.0;
    if (down < 0) {
        // 放大
        scale = MAX(1.0, 1 - down / self.goodsImagesView.height);
    } else if (down > 0) {
        // 不做缩小
        //scale = MAX(0.45, 1 - down / self.goodsImagesView.height);
    }
    self.goodsImagesView.transform = CGAffineTransformMakeScale(scale, scale);
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) {
        CGFloat offset = scrollView.contentOffset.y;
        if (scrollView == self.backScrollView) {
            if (offset < 0) {
                minY = MIN(minY, offset);
            } else {
                maxY = MAX(maxY, offset);
            }
        } else {
            minY = MIN(minY, offset);
        }
        
        // 上拉往下滚到商品详情视图
        if (maxY >= self.backScrollView.contentSize.height - ScreenHeight + 60)
        {
            [UIView animateWithDuration:0.4 animations:^{
                self.backBaseView.transform = CGAffineTransformTranslate(self.backBaseView.transform, 0,-ScreenHeight);
                //                [_backBaseView addSubview:self.detailView];
                //                [_backBaseView addSubview:self.confirmView];
            } completion:^(BOOL finished) {
                maxY = 0.0f;
                self.navigationItem.title = @"商品详情";
            }];
        }
        
        // 下拉往上滚到商品购买选择视图
        if (minY <= -64)
        {
            [UIView animateWithDuration:0.4 animations:^{
                self.backBaseView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                minY = 0.0f;
                self.navigationItem.title = @"";
            }];
        }
    }
}

@end
