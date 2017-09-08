//
//  LF_UserTool.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/28.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_UserTool.h"
#import "LF_HttpTool.h"
#import "LF_AccountTool.h"
#import "LF_UserParamModel.h"
#define LFUreadUrl @"https://rm.api.weibo.com/2/remind/unread_count.json"
#define LFUserInfo @"https://api.weibo.com/2/users/show.json"
#import "MJExtension.h"
#import "LF_UserInfoModel.h"
@implementation LF_UserTool
+(void)getUnreadWithSuccess:(void (^)(id  resultModel))success failure:(void (^)(NSError * error))failure isUnread:(BOOL)isUnread{
    LF_UserParamModel *param = [[LF_UserParamModel alloc]init];
    if (param.access_token) {
        param.uid =[LF_AccountTool getAccountModel].uid;
    }
//    NSLog(@"%@?access_toke=%@&uid=%@",LFUreadUrl,param.access_token,param.uid);
    NSString *url = nil;
    if (isUnread) {
        url = LFUreadUrl;
    }else{
        url = LFUserInfo;
    }
    [LF_HttpTool Get:url parameters:param.keyValues success:^(id responseOject) {
        
        if (isUnread) {
           LF_UserResultModel *result = [LF_UserResultModel objectWithKeyValues:responseOject];
            if (success) {
                success(result);
            }
        }else{
            LF_UserInfoModel *result = [LF_UserInfoModel objectWithKeyValues:responseOject];
            if (success) {
                success(result);
            }
        }
        
      
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
