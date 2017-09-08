//
//  LF_UserTool.h
//  LFWEIBO
//
//  Created by slimdy on 2017/4/28.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LF_UserResultModel.h"
@interface LF_UserTool : NSObject
/**
 *  获得用户未读消息
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)getUnreadWithSuccess:(void (^)(id  resultModel))success failure:(void (^)(NSError * error))failure isUnread:(BOOL)isUnread;
@end
