//
//  LF_TabBarButton.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/24.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_TabBarButton.h"
#import "LF_BadgeView.h"
#import "UIView+Frame.h"
@interface LF_TabBarButton()
@property (nonatomic,weak) LF_BadgeView*badgeView;
@end
@implementation LF_TabBarButton
// 重写setHighlighted，取消高亮做的事情
- (void)setHighlighted:(BOOL)highlighted{}

-(LF_BadgeView *)badgeView{
    if (_badgeView == nil) {
        LF_BadgeView *btn = [LF_BadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        _badgeView = btn;
    }
    return _badgeView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置按钮字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        //设置图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        //设置标题居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //设置文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

-(void)setItem:(UITabBarItem *)item{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];//写这一步 仅仅是为了让self.badgeview的Value 置为0
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    self.badgeView.BadgeValue = self.item.badgeValue;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //图片
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * 0.7;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //按钮标题
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = imageW;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //badgeView
    self.badgeView.x=self.width-self.badgeView.width-10;
    self.badgeView.y=0;
    
}
@end
