//
//  GoodsDetailView.m
//  LYGoodsDetailDemo
//
//  Created by liuyang on 17/1/12.
//  Copyright © 2017年 Mime. All rights reserved.
//

#import "GoodsDetailView.h"
#import "GoodsHeadLineView.h"
#import "GoodsParameterCell.h"
#import "UILabel+StringFrame.h"

@interface GoodsDetailView ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    GoodsHeadLineViewDelegate
>
/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** 下拉提示视图 */
@property (nonatomic, strong) UIView *pullDownView;
/** 当前标签页0，1，2 */
@property (nonatomic, assign) NSInteger currentIndex;
/** headerView */
@property (nonatomic, strong) GoodsHeadLineView *headerView;
/** 商品详情视图 */
@property (nonatomic, strong) UIView *detailView;
/** 规格参数名称数组 */
@property (nonatomic, copy) NSMutableArray *parameterNameArray;
/** 规格参数数组 */
@property (nonatomic, copy) NSMutableArray *parameterDataArray;
/** 规格参数cell行高数据数组 */
@property (nonatomic, strong) NSMutableArray *cellHeightArray;
/** 购买说明视图 */
@property (nonatomic, strong) UIView *buyExplainView;
/** 购买说明视图更改 2016.12.26 */
@property (nonatomic, strong) UIView *buyExplainNewView;
/** 购买说明里的图标 */
@property (nonatomic, strong) UIImageView *shopLogoView;
/** 购买说明里的商户名称 */
@property (nonatomic, strong) UILabel *shopNameLabel;
/** 购买说明里的商户名称下面的bar */
@property (nonatomic, strong) UIImageView *barView;
/** 购买说明里的商户描述 */
@property (nonatomic, strong) UILabel *shopProfileLabel;
@end

#define NavBarHeight     64
#define ScreenWidth      [UIScreen mainScreen].bounds.size.width

@implementation GoodsDetailView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        self.parameterDataArray = [NSMutableArray arrayWithObjects:@"", nil];
        self.parameterNameArray = [NSMutableArray arrayWithObjects:@"", nil];
    }
    return self;
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, self.width, self.height - 65 - NavBarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        // 设置为tableHeaderView的话，cell的HeaderView悬停的效果会在tableHeaderView的y位置出现，即可能会被标题栏遮挡
        //        _tableView.tableHeaderView = self.pullDownView;
        [_tableView addSubview:self.pullDownView];
        
    }
    return _tableView;
}

- (UIView *)pullDownView {
    if (!_pullDownView) {
        _pullDownView = [[UIView alloc] initWithFrame:CGRectMake(0, -NavBarHeight, self.width, NavBarHeight)];
        
        CGFloat labelX = 0;
        CGFloat labelY = _pullDownView.height - 11 - 6;
        CGFloat labelWidth = _pullDownView.width;
        CGFloat labelHeight = 11;
        UILabel *pullLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
        pullLabel.textAlignment = NSTextAlignmentCenter;
        pullLabel.textColor = [UIColor colorWithHexString:@"#8A9399"];
        pullLabel.font = [UIFont systemFontOfSize:11];
        pullLabel.text = @"下拉返回顶部";
        [_pullDownView addSubview:pullLabel];
        
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fenqi_pullDown"]];
        CGFloat iconWidth = iconView.image.size.width;
        CGFloat iconHeight = iconView.image.size.height;
        CGFloat iconX = (labelWidth - iconWidth) * 0.5;
        CGFloat iconY = labelY - 6 - iconHeight;
        iconView.frame = CGRectMake(iconX, iconY, iconWidth, iconHeight);
        [_pullDownView addSubview:iconView];
    }
    return _pullDownView;
}

- (UIView *)detailView {
    if (!_detailView) {
        _detailView = [[UIView alloc] init];
        _detailView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth);
    }
    return _detailView;
}

- (void)setParamsDictionary:(NSDictionary *)paramsDictionary {
    _paramsDictionary = paramsDictionary;
    
    // 有配置数据，则清空数组，若没有配置数据，则数组有一条数据为空显示
    if (0 != paramsDictionary.count ) {
        [self.parameterDataArray removeAllObjects];
        [self.parameterNameArray removeAllObjects];
    }
    [_paramsDictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull value, BOOL * _Nonnull stop) {
        [self.parameterNameArray addObject:key];
        [self.parameterDataArray addObject:value];
    }];
}

