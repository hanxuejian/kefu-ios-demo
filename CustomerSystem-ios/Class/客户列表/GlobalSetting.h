//
//  GlobalSetting.h
//  CustomerSystem-ios
//
//  Created by han on 2019/3/8.
//  Copyright © 2019年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>

///--------- xjhan_11@163.com 客服云配置 -----------///
#define hanxuejian @"xjhan_11@163.com" //123456hanxuejian
#define Appkey_Han @"1418190306068494#kefuchannelapp67176"
#define TenantId_Han @"67176"

#define CustomerSeverDefault_Han @"kefuchannelimid_268262"
#define CustomerSeverDefault1_Han @"kefuchannelimid_643975"
#define CustomerManagerDefault_Han @"customermanager_01"
#define CustomerManagerDefault1_Han @"customermanager_02"


///--------- 1360473124@qq.com 客服云配置 -----------///
#define jiangbin @"1360473124@qq.com" //xiaobin1011
#define Appkey_Jiang @"1452190305061842#kefuchannelapp67039";
#define TenantId_Jiang @"67039"

#define CustomerSeverDefault_Jiang @"kefuchannelimid_689424"
#define CustomerSeverDefault1_Jiang @"kefuchannelimid_027429"
#define CustomerManagerDefault_Jiang @"customermanager_01"
#define CustomerManagerDefault1_Jiang @"customermanager_02"


#define CustomerManagerKey @"CustomerManagerKey"
#define CustomerServerKey @"CustomerServerKey"

#define CurrentCustomerManagerKey @"CurrentCustomerManagerKey"
#define CurrentCustomerServerKey @"CurrentCustomerServerKey"
#define CurrentAppkeyKey @"CurrentAppkeyKey"

NS_ASSUME_NONNULL_BEGIN

@interface GlobalSetting : NSObject

+ (instancetype)shareSetting;

@property (nonatomic, strong) NSString *currentUser;

@property (nonatomic, strong) NSString *currentAppkey;

@property (nonatomic, strong) NSString *currentTenantId;

@property (nonatomic, strong) NSString *currentCustomerServer;

@property (nonatomic, strong) NSString *currentCustomerManager;

@property (nonatomic, strong) NSMutableArray *customerServers;

@property (nonatomic, strong) NSMutableArray *customerManagers;

@end

NS_ASSUME_NONNULL_END
