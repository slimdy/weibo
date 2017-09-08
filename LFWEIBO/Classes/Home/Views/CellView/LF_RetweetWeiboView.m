//
//  LF_RetweetWeiboView.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/28.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_RetweetWeiboView.h"
#import "LF_WeiboViewModel.h"
#import "LF_WeiboModel.h"
#import "UIImage+LF_UIImage.h"
#import "LF_PhotoView.h"
#define LFNameFont [UIFont systemFontOfSize:13]
#define LFTimeFont [UIFont systemFontOfSize:12]
#define LFSourceFont LFTimeFont
#define LFTextFont [UIFont systemFontOfSize:15]
@interface LF_RetweetWeiboView()
@property (nonatomic,weak)UILabel *nameView;
@property (nonatomic,weak)UILabel *textView;
@property (nonatomic,weak)LF_PhotoView *photoView;
@end
@implementation LF_RetweetWeiboView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableImage:[UIImage imageNamed:@"timeline_retweet_background"]];
        [self setupChildren];
        
    }
    return self;
}
-(void)setupChildren{
    UILabel *nameView = [[UILabel alloc]init];
    self.nameView = nameView;
    nameView.font = LFNameFont;
    [self addSubview:nameView];
    
    UILabel *textView = [[UILabel alloc]init];
    self.textView = textView;
    textView.font = LFTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    
    LF_PhotoView *photoView = [[LF_PhotoView alloc]init];
    self.photoView = photoView;
    [self addSubview:photoView];
    
}
-(void)setWeiboVM:(LF_WeiboViewModel *)weiboVM{
    
    _weiboVM = weiboVM;
    [self setupChildrenFrame];
    [self setupChildrenData];
    
}
-(void)setupChildrenFrame{
    _nameView.frame = _weiboVM.r_nameViewFrame;
    _textView.frame = _weiboVM.r_textViewFrame;
    _photoView.frame = _weiboVM.r_photoViewFrame;
}
-(void)setupChildrenData{
    LF_WeiboModel *weibo = _weiboVM.weibo.retweeted_status;
    _nameView.text = _weiboVM.weibo.retweet_name;
    _textView.text = weibo.text;
    _photoView.picUrlArr = weibo.pic_urls;
}
@end
