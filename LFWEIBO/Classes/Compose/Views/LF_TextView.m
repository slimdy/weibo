//
//  LF_TextView.m
//  LFWEIBO
//
//  Created by slimdy on 2017/5/3.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_TextView.h"
#import "UIView+Frame.h"
@interface LF_TextView()
@property (nonatomic,weak)UILabel *placehoderLabel;
@end
@implementation LF_TextView
-(UILabel *)placehoderLabel{
    if (!_placehoderLabel) {
        UILabel *placehoderLable= [[UILabel alloc]init];
        _placehoderLabel = placehoderLable;
        [self addSubview:placehoderLable];
    }
    return _placehoderLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:13];
    }
    return self;
}
-(void)setPlacehoderHide:(BOOL)placehoderHide{
    _placehoderLabel.hidden = placehoderHide;
}
-(void)setPlacehoder:(NSString *)placehoder{
    _placehoder = placehoder;
    self.placehoderLabel.text = placehoder;
    [_placehoderLabel sizeToFit];
}
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    _placehoderLabel.font = font;
    [_placehoderLabel sizeToFit];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.placehoderLabel.x = 5;
    self.placehoderLabel.y = 8;
}
@end
