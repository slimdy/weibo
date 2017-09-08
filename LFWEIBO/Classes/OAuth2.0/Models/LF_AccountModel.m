//
//  LF_AccountModel.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/26.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_AccountModel.h"
#import "MJExtension.h"
#define AccessTokenKey @"accessToken"
#define Expires_inKey @"expires_in"
#define UidKey @"uid"
@interface LF_AccountModel()
@end
@implementation LF_AccountModel
MJCodingImplementation
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict ];
    }
    return  self;
}
+(instancetype)creatAccountModelWith:(NSDictionary *)dic{
    return [[self alloc]initWithDict:dic];
}
//- (void)encodeWithCoder:(NSCoder *)coder
//    {
//        [coder encodeObject:self.access_token forKey: AccessTokenKey];
//        [coder encodeObject:self.uid forKey:UidKey];
//        [coder encodeObject:self.expires_in forKey:Expires_inKey];
//        
//    }
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super init]) {
//       self.access_token =  [aDecoder decodeObjectForKey:AccessTokenKey];
//        self.uid = [aDecoder decodeObjectForKey:UidKey];
//        self.expires_in = [aDecoder decodeObjectForKey:Expires_inKey];
//    }
//    return self;
//}
-(void)setExpires_in:(NSString *)expires_in{
    _expires_in = expires_in;
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}
@end
