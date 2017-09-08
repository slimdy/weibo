//
//  LF_ParametersModel.h
//  LFWEIBO
//
//  Created by slimdy on 2017/4/27.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LF_BaseParamModel.h"
@interface LF_ParametersModel : LF_BaseParamModel

@property (nonatomic,copy) NSString *since_id;
@property (nonatomic,copy) NSString *max_id;
@end
