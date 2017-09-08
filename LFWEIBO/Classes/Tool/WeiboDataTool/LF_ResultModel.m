//
//  LF_ResultModel.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/27.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_ResultModel.h"
#import "LF_WeiboModel.h"
@implementation LF_ResultModel
+(NSDictionary *)objectClassInArray{
    return @{@"statuses":[LF_WeiboModel class]};
}
@end
