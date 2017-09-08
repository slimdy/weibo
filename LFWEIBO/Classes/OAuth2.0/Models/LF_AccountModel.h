//
//  LF_AccountModel.h
//  LFWEIBO
//
//  Created by slimdy on 2017/4/26.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LF_AccountModel : NSObject<NSCoding>
    @property (nonatomic,copy)NSString *access_token;
    @property (nonatomic,copy)NSString *expires_in;
    @property (nonatomic,copy)NSString *remind_in;
    @property (nonatomic,copy)NSString *uid;
    @property (nonatomic,copy)NSDate *expires_date;
    @property (nonatomic,copy)NSString *screen_name;
    -(instancetype)initWithDict:(NSDictionary*)dict;
    +(instancetype)creatAccountModelWith:(NSDictionary *)dic;
@end
