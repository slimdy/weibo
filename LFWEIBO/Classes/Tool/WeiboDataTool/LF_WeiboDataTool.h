//
//  LF_WeiboDataTool.h
//  LFWEIBO
//
//  Created by slimdy on 2017/4/27.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LF_WeiboDataTool : NSObject
+(void)GetWeiboWithSinceId:(NSString *)since_id success:(void(^)(NSArray * weibos))success failure:(void(^)(NSError* error))failure;
+(void)getMoreWeiboWithMaxId:(NSString *)max_id success:(void(^)(NSArray * weibos))success failure:(void(^)(NSError* error))failure;
@end
