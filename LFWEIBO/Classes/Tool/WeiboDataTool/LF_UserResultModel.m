//
//  LF_UserResultModel.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/28.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_UserResultModel.h"

@implementation LF_UserResultModel
/**
 *  返回message类别里未读的总数
 *

 */
- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}
/**
 *  返回所有未读的总数
 *
 */
- (int)totoalCount
{
    return self.messageCount + _status + _follower;
}
@end
