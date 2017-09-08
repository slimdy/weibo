//
//  LF_HttpTool.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/27.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_HttpTool.h"
#import "LF_uploadImageModel.h"
@implementation LF_HttpTool
static AFHTTPRequestOperationManager *_manager = nil;
+ (void)initialize
{
    if (self == [LF_HttpTool class]) {
        _manager = [AFHTTPRequestOperationManager manager];
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 10.f;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
}
+(void)Get:(NSString *)url parameters:(id)param success:(void(^)(id responseOject))success failure:(void(^)(NSError *error))failure{
    [_manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)Post:(NSString *)url parameters:(id)param success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    [_manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)upload:(NSString *)url parameters:(id)param  uploadParameters:(LF_uploadImageModel *)uploadParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    [_manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mineType];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
