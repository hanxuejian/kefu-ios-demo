//
//  ChangeUserInfoViewController.m
//  CustomerSystem-ios
//
//  Created by han on 2019/3/7.
//  Copyright © 2019年 easemob. All rights reserved.
//

#import "ChangeUserInfoViewController.h"

@interface ChangeUserInfoViewController ()

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) NSString *value;

@property (nonatomic, strong) void (^saveHandler)(NSString *value);
@end

@implementation ChangeUserInfoViewController
- (instancetype)initWithValue:(NSString *)value saveHandler:(void (^)(NSString * _Nonnull))handler {
    self.value = value;
    self.saveHandler = handler;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.title = @"用户信息修改";
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat margin = 15;
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(margin, margin, width - 2 * margin, 40)];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.text = self.value;
    [self.view addSubview:self.textField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = UIColor.greenColor;
    button.frame = CGRectMake(margin*2, margin*2 + 50 , width - 4*margin, 60);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    
}

- (void)save {
    
    if (self.saveHandler) {
        self.saveHandler(self.textField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}



@end
