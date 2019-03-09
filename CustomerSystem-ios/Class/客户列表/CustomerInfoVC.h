//
//  CustomerInfoVC.h
//  CustomerSystem-ios
//
//  Created by han on 2019/3/7.
//  Copyright © 2019年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kCustomerInfoKeyUserID @"userName"
#define kCustomerInfoKeyUserName @"name"
#define kCustomerInfoKeyNickName @"nickName"
#define kCustomerInfoKeyPhone @"phone"
#define kCustomerInfoKeyQQ @"qq"
#define kCustomerInfoKeyEmail @"email"
#define kCustomerInfoKeyCompanyName @"companyName"
#define kCustomerInfoKeyDesc @"desc"


@interface CustomerInfoVC : UIViewController

- (instancetype)initWithInfoDic:(NSMutableDictionary *)infoDic;

@property (nonatomic, strong) void (^saveHandler)(void);

@end

NS_ASSUME_NONNULL_END
