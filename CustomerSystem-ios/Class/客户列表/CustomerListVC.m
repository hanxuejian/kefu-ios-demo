//
//  CustomerListVC.m
//  A
//
//  Created by lorne on 2019/3/5.
//  Copyright © 2019 meng. All rights reserved.
//

#import "CustomerListVC.h"
#import "SVProgressHUD.h"
#import "SetViewController.h"


@interface CCBtn : UIButton

@end

@implementation CCBtn



@end
@interface CustomerListVC ()<UITableViewDelegate,UITableViewDataSource,EMContactManagerDelegate>
@property (nonatomic , strong)UITableView* tableView;
@property (nonatomic , strong)NSMutableArray* dataSource;
@property (nonatomic , strong)NSString* currentUserName;


@end

@implementation CustomerListVC


- (NSMutableArray*)dataSource{
    if(!_dataSource){
        if([[NSUserDefaults standardUserDefaults] objectForKey:USERSKEY]){
            _dataSource = [[[NSUserDefaults standardUserDefaults] objectForKey:USERSKEY] mutableCopy];
            
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in _dataSource) {
                NSMutableDictionary *dicM = [dic mutableCopy];
                [array addObject:dicM];
            }
            _dataSource = array;
            
        }else{
            _dataSource = [NSMutableArray array];
        }
        
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 97, 17)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"用户列表";
    self.navigationItem.titleView = label;
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height ) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    
    UIButton* leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn .frame = CGRectMake(0, 0, 80, 46);
    leftBtn .titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn .titleLabel setFont:[UIFont systemFontOfSize:12]];
    [leftBtn  setTitle:@"设置" forState:UIControlStateNormal];
    [leftBtn  addTarget:self action:@selector(set) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton* rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 80, 46);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [rightBtn setTitle:@"一键注册登录" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(reginAndLogin) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    //自动登录第一个用户
    if(self.dataSource.count > 0){
        
        [[HDClient sharedClient] logout:YES];
        
        [SVProgressHUD showWithStatus:@"正在登录"];
        
        NSDictionary* dic = [self.dataSource firstObject];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT , 0), ^{
         HDError * error = [[HDClient sharedClient] loginWithUsername:[dic objectForKey:@"userName"] password:@"111111"];;
            if (!error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self.tableView reloadData];
                    [SVProgressHUD showInfoWithStatus:@"登录成功"];
                    [SVProgressHUD dismissWithDelay:1.0];
                    [CSDemoAccountManager shareLoginManager].userInfoDic = dic;

                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD showInfoWithStatus:@"登录失败"];
                    [SVProgressHUD dismissWithDelay:1.0];

                });
            }

        });

        
    }
    
    
//
//    UIButton* leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.view.height - 55 - 49 - 50, self.view.WX_Width /2 - 40, 55)];
//    leftBtn.backgroundColor = [UIColor greenColor];
//    [leftBtn setTitle:@"购买咨询" forState:UIControlStateNormal];
//    [self.view addSubview:leftBtn];
//    [leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
//
//
//    UIButton* rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.WX_Width /2 + 20, self.view.height - 55 - 49 - 50, self.view.WX_Width /2 - 40, 55)];
//    [rightBtn setTitle:@"售后客服" forState:UIControlStateNormal];
//    [self.view addSubview:rightBtn];
//    rightBtn.backgroundColor = [UIColor purpleColor];
//    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];

    
    // Do any additional setup after loading the view.
}


#pragma mark  售前
- (void)leftClick{
    
    NSString* userID = [HDClient sharedClient].currentUsername;
    NSLog(@"当前用户是：%@",userID);
    NSString* user = @"xiaoshou1";
    //发送消息
    HDMessageViewController *chatVC = [[HDMessageViewController alloc] initWithConversationChatter:user]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
    [self.navigationController pushViewController:chatVC animated:YES];
}
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername
                                message:(NSString *)aMessage{
    
    NSLog(@"收到好友申请");
    
}
#pragma mark  售后
- (void)rightClick{
    
//    NSString* userID = [HDClient sharedClient].currentUsername;

//    NSString* user = @"kefuchannelimid_689424";
//
//
//    EaseMessageViewController *easeMessageVC = [[EaseMessageViewController alloc] initWithConversationChatter:user conversationType:EMConversationTypeChat];
//    easeMessageVC.extDic = @{@"senderName":[HDClient sharedClient].currentUsername,@"senderHeadUrl":@"",@"senderId":[HDClient sharedClient].currentUsername,@"receiveHeadUrl":@"",@"receiveName":@"客服",@"receiveId":user};
//    easeMessageVC.opponentName = @"客服";
//    [self.navigationController pushViewController:easeMessageVC animated:YES];
//
//    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];

    
    
    
    // 进入会话页面
    HDMessageViewController *chatVC = [[HDMessageViewController alloc] initWithConversationChatter:@"xiaoshou1"]; // 获取地址：kefu.easemob.com，“管理员模式 > 渠道管理 > 手机APP”页面的关联的“IM服务号”
    [self.navigationController pushViewController:chatVC animated:YES];
    
    
    //
    
}

