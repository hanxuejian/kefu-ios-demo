//
//  GlobalSetting.m
//  CustomerSystem-ios
//
//  Created by han on 2019/3/8.
//  Copyright © 2019年 easemob. All rights reserved.
//

#import "GlobalSetting.h"

@implementation GlobalSetting

+ (instancetype)shareSetting {
    static dispatch_once_t onceToken;
    static GlobalSetting *setting;
    dispatch_once(&onceToken, ^{
        setting = [[GlobalSetting alloc]init];
    });
    return setting;
}

- (NSString *)currentAppkey {
    NSString *str = [self getValueWithKey:CurrentAppkeyKey];
    if (str.length == 0) {
        [self setValue:Appkey_Han withKey:CurrentAppkeyKey];
        str = [self getValueWithKey:CurrentAppkeyKey];
    }
    return str;
}

- (void)setCurrentAppkey:(NSString *)currentAppkey {
    [self setValue:currentAppkey withKey:CurrentAppkeyKey];
}

- (NSString *)currentTenantId {
    NSString *str = TenantId_Han;
    if (![self.currentAppkey isEqualToString:Appkey_Han]) {
        str = TenantId_Jiang;
    }
    return str;
}

- (NSString *)currentCustomerServer {
    NSString *str = [self getValueWithKey:CurrentCustomerServerKey];
    if (str.length == 0) {
        if ([self.currentAppkey isEqualToString:Appkey_Han]) {
            [self setValue:CustomerSeverDefault_Han withKey:CurrentCustomerServerKey];
            str = [self getValueWithKey:CurrentCustomerServerKey];
        }else {
            [self setValue:CustomerSeverDefault_Jiang withKey:CurrentCustomerServerKey];
            str = [self getValueWithKey:CurrentCustomerServerKey];
        }
    }
    return str;
}

- (void)setCurrentCustomerServer:(NSString *)currentCustomerServer {
    [self setValue:currentCustomerServer withKey:CurrentCustomerServerKey];
}

- (NSString *)currentCustomerManager {
    NSString *str = [self getValueWithKey:CurrentCustomerManagerKey];
    if (str.length == 0) {
        if ([self.currentAppkey isEqualToString:Appkey_Han]) {
            [self setValue:CustomerManagerDefault_Han withKey:CurrentCustomerManagerKey];
            str = [self getValueWithKey:CurrentCustomerManagerKey];
        }else {
            [self setValue:CustomerManagerDefault_Jiang withKey:CurrentCustomerManagerKey];
            str = [self getValueWithKey:CurrentCustomerManagerKey];
        }
    }
    return str;
}

- (void)setCurrentCustomerManager:(NSString *)currentCustomerManager {
    [self setValue:currentCustomerManager withKey:CurrentCustomerManagerKey];
    
}

- (NSMutableArray *)customerServers {
    NSMutableArray *array = [self getArrayWithKey:CustomerServerKey];
    if (array.count == 0) {
        if ([self.currentAppkey isEqualToString:Appkey_Han]) {
            [self setArray:@[CustomerSeverDefault_Han,CustomerSeverDefault1_Han] withKey:CustomerServerKey];
            array = [self getArrayWithKey:CustomerServerKey];
        }else {
            [self setArray:@[CustomerSeverDefault_Jiang,CustomerSeverDefault1_Jiang] withKey:CustomerServerKey];
            array = [self getArrayWithKey:CustomerServerKey];
        }
    }
    return array;
}

- (NSMutableArray *)customerManagers {

    NSMutableArray *array = [self getArrayWithKey:CustomerManagerKey];
    if (array.count == 0) {
        if ([self.currentAppkey isEqualToString:Appkey_Han]) {
            [self setArray:@[CustomerManagerDefault_Han,CustomerManagerDefault1_Han] withKey:CustomerManagerKey];
            array = [self getArrayWithKey:CustomerManagerKey];
        }else {
            [self setArray:@[CustomerManagerDefault_Jiang,CustomerManagerDefault1_Jiang] withKey:CustomerManagerKey];
            array = [self getArrayWithKey:CustomerManagerKey];
        }
    }
    return array;
}

- (NSMutableArray *)getArrayWithKey:(NSString *)key {
    NSArray *array = [[NSUserDefaults standardUserDefaults]valueForKey:key];
    return [array mutableCopy];
}

- (void)setArray:(NSArray *)array withKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults]setValue:array forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSString *)getValueWithKey:(NSString *)key {
    NSString *str = [[NSUserDefaults standardUserDefaults]valueForKey:key];
    return str;
}

- (void)setValue:(NSString *)value withKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults]setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSString *)currentUser {
    if ([self.currentAppkey isEqualToString:Appkey_Han]) {
        return hanxuejian;
    }else {
        return jiangbin;
    }
}

- (void)setCurrentUser:(NSString *)currentUser {
    [self changeUser:currentUser];
}

- (void)changeUser:(NSString *)user {
    [self clearSetting];
    if ([user isEqualToString:hanxuejian]) {
        self.currentAppkey = Appkey_Han;
    }else {
        self.currentAppkey = Appkey_Jiang;
    }
}

- (void)clearSetting {
    [self setValue:nil withKey:CurrentAppkeyKey];
    [self setValue:nil withKey:CurrentCustomerServerKey];
    [self setValue:nil withKey:CurrentCustomerManagerKey];
    [self setValue:nil withKey:CustomerServerKey];
    [self setValue:nil withKey:CustomerManagerKey];
}

@end
