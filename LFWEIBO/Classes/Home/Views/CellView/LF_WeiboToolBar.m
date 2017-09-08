//
//  LF_WeiboToolBar.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/28.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_WeiboToolBar.h"
#import "UIView+Frame.h"
#import "UIImage+LF_UIImage.h"
#import "UIView+Frame.h"
#import "LF_WeiboModel.h"
@interface LF_WeiboToolBar()
@property (nonatomic,strong)NSMutableArray *btnArr;
@property (nonatomic,strong)NSMutableArray *divideArr;
@property (nonatomic,weak)UIButton *reweet;
@property (nonatomic,weak)UIButton *comment;
@property (nonatomic,weak)UIButton *like;
@end

@implementation LF_WeiboToolBar
-(NSMutableArray *)divideArr{
    if (_divideArr == nil) {
        _divideArr = [NSMutableArray array];
    }
    return _divideArr;
}
-(NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChildren];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)setupChildren{
    UIButton *reweetBtn = [self setupOneBtnWith:@"timeline_icon_retweet" andTitle:@"转发"];
    _reweet =reweetBtn;
    UIButton *commentBtn = [self setupOneBtnWith:@"timeline_icon_comment" andTitle:@"评论"];
    _comment = commentBtn;
    UIButton *likeBtn  = [self setupOneBtnWith:@"timeline_icon_unlike" andTitle:@"赞"];
    _like = likeBtn;
    for (NSUInteger i = 0; i<2; i++) {
        UIImageView *divide = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:divide];
        [self.divideArr addObject:divide];
    }
}

-(UIButton *)setupOneBtnWith:(NSString *)imageName andTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [self.btnArr addObject:btn];
    [self addSubview:btn];
    return btn;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat BtnX = 0;
    CGFloat BtnY = 0;
    CGFloat BtnW = [UIScreen mainScreen].bounds.size.width/3;
    CGFloat BtnH = self.height;
    
    for (NSUInteger i = 0; i<self.btnArr.count; i ++) {
        UIButton *btn = self.btnArr[i];
        BtnX = i*BtnW;
        btn.frame = CGRectMake(BtnX, BtnY, BtnW, BtnH);
    }
    for (NSUInteger i = 1; i<3; i++) {
        UIButton *BTN = self.btnArr[i];
        UIImageView *divideLine = self.divideArr[i-1];
        divideLine.x = BTN.x;
        
    }
}
-(void)setWeibo:(LF_WeiboModel *)weibo{
    _weibo = weibo;
    [self setBtn:_reweet titile:weibo.reposts_count];
    [self setBtn:_like titile:weibo.attitudes_count];
    [self setBtn:_comment titile:weibo.comments_count];
    
}
-(void)setBtn:(UIButton *)btn titile:(NSUInteger)count{
    if (count == 0) {
        return;
    }
    
    NSString *title = nil;
    if (count>1000) {
        float floatCount = count/10000.0;
        title = [NSString stringWithFormat:@"%.1fW",floatCount];
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else{
        title = [NSString stringWithFormat:@"%lu",(unsigned long)count];
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
@end
