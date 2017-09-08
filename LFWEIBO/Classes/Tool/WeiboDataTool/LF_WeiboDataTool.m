//
//  LF_WeiboDataTool.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/27.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_WeiboDataTool.h"
#import "LF_HttpTool.h"
#import "LF_ParametersModel.h"
#import "LF_ResultModel.h"
#define WeiBoBaseUrl @"https://api.weibo.com/2/statuses/home_timeline.json"
@implementation LF_WeiboDataTool
+(void)GetWeiboWithSinceId:(NSString *)since_id success:(void(^)(NSArray * weibos))success failure:(void(^)(NSError* error))failure{
   // NSLog(@"%@",since_id);

    LF_ParametersModel *param = [[LF_ParametersModel alloc]init];
    if (param.access_token) {
        if (since_id) {
            param.since_id = since_id;
        }
    }
    [LF_HttpTool Get:WeiBoBaseUrl parameters:param.keyValues success:^(id responseOject) {
        if (success) {
          LF_ResultModel *result =  [LF_ResultModel objectWithKeyValues:responseOject];

            success(result.statuses);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}
+(void)getMoreWeiboWithMaxId:(NSString *)max_id success:(void(^)(NSArray * weibos))success failure:(void(^)(NSError* error))failure{
    LF_ParametersModel *param = [[LF_ParametersModel alloc]init];
    if (param.access_token) {
        if (max_id) {
            max_id = [NSString stringWithFormat:@"%lld",[max_id longLongValue]-1];
            param.max_id = max_id;
        }
    }
    [LF_HttpTool Get:WeiBoBaseUrl parameters:param.keyValues success:^(id responseOject) {
        if (success) {
            LF_ResultModel *result =  [LF_ResultModel objectWithKeyValues:responseOject];
            
            success(result.statuses);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
