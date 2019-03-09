//
//  CustomerInfoVC.m
//  CustomerSystem-ios
//
//  Created by han on 2019/3/7.
//  Copyright © 2019年 easemob. All rights reserved.
//

#import "CustomerInfoVC.h"
#import "ChangeUserInfoViewController.h"


@interface CustomerInfoVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSMutableDictionary *infoDic;

@end

@implementation CustomerInfoVC

- (instancetype)initWithInfoDic:(NSMutableDictionary *)infoDic {
    self.infoDic = infoDic;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户信息";
    
    self.titles = @[@"账号名",@"用户名",@"昵称",@"手机",@"QQ",@"邮箱",@"公司",@"描述"];
    
    self.table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    
    [self.view addSubview:self.table];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    cell.accessoryType = indexPath.row == 0 ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.titles[indexPath.row];
    cell.detailTextLabel.text = self.infoDic[[self getUserInfoKeyWithIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) return;
    NSString *key = [self getUserInfoKeyWithIndex:indexPath.row];
    
    ChangeUserInfoViewController *changeVC = [[ChangeUserInfoViewController alloc]initWithValue:self.infoDic[key] saveHandler:^(NSString *value) {
        [self.infoDic setValue:value forKey:key];
        
        [self.table reloadData];
        if (self.saveHandler) {
            self.saveHandler();
        }
    }];
    
    [self.navigationController pushViewController:changeVC animated:YES];
}

- (NSString *)getUserInfoKeyWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return kCustomerInfoKeyUserID;
            break;
        case 1:
            return kCustomerInfoKeyUserName;
            break;
        case 2:
            return kCustomerInfoKeyNickName;
            break;
        case 3:
            return kCustomerInfoKeyPhone;
            break;
        case 4:
            return kCustomerInfoKeyQQ;
            break;
        case 5:
            return kCustomerInfoKeyEmail;
            break;
        case 6:
            return kCustomerInfoKeyCompanyName;
            break;
        case 7:
            return kCustomerInfoKeyDesc;
            break;
            
        default:
            return @"";
            break;
    }
}


@end
