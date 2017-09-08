//
//  LF_PhotoView.m
//  LFWEIBO
//
//  Created by slimdy on 2017/5/2.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_PhotoView.h"
#import "LF_PhotoModel.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "LF_PhotoModel.h"
#import "LF_singelPhotoView.h"
@implementation LF_PhotoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupImageViews];
    }
    return self;
}
-(void)setupImageViews{
    for (NSInteger i = 0; i < 9; i++) {
        LF_singelPhotoView *imageView = [[LF_singelPhotoView alloc]init];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        imageView.tag = i;
        
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
    }
    
}
-(void)imageClick:(UITapGestureRecognizer *)tap{
    UIImageView *view = tap.view;
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc]init];
    int i = 0;
    NSMutableArray *arr= [NSMutableArray array];
    for (LF_PhotoModel *photo in self.picUrlArr) {
        MJPhoto *p = [[MJPhoto alloc]init];
        NSString *strUrl = [photo.thumbnail_pic.absoluteString stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        p.url = [NSURL URLWithString:strUrl];
        p.index = i;
        p.srcImageView = tap.view;
        i++;
        [arr addObject:p];
    }
    brower.currentPhotoIndex = view.tag;
    brower.photos = arr;
    [brower show];
}
-(void)setPicUrlArr:(NSArray *)picUrlArr{
    _picUrlArr = picUrlArr;
    NSInteger count = self.subviews.count;
    for (NSInteger i = 0; i< count; i++) {
        LF_singelPhotoView *view = self.subviews[i];
        if (i < picUrlArr.count) {
            view.hidden = NO;
            LF_PhotoModel *photo = picUrlArr[i];
            view.photo = photo;
            
        }else{
            view.hidden = YES;
        }
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat wh = 70;
    CGFloat margin = 10;
    NSInteger col = 0;
    NSInteger row = 0;
    NSInteger cols = self.picUrlArr.count == 4?2:3;
    for (NSInteger i = 0 ; i < self.picUrlArr.count; i++) {
        col = i%cols;
        row = i/cols;
        UIImageView *imageView = self.subviews[i];
        x = col*(wh + margin);
        y = row*(wh + margin);
        imageView.frame = CGRectMake(x, y, wh, wh);
    }
}
@end
