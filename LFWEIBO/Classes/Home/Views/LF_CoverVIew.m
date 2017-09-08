//
//  LF_CoverVIew.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/25.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_CoverVIew.h"

@implementation LF_CoverVIew

+(instancetype)show{
    LF_CoverVIew *cover = [[LF_CoverVIew alloc]initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
    return cover;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(coverViewDidClick:)]) {
        [self.delegate coverViewDidClick:self];
    }
}
@end
