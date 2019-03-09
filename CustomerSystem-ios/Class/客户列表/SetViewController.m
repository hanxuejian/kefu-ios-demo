//
//  SetViewController.m
//  CustomerSystem-ios
//
//  Created by han on 2019/3/8.
//  Copyright © 2019年 easemob. All rights reserved.
//

#import "SetViewController.h"


@interface SetViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, strong) NSMutableArray *customerServers;

@property (nonatomic, strong) NSMutableArray *customerManagers;

@property (nonatomic, strong) NSArray *services;

@property (nonatomic, strong) NSArray *sections;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getSetData];
    
    self.table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    
    
    [self.view addSubview:self.table];
}

- (void)getSetData {
    self.sections = @[@"切换客服云后台",@"客服选择",@"客户经理选择"];
    self.services = @[hanxuejian,jiangbin];

    self.customerServers = [GlobalSetting shareSetting].customerServers;
    self.customerManagers = [GlobalSetting shareSetting].customerManagers;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return self.services.count;
    return section == 1 ? self.customerServers.count : self.customerManagers.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
//    NSArray *array;
//
//    if (indexPath.section == 0) {
//        array = self.services;
//    }else {
//        array = indexPath.section == 1 ? self.customerServers : self.customerManagers;
//    }
//
    if (indexPath.section == 0) {
        NSString *service = self.services[indexPath.row];
        if ([service isEqualToString:[GlobalSetting shareSetting].currentUser]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = self.services[indexPath.row];
        
    } else if (indexPath.section == 1) {
        NSString *server = self.customerServers[indexPath.row];
        if ([server isEqualToString:[GlobalSetting shareSetting].currentCustomerServer]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = self.customerServers[indexPath.row];
        
    }else {
        NSString *manager = self.customerManagers[indexPath.row];
        if ([manager isEqualToString:[GlobalSetting shareSetting].currentCustomerManager]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.textLabel.text = self.customerManagers[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0){
        [GlobalSetting shareSetting].currentUser = cell.textLabel.text;
    }else if (indexPath.section == 1) {
        [GlobalSetting shareSetting].currentCustomerServer = cell.textLabel.text;
    }else {
        [GlobalSetting shareSetting].currentCustomerManager = cell.textLabel.text;
    }
    [self reloadData];
}

- (void)reloadData {
    [self getSetData];
    [self.table reloadData];
}


@end
