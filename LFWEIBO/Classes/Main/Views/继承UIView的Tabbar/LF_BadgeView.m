//
//  LF_BadgeView.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/24.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_BadgeView.h"
#import "UIView+Frame.h"
@implementation LF_BadgeView

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
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self sizeToFit];
    }
    return self;
}

-(void)setBadgeValue:(NSString *)BadgeValue{
    _BadgeValue = BadgeValue;
    if (_BadgeValue.length == 0 || [_BadgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
//    CGSize size = [BadgeValue sizeWithFont:[UIFont systemFontOfSize:11]];
   CGSize size =  [BadgeValue sizeWithAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    if (size.width > self.width) {
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }else{
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:BadgeValue forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
    
}
@end
