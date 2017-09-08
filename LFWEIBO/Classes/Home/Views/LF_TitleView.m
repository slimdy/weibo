//
//  LF_TitleView.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/25.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_TitleView.h"
#import "UIView+Frame.h"
@implementation LF_TitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}
-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.currentImage == nil) {
        return;
    }
    
    self.titleLabel.x = 0;
    self.imageView.x = self.titleLabel.width;
}
@end
