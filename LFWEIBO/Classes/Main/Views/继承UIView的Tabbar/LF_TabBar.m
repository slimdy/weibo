//
//  LF_TabBar.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/24.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_TabBar.h"
#import "LF_TabBarButton.h"
#import "UIImage+LF_UIImage.h"
@interface LF_TabBar ()
@property (nonatomic,weak)UIButton *plusBtn;
@property (nonatomic,strong)NSMutableArray *buttons;
@property (nonatomic,weak)UIButton *selectedBtn;
@end
@implementation LF_TabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//懒加载加号button
-(UIButton *)plusBtn{
if (_plusBtn == nil) {
UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
[btn setImage:[UIImage imageWithRenderingOriginalName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateNormal];
[btn setImage:[UIImage imageWithRenderingOriginalName:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
[btn setBackgroundImage:[UIImage imageWithRenderingOriginalName:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithRenderingOriginalName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(plusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _plusBtn = btn;
    
    [self addSubview:_plusBtn];
}
    return _plusBtn;
}
-(NSMutableArray *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
-(void)plusBtnClick:(UIButton *)plusBtn{
    if ([self.delegate respondsToSelector:@selector(lfTaBar:didClickPlusButton:)]) {
        [self.delegate lfTaBar:self didClickPlusButton:plusBtn];
    }
}
-(void)setItems:(NSArray *)items{
    _items = items;
    //循环创建uibutton
    for (UITabBarItem *item in items) {
        LF_TabBarButton *btn = [LF_TabBarButton buttonWithType:UIButtonTypeCustom];
        btn.item = item;
        btn.tag = self.buttons.count;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        if (btn.tag == 0) {
            [self btnClick:btn];
        }
        [self addSubview:btn];
        [self.buttons addObject:btn];
        
    }
    
}
-(void)btnClick:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    if ([self.delegate respondsToSelector:@selector(lfTabBar:didClickButton:)]) {
        [self.delegate lfTabBar:self didClickButton:btn.tag];
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w/(self.items.count+1);
    CGFloat btnH = h;
    
    NSInteger i = 0;
    
    for (LF_TabBarButton *btn  in self.buttons) {
        if (i == 2) {
            i=3;
        }
        btnX = i*btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
    self.plusBtn.center = CGPointMake(w/2, h/2);
}
@end
