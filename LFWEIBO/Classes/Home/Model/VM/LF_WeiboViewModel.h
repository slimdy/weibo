//
//  LF_WeiboViewModel.h
//  LFWEIBO
//
//  Created by slimdy on 2017/4/28.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LF_WeiboModel.h"
@interface LF_WeiboViewModel : NSObject//如果控件内容大小不一且繁多就用视图模型VM
@property (nonatomic,strong)LF_WeiboModel *weibo;
/***原创微博frame及原创微博子控件frame***/
@property (nonatomic,assign) CGRect originalViewFrame;
@property (nonatomic,assign) CGRect o_iconViewFrame;
@property (nonatomic,assign) CGRect o_nameViewFrame;
@property (nonatomic,assign) CGRect o_vipViewFrame;
@property (nonatomic,assign) CGRect o_timeViewFrame;
@property (nonatomic,assign) CGRect o_sourceViewFrame;
@property (nonatomic,assign) CGRect o_textViewFrame;
@property (nonatomic,assign) CGRect o_photoViewFrame;
/***转发微博frame及转发微博子控件frame***/
@property (nonatomic,assign) CGRect reweetViewFrame;
@property (nonatomic,assign) CGRect r_nameViewFrame;
@property (nonatomic,assign) CGRect r_textViewFrame;
@property (nonatomic,assign) CGRect r_photoViewFrame;
/***工具条frame***/
@property (nonatomic,assign) CGRect toolBarViewFrame;
/***整个cell的高度***/
@property (nonatomic,assign) CGFloat cellHeight;
@end