- (void)setDetailImageUrlList:(NSArray *)detailImageUrlList {
    _detailImageUrlList = detailImageUrlList;
    
    __block CGFloat imageHeight;

    [_detailImageUrlList enumerateObjectsUsingBlock:^(NSString * _Nonnull detailImageUrl, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *detailImageView = [[UIImageView alloc] init];
        detailImageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth);
        [detailImageView setContentMode:UIViewContentModeScaleAspectFit];
        
        detailImageView.image = [UIImage imageNamed:detailImageUrl];
        detailImageView.frame = CGRectMake(0, imageHeight, ScreenWidth, detailImageView.image.size.height);
        [detailImageView resetHeightWhenWidthFixedWithImage:detailImageView.image];
        imageHeight += detailImageView.height;
        [self.detailView addSubview:detailImageView];
        self.detailView.height = detailImageView.maxY;

    }];
    
}

- (void)setBuyInfoImageUrl:(NSString *)buyInfoImageUrl {
    _buyInfoImageUrl = buyInfoImageUrl;
    
    UIImageView *buyExplainImageView = [[UIImageView alloc] init];
    buyExplainImageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth);
    [buyExplainImageView setContentMode:UIViewContentModeScaleAspectFit];
    
//    WS(weakSelf);
//    [[MMDImageHandle instance] loadImageWithURL:buyInfoImageUrl defaultImage:@"goods_listPlaceholder" block:^(NSData * _Nullable data) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // 购买说明 新的布局
//            buyExplainImageView.image = [UIImage imageWithData:data];
//            buyExplainImageView.frame = CGRectMake(0, 0, ScreenWidth, buyExplainImageView.image.size.height);
//            [buyExplainImageView resetHeightWhenWidthFixedWithImage:buyExplainImageView.image];
//            [weakSelf.buyExplainNewView addSubview:buyExplainImageView];
//            weakSelf.buyExplainNewView.height = buyExplainImageView.maxY;
//        });
//    }];
}

- (void)setShopName:(NSString *)shopName {
    _shopName = shopName;
    _shopNameLabel.text = shopName;
    if (!(shopName == nil || shopName == NULL || [shopName isEqualToString:@""])) {
        _barView.alpha = 1;
    }
}

- (void)setShopProfile:(NSString *)shopProfile {
    
    _shopProfileLabel.hidden = NO;
    NSString *str = shopProfile;
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 12;
    [attStr addAttributes:@{NSFontAttributeName : _shopProfileLabel.font, NSForegroundColorAttributeName : _shopProfileLabel.textColor, NSParagraphStyleAttributeName : paraStyle} range:NSMakeRange(0, str.length)];
    _shopProfileLabel.attributedText = attStr;
    [_shopProfileLabel sizeToFit];
    
}

- (void)setParameterDataArray:(NSMutableArray *)parameterDataArray {
    _parameterDataArray = parameterDataArray;
}

-(void)setParameterNameArray:(NSMutableArray *)parameterNameArray {
    _parameterNameArray = parameterNameArray;
}

-(NSMutableArray *)cellHeightArray {
    if (!_cellHeightArray) {
        _cellHeightArray = [[NSMutableArray alloc] init];
    }
    return _cellHeightArray;
}