- (void)set {
    SetViewController *setVC = [[SetViewController alloc]init];
    
    [self.navigationController pushViewController:setVC animated:YES];
}


- (void)reginAndLogin{
    
    if(self.dataSource.count >= 10){
        [SVProgressHUD showInfoWithStatus:@"为了方便使用，最多创建10个用户"];
        [SVProgressHUD dismissWithDelay:1.0];

        return;
    }
    NSString* userName = [NSString stringWithFormat:@"%d",arc4random() % 100000001];
    
    NSString *str = [[GlobalSetting shareSetting].currentUser isEqualToString:hanxuejian] ? @"han" : @"jiang";
    userName = [NSString stringWithFormat:@"%@_%@",str,userName];
    
    if ([GlobalSetting shareSetting].currentUser)
    [SVProgressHUD show];
    
    __block  HDError * error1;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT , 0), ^{
//        error = [[EMClient sharedClient] registerWithUsername:userName password:@"111111"];
//        if (error==nil) {
//            NSLog(@"注册成功");
//        }else{
//            [self showLoadingView:NO];
//            [self showTipHud:@"注册失败"];
//            return;
//        }
//
//        [[EMClient sharedClient] logout:YES];
//
//        error = [[EMClient sharedClient] loginWithUsername:userName password:@"111111"];
//        if (!error) {
//            NSMutableDictionary* userDic = [[NSMutableDictionary alloc] init];
//            [userDic setObject:userName forKey:@"userName"];
//            [self.dataSource addObject:userDic];
//            self.currentUserName = userName;
//            [self saveUser:userDic];
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self showLoadingView:NO];
//                [self.tableView reloadData];
//                [self showTipHud:@"登录成功"];
//            });
//        }else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self showLoadingView:NO];
//                [self showTipHud:@"登录失败"];
//            });
//            return;
//        }
        
        
       [[HDClient sharedClient] logout:YES];

        error1 = [[HDClient sharedClient] registerWithUsername:userName password:@"111111"];
        if (error1==nil) {
            NSLog(@"注册成功");
            [SVProgressHUD dismiss];

        }else{
            NSLog(@"注册失败");
            return;
        }

        error1 = [[HDClient sharedClient] loginWithUsername:userName password:@"111111"];;
        if (!error1) {
            NSMutableDictionary* userDic = [[NSMutableDictionary alloc] init];
            [userDic setObject:userName forKey:@"userName"];
            [self.dataSource addObject:userDic];
            self.currentUserName = userName;
            [self saveUser:userDic];
            [CSDemoAccountManager shareLoginManager].userInfoDic = userDic;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showInfoWithStatus:@"登录成功"];
                [SVProgressHUD dismissWithDelay:1.0];

                [self.tableView reloadData];
            });
        }else{
            [SVProgressHUD showInfoWithStatus:@"登录失败"];
            [SVProgressHUD dismissWithDelay:1.0];

            
        }
        
    });
    
    
}

