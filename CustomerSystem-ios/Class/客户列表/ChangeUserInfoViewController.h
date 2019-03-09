//
//  ChangeUserInfoViewController.h
//  CustomerSystem-ios
//
//  Created by han on 2019/3/7.
//  Copyright © 2019年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangeUserInfoViewController : UIViewController

- (instancetype)initWithValue:(NSString *)value saveHandler:(void (^)(NSString *value))handler;

@end

NS_ASSUME_NONNULL_END
