//
//  LF_OriginalWeiboView.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/28.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_OriginalWeiboView.h"
#import "LF_WeiboViewModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+LF_UIImage.h"
#import "LF_PhotoView.h"
#define LFNameFont [UIFont systemFontOfSize:13]
#define LFTimeFont [UIFont systemFontOfSize:12]
#define LFSourceFont LFTimeFont
#define LFTextFont [UIFont systemFontOfSize:15]
#define LFMargin 10
@interface LF_OriginalWeiboView()
@property (nonatomic,weak)UIImageView *iconView;
@property (nonatomic,weak)UILabel *nameView;
@property (nonatomic,weak)UILabel *timeView;
@property (nonatomic,weak)UILabel *sourceView;
@property (nonatomic,weak)UILabel *textView;
@property (nonatomic,weak)UIImageView *vipView;
@property (nonatomic,weak)LF_PhotoView *photoView;

@end

@implementation LF_OriginalWeiboView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        [self setUpChildren];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableImage:[UIImage imageNamed:@"timeline_card_top_background"]];
    }
    return self;
}

-(void)setUpChildren{
    UILabel *nameView = [[UILabel alloc]init];
    nameView.font = LFNameFont;
    self.nameView = nameView;
    [self addSubview:nameView];
    
    UILabel *timeView = [[UILabel alloc]init];
    self.timeView = timeView;
    timeView.font = LFTimeFont;
    [self addSubview:timeView];
    
    UILabel *sourceView = [[UILabel alloc]init];
    self.sourceView = sourceView;
    sourceView.font = LFSourceFont;
    [self addSubview:sourceView];
    
    UILabel *textView = [[UILabel alloc]init];
    self.textView = textView;
    textView.font = LFTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    
    UIImageView *iconView = [[UIImageView alloc]init];
    self.iconView = iconView;
    [self addSubview:iconView];
    
    UIImageView *vipView = [[UIImageView alloc]init];
    self.vipView = vipView;
    [self addSubview:vipView];
    
    LF_PhotoView *photoView = [[LF_PhotoView alloc]init];
    self.photoView = photoView;
    [self addSubview:photoView];
    
}
-(void)setWeiboVM:(LF_WeiboViewModel *)weiboVM{
    _weiboVM = weiboVM;
    [self setUpChildrenFrame];
    [self setUpChildrenData];;
}
-(void)setUpChildrenFrame{
    _iconView.frame = _weiboVM.o_iconViewFrame;
    _nameView.frame = _weiboVM.o_nameViewFrame;
    _vipView.frame = _weiboVM.o_vipViewFrame;
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameView.frame)+LFMargin *0.5;
    CGSize timeWH = [_weiboVM.weibo.created_at sizeWithFont:LFTimeFont];
    _timeView.frame = (CGRect){{timeX,timeY},timeWH};
    CGFloat soureX = CGRectGetMaxX(_timeView.frame)+LFMargin;
    CGFloat soureY = CGRectGetMaxY(_nameView.frame)+LFMargin *0.5;
    CGSize  soureWH = [_weiboVM.weibo.source sizeWithFont:LFSourceFont];
    _sourceView.frame = (CGRect){{soureX,soureY},soureWH};
   
    _textView.frame = _weiboVM.o_textViewFrame;
    _photoView.frame = _weiboVM.o_photoViewFrame;
}
-(void)setUpChildrenData{
    LF_WeiboModel *weibo = _weiboVM.weibo;
    [_iconView sd_setImageWithURL:weibo.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    if (weibo.user.vip) {
        _nameView.textColor = [UIColor orangeColor];
        NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",weibo.user.mbrank];
        _vipView.image = [UIImage imageNamed:imageName];
        
    }else{
        _nameView.textColor = [UIColor blackColor];
        _vipView.image = [UIImage imageNamed:@"common_icon_membership_expired"];
    }
    _nameView.text = weibo.user.name;
    
   
    _timeView.text = weibo.created_at;
    
    _sourceView.text = weibo.source;
    
    _textView.text = weibo.text;
    
    _photoView.picUrlArr = weibo.pic_urls;
    
}
@end
