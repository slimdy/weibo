//
//  LF_Tabbar_UITabBar.m
//  LF微博
//
//  Created by slimdy on 2017/4/24.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_Tabbar_UITabBar.h"
#import "UIImage+LF_UIImage.h"
@interface LF_Tabbar_UITabBar()
@property (nonatomic,weak)UIButton *plusBtn;
@end
@implementation LF_Tabbar_UITabBar
//懒加载加号button
-(UIButton *)plusBtn{
    if (_plusBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageWithRenderingOriginalName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageWithRenderingOriginalName:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageWithRenderingOriginalName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithRenderingOriginalName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        _plusBtn = btn;
        
        [self addSubview:_plusBtn];
    }
    return _plusBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnx = 0;
    CGFloat btny = 0;
    CGFloat btnw = self.bounds.size.width/(self.items.count + 1);
    CGFloat btnh = self.bounds.size.height;
    //调整子控件的大小
    NSInteger i = 0;
    for (UIView *tabBtn in self.subviews) {
        if ([tabBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i==2) {
                i = 3;
            }
            btnx = i*btnw;
            tabBtn.frame = CGRectMake(btnx, btny, btnw, btnh);
            i++;
        }
    }
    self.plusBtn.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
//    self.plusBtn.bounds = CGRectMake(0, 0, self.plusBtn.currentBackgroundImage.size.width, self.plusBtn.currentBackgroundImage.size.height);
    
    
}
@end
