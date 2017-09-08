//
//  LF_WeiboViewModel.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/28.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_WeiboViewModel.h"
#import "LF_WeiboModel.h"
#import "LF_UserModel.h"
#define LFMargin 10
#define LFNameFont [UIFont systemFontOfSize:13]
#define LFTimeFont [UIFont systemFontOfSize:12]
#define LFSourceFont LFTimeFont
#define LFTextFont [UIFont systemFontOfSize:15]
@implementation LF_WeiboViewModel
-(void)setWeibo:(LF_WeiboModel *)weibo{
    _weibo = weibo;
    [self setupOriginalViewFrame];
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    if (weibo.retweeted_status) {
        [self setupRetweetViewFrame];
        toolBarY = CGRectGetMaxY(_reweetViewFrame);
    }
    CGFloat toolBarX = 0;
    CGFloat toolW = [UIScreen mainScreen].bounds.size.width;
    CGFloat toolH = 35;
    _toolBarViewFrame = CGRectMake(toolBarX, toolBarY, toolW, toolH);
    
    _cellHeight = CGRectGetMaxY(_toolBarViewFrame);
    
  
}
-(void)setupOriginalViewFrame{
    CGFloat iconX = LFMargin;
    CGFloat iconY = LFMargin;
    CGFloat iconW = 35;
    CGFloat iconH = iconW;
    _o_iconViewFrame = (CGRect){{iconX,iconY},{iconW,iconH}};
    
    CGFloat nameX = CGRectGetMaxX(_o_iconViewFrame)+LFMargin;
    CGFloat nameY = iconY;
    CGSize nameWH = [_weibo.user.name sizeWithFont:LFNameFont];
    _o_nameViewFrame = (CGRect){{nameX,nameY},nameWH};
    
    if (_weibo.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_o_nameViewFrame)+LFMargin;
        CGFloat vipY = nameY;
        CGSize vipWH = (CGSize){14,14};
       _o_vipViewFrame = (CGRect){{vipX,vipY},vipWH};
    }
    
    
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_o_iconViewFrame)+LFMargin * 1.5;
    CGFloat textW = [UIScreen mainScreen].bounds.size.width - 2*LFMargin;
    CGSize textWH = [_weibo.text sizeWithFont:LFTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _o_textViewFrame = (CGRect){{textX,textY},textWH};
    CGFloat H = 0;
    
    if (_weibo.pic_urls.count) {
        CGFloat photoX = LFMargin;
        CGFloat photoY = CGRectGetMaxY(_o_textViewFrame)+LFMargin;
        CGSize  photoSize = [self photoViewSizeWithCount:_weibo.pic_urls.count];
        _o_photoViewFrame = (CGRect){{photoX,photoY},photoSize};
         H = CGRectGetMaxY(_o_photoViewFrame) +LFMargin;
//        NSLog(@"%f",H);
    }else{
         H = CGRectGetMaxY(_o_textViewFrame)+LFMargin;
//        NSLog(@"%f",H);
    }

    CGFloat X = 0;
    CGFloat Y = LFMargin;
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    
    _originalViewFrame = CGRectMake(X, Y, W, H);
    
    
}

-(void)setupRetweetViewFrame{
    CGFloat nameX = LFMargin;
    CGFloat nameY = LFMargin;
    CGSize nameWH = [_weibo.retweet_name sizeWithFont:LFNameFont];
    _r_nameViewFrame = (CGRect){{nameX,nameY},nameWH};
    
    CGFloat textX = LFMargin;
    CGFloat textY = 1.2*LFMargin +CGRectGetMaxY(_r_nameViewFrame);
    CGFloat textW = [UIScreen mainScreen].bounds.size.width- 2*LFMargin;
    CGSize textWH = [_weibo.retweeted_status.text sizeWithFont:LFTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _r_textViewFrame = (CGRect){{textX,textY},textWH};
    CGFloat H = 0;
    if (_weibo.retweeted_status.pic_urls.count) {
        CGFloat photoX = LFMargin;
        CGFloat photoY = CGRectGetMaxY(_r_textViewFrame)+LFMargin;
        CGSize  photoSize = [self photoViewSizeWithCount:_weibo.retweeted_status.pic_urls.count];
        _r_photoViewFrame = (CGRect){{photoX,photoY},photoSize};
        H = CGRectGetMaxY(_r_photoViewFrame) +LFMargin;
    }else{
        H = CGRectGetMaxY(_r_textViewFrame)+LFMargin;
    }
    CGFloat X = 0;
    CGFloat Y = CGRectGetMaxY(_originalViewFrame);
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    _reweetViewFrame = CGRectMake(X, Y, W, H);
    
}
-(CGSize)photoViewSizeWithCount:(NSInteger)count{
    
    int col = count==4?2:3;
    int row = (count-1)/col+1;
    CGFloat WH = 70;
    CGFloat w = col * WH + (col-1)*LFMargin;
    CGFloat h = row * WH + (row-1)*LFMargin;
    CGSize wh = CGSizeMake(w, h);
    return wh;
}
@end
