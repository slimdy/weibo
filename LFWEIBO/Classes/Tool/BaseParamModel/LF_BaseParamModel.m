//
//  LF_BaseParamModel.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/27.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_BaseParamModel.h"
#import "LF_AccountTool.h"
@implementation LF_BaseParamModel
-(NSString *)access_token{
    if (_access_token == nil) {
        NSString *accesstoken = [LF_AccountTool getAccountModel].access_token;
        if(accesstoken) {
            _access_token = accesstoken;
        }
    }
    return _access_token;
}
@end
