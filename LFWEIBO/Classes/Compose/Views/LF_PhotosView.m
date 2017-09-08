//
//  LF_PhotosView.m
//  LFWEIBO
//
//  Created by slimdy on 2017/5/3.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_PhotosView.h"
#import "UIView+Frame.h"
@implementation LF_PhotosView
-(void)setImage:(UIImage *)image{
    _image = image;
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = image;
    [self addSubview:imageView];
}
//每当添加自控加的时候也会调用layout方法，但是在viewdidiload 方法里添加自控见就不会调用
-(void)layoutSubviews{
    [super layoutSubviews];
    NSInteger cols = 3;
    CGFloat margin = 10;
    CGFloat wh = (self.width-(cols-1)*margin)/cols;
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        col = i%cols;
        row = i/cols;
        x =  col * (margin+wh);
        y=  row * (margin+wh);
        imageView.frame = CGRectMake(x, y, wh, wh);
    }
    
}

@end
