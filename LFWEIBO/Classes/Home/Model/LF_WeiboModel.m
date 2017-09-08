//
//  LF_WeiboModel.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/26.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_WeiboModel.h"
#import "NSDate+MJ.h"
#import "NSString+LFFunc.h"
@implementation LF_WeiboModel
+(NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[LF_PhotoModel class]};
}
/**
 *  在得到新浪数据里的时间后，将它做一些处理，
 *
 *  
 */
-(NSString *)created_at{
    //分析：先判断是今年还是去年 如果是去年则显示 2015-08-13 15：17 yyyy-MM-dd HH:mm
    //     如果是今天 则要分情况，昨天则显示 昨天 HH:mm 两天前 MM-dd HH:mm
    //     今天又要分情况 1min>time>1s 刚刚  1h>time>1min mm分钟前  1day>time>1h HH小时前
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *created_at = [fmt dateFromString:_created_at];
    if ([created_at isThisYear]) {//是今年
        if ([created_at isToday]) {
            NSDateComponents *cmp = [created_at deltaWithNow];
            //LFLog(@"%ld--%ld--%ld",cmp.hour,cmp.minute,cmp.second);
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",cmp.hour];
            }else if(cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟前",cmp.minute];
            }else{
                return @"刚刚";
            }
            
        }else if ([created_at isYesterday]){
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:created_at];
        }else{//两天前
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:created_at];
        }
        
        
    }else{//非今年
        fmt.dateFormat =@"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:created_at];
    }
    return _created_at;
}
-(void)setSource:(NSString *)source{
    _source = [NSString stringWithFormat:@"来自于%@",[source filterHTML:source]];
}
-(void)setRetweeted_status:(LF_WeiboModel *)retweeted_status{
    _retweeted_status = retweeted_status;
    _retweet_name = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
}
@end
