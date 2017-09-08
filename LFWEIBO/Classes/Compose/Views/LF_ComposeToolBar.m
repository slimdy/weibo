//
//  LF_ComposeToolBar.m
//  LFWEIBO
//
//  Created by slimdy on 2017/5/3.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_ComposeToolBar.h"
#import "UIImage+LF_UIImage.h"
@interface LF_ComposeToolBar()
@property (nonatomic,strong)NSMutableArray *btnArr;
@end
@implementation LF_ComposeToolBar
-(NSMutableArray *)btnArr{
    if (!_btnArr) {
        NSMutableArray *btnArr = [NSMutableArray array];
        _btnArr = btnArr;
    }
    return _btnArr;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
    }
    return self;
}
-(void)setupAllChildren{
    if (!_buttonImages.count) {
        return;
    }
    for (NSInteger i = 0; i<_buttonImages.count; i++) {
       NSString *imageName = _buttonImages[i];
        //compose_toolbar_picture_highlighted
        NSString *highlightImageName = [NSString stringWithFormat:@"%@_highlighted",imageName];
        UIButton *btn = [self barButtonWithImage:[UIImage imageNamed:imageName] highImage:[UIImage imageNamed:highlightImageName] target:self action:@selector(btnClick:) forEvent:UIControlEventTouchUpInside];
        btn.tag = i;
        [self addSubview:btn];
        [self.btnArr addObject:btn];
    }
}
-(void)setButtonImages:(NSArray *)buttonImages{
    _buttonImages = buttonImages;
    [self setupAllChildren];
}
-(void)btnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickBtn:)]) {
        [self.delegate composeToolBar:self didClickBtn:btn];
    }
}
-(UIButton *)barButtonWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forEvent:(UIControlEvents)event{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat y = 0;
    CGFloat h = self.bounds.size.height;
    CGFloat x= 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width/self.buttonImages.count;
    
    NSInteger i = 0;
    NSLog(@"%@",self.btnArr);
    for (UIButton *button in self.btnArr) {
        x = i *w;
        button.frame = CGRectMake(x, y, w, h);
        i++;
    }
}
@end