- (void)saveUser:(NSDictionary*)userDic{
    NSMutableArray* newArray = [self.dataSource mutableCopy];
    
    [[NSUserDefaults standardUserDefaults] setObject:newArray forKey:@"USERSKEY"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* cellID = @"cellid";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    NSDictionary* dic = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text =  [NSString stringWithFormat:@"用户id：%@",[dic objectForKey:@"userName"]] ;

    
    for (UIView* vv in cell.subviews) {
        if([vv isMemberOfClass:[CCBtn class]]){
            [vv removeFromSuperview];
//            break;
        }
    }
    
    
    if(self.currentUserName){
        if([[dic objectForKey:@"userName"] isEqualToString:self.currentUserName]){
            cell.backgroundColor = [UIColor yellowColor];
            
            
            CCBtn* changeBtn = [[CCBtn alloc] initWithFrame:CGRectMake(0, 0, 45, 25)];
            changeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [changeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [changeBtn setTitle:@"在线" forState:UIControlStateNormal];
            [cell addSubview:changeBtn];
            [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell);
                make.right.equalTo(cell).offset(-20);
                make.height.equalTo(@30);
                make.width.equalTo(@60);
            }];
        }else{
            
            CCBtn* changeBtn = [[CCBtn alloc] initWithFrame:CGRectMake(0, 0, 45, 25)];
            changeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            changeBtn.backgroundColor = [UIColor redColor];
            [changeBtn setTitle:@"切换账号" forState:UIControlStateNormal];
            [cell addSubview:changeBtn];
            [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell);
                make.right.equalTo(cell).offset(-20);
                make.height.equalTo(@30);
                make.width.equalTo(@60);
            }];
            changeBtn.tag = 100 + indexPath.row;
            [changeBtn addTarget:self action:@selector(changeUser:) forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        if(indexPath.row == 0){
            self.currentUserName = [dic objectForKey:@"userName"];
            cell.backgroundColor = [UIColor yellowColor];
            CCBtn* changeBtn = [[CCBtn alloc] initWithFrame:CGRectMake(0, 0, 45, 25)];
            changeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [changeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

            [changeBtn setTitle:@"在线" forState:UIControlStateNormal];
            [cell addSubview:changeBtn];
            [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell);
                make.right.equalTo(cell).offset(-20);
                make.height.equalTo(@30);
                make.width.equalTo(@60);
            }];

        }else{
            CCBtn* changeBtn = [[CCBtn alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            changeBtn.backgroundColor = [UIColor redColor];
            [changeBtn setTitle:@"切换账号" forState:UIControlStateNormal];
            [cell addSubview:changeBtn];
            [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell);
                make.right.equalTo(cell).offset(-20);
                make.height.equalTo(@30);
                make.width.equalTo(@60);
            }];
            changeBtn.tag = 100 + indexPath.row;
            [changeBtn addTarget:self action:@selector(changeUser:) forControlEvents:UIControlEventTouchUpInside];


        }
    }
    
    
    
    return cell;
}

#pragma mark  切换用户
- (void)changeUser:(UIButton*)btn{
    
    NSInteger index = btn.tag - 100;
    NSDictionary* dic = [self.dataSource objectAtIndex:index];
    
    NSString *userName = [dic objectForKey:@"userName"];
    if ([userName containsString:@"han"] && ![[GlobalSetting shareSetting].currentUser isEqualToString:hanxuejian]) {
        [SVProgressHUD showErrorWithStatus:@"请先在设置中切换后台，然后重启应用"];
//        [SVProgressHUD dismissWithDelay:4.0];
        return;
    }
    
    if ([userName containsString:@"jiang"] && ![[GlobalSetting shareSetting].currentUser isEqualToString:jiangbin]) {
        [SVProgressHUD showErrorWithStatus:@"请先在设置中切换后台，然后重启应用"];
//        [SVProgressHUD dismissWithDelay:4.0];
        return;
    }
    
    
    [SVProgressHUD show];
    
    __block EMError *error;
    
    __block  HDError * error1;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT , 0), ^{
//        [[EMClient sharedClient] logout:YES];
//        error = [[EMClient sharedClient] loginWithUsername:[dic objectForKey:@"userName"] password:@"111111"];
//        if (!error) {
//            self.currentUserName = [dic objectForKey:@"userName"];
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self showLoadingView:NO];
//                [self.tableView reloadData];
//                [self showTipHud:@"切换成功"];
//            });
//        }else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self showLoadingView:NO];
//                [self showTipHud:@"切换失败"];
//            });
//        }
        
        
        [[HDClient sharedClient] logout:YES];
        
        error1 = [[HDClient sharedClient] loginWithUsername:[dic objectForKey:@"userName"] password:@"111111"];;
        if (!error1) {
            
            self.currentUserName = [dic objectForKey:@"userName"];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SVProgressHUD showInfoWithStatus:@"切换成功"];
                [SVProgressHUD dismissWithDelay:1.0];
                [CSDemoAccountManager shareLoginManager].userInfoDic = dic;

                [self.tableView reloadData];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showInfoWithStatus:@"切换失败"];
                [SVProgressHUD dismissWithDelay:1.0];

            });
        }
        
    });
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataSource.count <= indexPath.row) return;
    CustomerInfoVC *infoVC = [[CustomerInfoVC alloc]initWithInfoDic:self.dataSource[indexPath.row]];
    infoVC.saveHandler = ^ {
        [self saveUser:nil];
    };
    [self.navigationController pushViewController:infoVC animated:YES];
}

@end
