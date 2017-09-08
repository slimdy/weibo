//
//  LF_HttpTool.h
//  LFWEIBO
//
//  Created by slimdy on 2017/4/27.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class LF_uploadImageModel;
@interface LF_HttpTool : NSObject
+(void)Get:(NSString *)url parameters:(id)param success:(void(^)(id responseOject))success failure:(void(^)(NSError *error))failure;
+ (void)Post:(NSString *)url parameters:(id)param success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
+ (void)upload:(NSString *)url parameters:(id)param  uploadParameters:(LF_uploadImageModel *)uploadParam success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
