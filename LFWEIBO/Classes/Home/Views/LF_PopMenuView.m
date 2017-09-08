//
//  LF_PopMenuView.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/25.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_PopMenuView.h"
#import "UIImage+LF_UIImage.h"
#import "UIView+Frame.h"
#define LFKeyWindow [UIApplication sharedApplication].keyWindow
@implementation LF_PopMenuView

+(instancetype)showInRect:(CGRect)rect{
    LF_PopMenuView *popMenuView = [[LF_PopMenuView alloc]initWithFrame:rect];
    popMenuView.userInteractionEnabled = YES;
    popMenuView.image = [UIImage imageWithStretchableImage:[UIImage imageNamed:@"popover_background"]];
    [LFKeyWindow addSubview:popMenuView];
    return popMenuView;
    
}
+(void)hidePopMenuView{
    
    for (UIView *popView in LFKeyWindow.subviews) {
        if ([popView isKindOfClass:self]) {
            [popView removeFromSuperview];
        }
    }
}
-(void)setContentView:(UIView *)contentView{
    [_contentView removeFromSuperview];
    _contentView = contentView;
    _contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentView];
}
-(void)layoutSubviews{
    CGFloat margin = 5;
    CGFloat x= margin;
    CGFloat y = 2*margin;
    CGFloat w = self.width-2*margin;
    CGFloat h = self.height-3*margin;
    self.contentView.frame = CGRectMake(x, y, w, h);
}
@end
