//
//  LF_UserParamModel.h
//  LFWEIBO
//
//  Created by slimdy on 2017/4/27.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_BaseParamModel.h"

@interface LF_UserParamModel : LF_BaseParamModel
/**
 *  当前登录用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;
@end
