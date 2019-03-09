//
//  CommodityViewController.m
//  CustomerSystem-ios
//
//  Created by dhc on 15/3/28.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "CommodityViewController.h"
#import "CustomButton.h"
#import "LocalDefine.h"
#import "CustomButton.h"

@interface CommodityViewController ()
{
    UIScrollView *_scrollView;
}

@end

@implementation CommodityViewController

@synthesize commodityInfo = _commodityInfo;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CustomButton * backButton = [CustomButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
    [backButton setTitle:@"保险详情" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:19];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitleColor:RGBACOLOR(184, 22, 22, 1) forState:UIControlStateHighlighted];
    backButton.imageRect = CGRectMake(10, 6.5, 16, 16);
    backButton.titleRect = CGRectMake(28, 0, 83, 29);
    [self.view addSubview:backButton];
    backButton.frame = CGRectMake(0, 0, 120, 29);
    
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    UIBarButtonItem *nagetiveSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    nagetiveSpacer.width = - 16;
    self.navigationItem.leftBarButtonItems = @[nagetiveSpacer,backItem];
    
    // 不设置自动偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50)];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.scrollEnabled = YES;
    // [NSString stringWithFormat:@"em_example_image_%d", (int)button.tag + 1  product_details_1_zh.png
    UIImage *commodityImage = [UIImage imageNamed:@"保险介绍"];
    CGFloat height = (commodityImage.size.height / commodityImage.size.width) * _scrollView.frame.size.width;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, height)];
    imageView.image = commodityImage;
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, height);
    [_scrollView addSubview:imageView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50)];
    footerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    footerView.backgroundColor = [UIColor whiteColor];
    footerView.alpha = 1;
    [self.view addSubview:footerView];
    
    
    CustomButton * messageButton = [CustomButton buttonWithType:UIButtonTypeCustom];
//    messageButton.backgroundColor = [UIColor greenColor];
    
    [messageButton setImage:[UIImage imageNamed:@"hd_chat_icon_red"] forState:UIControlStateNormal];
    [messageButton setTitle:@"联系客户经理" forState:UIControlStateNormal];
    messageButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [messageButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [messageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    messageButton.imageRect = CGRectMake(20, footerView.height/3, footerView.height/3, footerView.height/3);
    messageButton.titleRect = CGRectMake(45, footerView.height/4, 100, footerView.height/2);
    [self.view addSubview:messageButton];
    messageButton.frame = CGRectMake(0, 0, footerView.width/2, footerView.height);
    [footerView addSubview:messageButton];
    [messageButton addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
    messageButton.backgroundColor = [UIColor yellowColor];

    CustomButton * kefuButton = [CustomButton buttonWithType:UIButtonTypeCustom];

    [kefuButton setImage:[UIImage imageNamed:@"hd_chat_icon_red"] forState:UIControlStateNormal];
    [kefuButton setTitle:@"联系客服" forState:UIControlStateNormal];
    kefuButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [kefuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [kefuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    kefuButton.imageRect = CGRectMake(40, footerView.height/3, footerView.height/3, footerView.height/3);
    kefuButton.titleRect = CGRectMake(65, footerView.height/4, 100, footerView.height/2);
    [self.view addSubview:kefuButton];
    kefuButton.frame = CGRectMake(footerView.width/2, 0, footerView.width/2, footerView.height);
    [footerView addSubview:kefuButton];
    [kefuButton addTarget:self action:@selector(kefuAction) forControlEvents:UIControlEventTouchUpInside];
    kefuButton.backgroundColor = [UIColor blueColor];

//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - (footerView.height/3) * 2, footerView.height/3, footerView.height/3, footerView.height/3)];
//    [button setImage:[UIImage imageNamed:@"hd_icon_like_gray"] forState:UIControlStateNormal];
//    [footerView addSubview:button];
//    [self.view bringSubviewToFront:footerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)messageAction{
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"USERSKEY"]){
        [SVProgressHUD showInfoWithStatus:@"请在首页注册登录哦"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KNOTIFICATION_KEFU" object:nil];

}
- (void)kefuAction
{
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"USERSKEY"]){
        [SVProgressHUD showInfoWithStatus:@"请在首页注册登录哦"];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_CHAT object:self.commodityInfo];
}


@end
