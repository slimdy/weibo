//
//  LF_ComposeTool.m
//  LFWEIBO
//
//  Created by slimdy on 2017/5/3.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_ComposeTool.h"
#import "LF_HttpTool.h"
#import "LF_composeParamModel.h"
#import "LF_uploadImageModel.h"
#define LFUpdateUrl @"https://api.weibo.com/2/statuses/update.json"
#define LFUploadPicUrl @"https://upload.api.weibo.com/2/statuses/upload.json"
#import "MJExtension.h"
@implementation LF_ComposeTool
+(void)composeText:(NSString *)text WithSuccess:(void (^)())success failure:(void (^)(NSError * error))failure{
    LF_composeParamModel *param = [[LF_composeParamModel alloc]init];
    if (param.access_token) {
        param.status = text;
    }
//    NSLog(@"%@--%@",param.access_token,param.status);
    [LF_HttpTool Post:LFUpdateUrl parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)composeText:(NSString *)text image:(UIImage *)image WithSuccess:(void (^)())success failure:(void (^)(NSError * error))failure{
    LF_composeParamModel *param = [[LF_composeParamModel alloc]init];
    if (param.access_token) {
        param.status = text;
    }
    NSLog(@"%@--%@",param.access_token,param.status);
    LF_uploadImageModel *uploadParam = [[LF_uploadImageModel alloc]init];
    uploadParam.data = UIImagePNGRepresentation(image);
    uploadParam.mineType = @"image/png";
    uploadParam.name = @"pic";
    uploadParam.fileName = @"image.png";
    [LF_HttpTool upload:LFUploadPicUrl parameters:param.keyValues  uploadParameters:uploadParam success:^(id responseObject) {
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
