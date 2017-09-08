//
//  LF_AccountTool.h
//  LFWEIBO
//
//  Created by slimdy on 2017/4/26.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LF_AccountModel.h"
@interface LF_AccountTool : NSObject
    +(void)saveAccountModelWith:(LF_AccountModel *)model;
    +(LF_AccountModel *)getAccountModel;
+(void)GetAccessTokenWith:(NSString *)code success:(void(^)())success failure:(void(^)(NSError * error))failure;
@end
