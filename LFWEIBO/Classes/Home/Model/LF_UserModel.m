//
//  LF_UserModel.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/26.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_UserModel.h"

@implementation LF_UserModel
-(void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    _vip = mbtype>2;
}
@end