- (UIView *)buyExplainView {
    if (!_buyExplainView) {
        _buyExplainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.tableView.height - 64 - 40)];
        
        self.shopLogoView.frame = CGRectMake(_buyExplainView.width * 0.5 - 60, 27, 120, 120);
        [_buyExplainView addSubview:_shopLogoView];
        
        UILabel *shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _shopLogoView.maxY + 16, _buyExplainView.width, 13)];
        shopNameLabel.font = [UIFont systemFontOfSize:13];//FONT_PF_REGULAR(13);
        shopNameLabel.textColor = [UIColor colorWithHexString:@"#1a2833"];
        shopNameLabel.textAlignment = NSTextAlignmentCenter;
        _shopNameLabel = shopNameLabel;
        [_buyExplainView addSubview:shopNameLabel];
        
        UIImageView *barView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"goods_selectedBar"]];
        CGFloat barWidth = barView.image.size.width;
        CGFloat barHeight = barView.image.size.height;
        CGFloat barX = (_buyExplainView.width - barWidth) * 0.5;
        CGFloat barY = shopNameLabel.maxY + 13;
        barView.frame = CGRectMake(barX, barY, barWidth, barHeight);
        _barView = barView;
        barView.alpha = 0;
        [_buyExplainView addSubview:barView];
        
        UILabel *shopProfileLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, barView.maxY + 15, _buyExplainView.width - 40, 1000)];
        shopProfileLabel.font = [UIFont systemFontOfSize:12];
        shopProfileLabel.numberOfLines = 0;
        shopProfileLabel.textColor = [UIColor colorWithHexString:@"#8a9399"];
        
        NSString *str = @"公司简介：网易严选网易严选网易严选网易严选网易严选网易严选网易严选网易“严选网易严选网易严选网易严选”，网易严选网易严选，网易严选网易严选网易严选网易严选网易严选网易严选网易严选网易严选。";
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str];
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = 12;
        [attStr addAttributes:@{NSFontAttributeName : shopProfileLabel.font, NSForegroundColorAttributeName : shopProfileLabel.textColor, NSParagraphStyleAttributeName : paraStyle} range:NSMakeRange(0, str.length)];
        shopProfileLabel.attributedText = attStr;
        [shopProfileLabel sizeToFit];
        shopProfileLabel.hidden = YES;
        _shopProfileLabel = shopProfileLabel;
        [_buyExplainView addSubview:shopProfileLabel];
    }
    return _buyExplainView;
}

- (UIView *)buyExplainNewView {
    if (!_buyExplainNewView) {
        _buyExplainNewView = [[UIView alloc] init];
        _buyExplainNewView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth);
    }
    return _buyExplainNewView;
}

- (UIImageView *)shopLogoView {
    if (!_shopLogoView) {
        UIImageView *shopLogoView = [[UIImageView alloc] initWithFrame:CGRectMake(_buyExplainView.width * 0.5 - 60, 27, 120, 120)];
        shopLogoView.image = [UIImage imageNamed:@""];
        _shopLogoView = shopLogoView;
    }
    return _shopLogoView;
}
#pragma mark - MMDGoodsHeadLineViewDelegate
- (void)refreshHeadLine:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    // 切换时视图回到顶部显示
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.tableView reloadData];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!_headerView) {
        _headerView = [[GoodsHeadLineView alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
        _headerView.delegate = self;
        _headerView.currentIndex = _currentIndex;
    }
    return _headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == _currentIndex) {
        return _detailView.height;
    } else if (2 == _currentIndex) {
        //        return self.tableView.height - 40;
        return _buyExplainNewView.height;
    }
    if (self.cellHeightArray.count) {
        return [self.cellHeightArray[indexPath.row] floatValue];
    } else {
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (1 != _currentIndex) {
        return 1;
    }
    return self.parameterDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (0 == _currentIndex) {
        // 商品详情
        static NSString *reuseIdentifier = @"goodsDetail";
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
        }
        
        [cell.contentView addSubview:self.detailView];
    } else if (1 == _currentIndex) {
        // 规格参数
        GoodsParameterCell *cell;
        static NSString *reuseIdentifier = @"parameter";
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell = [[GoodsParameterCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setParameterName:self.parameterNameArray[indexPath.row] parameterData:self.parameterDataArray[indexPath.row]];
        // 根据内容计算cell的行高，存入数组
        self.cellHeightArray[indexPath.row] = @([cell cellHeight]);
        
        [cell layoutIfNeeded];
        return cell;
        
    } else if (2 == _currentIndex) {
        // 购买说明
        static NSString *reuseIdentifier = @"buyExplain";
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        
        //        [cell.contentView addSubview:self.buyExplainView];
        [cell.contentView addSubview:self.buyExplainNewView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
