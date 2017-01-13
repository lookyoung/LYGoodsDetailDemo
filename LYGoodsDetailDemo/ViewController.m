//
//  ViewController.m
//  LYGoodsDetailDemo
//
//  Created by liuyang on 17/1/11.
//  Copyright © 2017年 Mime. All rights reserved.
//

#import "ViewController.h"
#import "GoodsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    UIButton *goodsBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    goodsBtn.frame = CGRectMake(150, 300, 100, 60);
    [goodsBtn setTitle:@"进去商品详情" forState:UIControlStateNormal];
    [goodsBtn addTarget:self action:@selector(pushToDetailVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goodsBtn];
}

- (void)pushToDetailVC:(id)sender {
    GoodsViewController *vc = [[GoodsViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
