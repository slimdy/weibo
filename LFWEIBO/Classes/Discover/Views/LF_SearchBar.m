//
//  LF_SearchBar.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/25.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_SearchBar.h"
#import "UIView+Frame.h"
#import "UIImage+LF_UIImage.h"
@implementation LF_SearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.background = [UIImage imageWithStretchableImage:[UIImage imageNamed:@"searchbar_textfield_background"]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        self.font = [UIFont systemFontOfSize:13];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.width +=10;
        self.leftView = imageView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end
