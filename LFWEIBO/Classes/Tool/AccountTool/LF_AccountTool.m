//
//  LF_AccountTool.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/26.
//  Copyright © 2017年 slimdy. All rights reserved.
//
#define Client_id @"1392991338"
#define Redirect_uri @"http://www.fanna.com.cn"
#define Client_secret @"c650e0b4c3a05082ef0d04c632e5b752"
#import "LF_AccountTool.h"
#import "LF_HttpTool.h"
#import "LF_RootControllerTool.h"
#define LFArchivePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingPathComponent:@"account.data"]
@implementation LF_AccountTool
    static LF_AccountModel *account = nil;
+(void)saveAccountModelWith:(LF_AccountModel *)model{
    [NSKeyedArchiver archiveRootObject:model toFile:LFArchivePath];
}
+(LF_AccountModel *)getAccountModel{
    if (account == nil) {
        account = [NSKeyedUnarchiver unarchiveObjectWithFile:LFArchivePath];
        if ([[NSDate date] compare:account.expires_date] != NSOrderedAscending) {
            return  nil;
        }
    }
    return account;
}


+(void)GetAccessTokenWith:(NSString *)code success:(void(^)())success failure:(void(^)(NSError * error))failure{
    NSString *ATurl = @"https://api.weibo.com/oauth2/access_token";
    NSDictionary *param = @{@"client_id":Client_id,@"client_secret":Client_secret,@"grant_type":@"authorization_code",@"code":code,@"redirect_uri":Redirect_uri};

        [LF_HttpTool Post:ATurl parameters:param success:^(id responseObject) {
        LF_AccountModel *accountModel = [LF_AccountModel creatAccountModelWith:responseObject];
        [LF_AccountTool saveAccountModelWith:accountModel];
            if (success) {
                success();
            }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];       
}
@end
