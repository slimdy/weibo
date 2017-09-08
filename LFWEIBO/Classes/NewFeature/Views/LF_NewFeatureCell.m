//
//  LF_NewFeatureCell.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/25.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_NewFeatureCell.h"
#import "UIView+Frame.h"
#import "LF_TabBarController.h"
@interface LF_NewFeatureCell()
@property (nonatomic,weak)UIImageView *imageView;
@property (nonatomic,weak)UIButton *startBtn;
@property (nonatomic,weak)UIButton *shareBtn;
@end

@implementation LF_NewFeatureCell
-(UIImageView *)imageView{
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc]init];
        _imageView = imageView;
        [self.contentView addSubview:imageView];
    }
    return _imageView;
}
-(UIButton *)startBtn{
    if (_startBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"开始微博" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        [self.contentView addSubview:btn];
        _startBtn = btn;
        
    }
    return _startBtn;
}
-(UIButton *)shareBtn{
    if (_shareBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        //设置了选中的图片，但不知为什么无法选中
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shareBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.selected = YES;
        //根据图片和文字，自适应大小
        [btn sizeToFit];
        [self.contentView addSubview:btn];
        _shareBtn = btn;
    }
    return _shareBtn;
}
-(void)shareBtnDidClick:(UIButton *)btn{
    btn.selected = !btn.selected;
}
-(void)startBtnClick:(UIButton *)btn{
    LF_TabBarController *tabBarVC = [[LF_TabBarController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
}
-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}
-(void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count{
    if (indexPath.row == count-1) {
        self.shareBtn.hidden = NO;
        self.startBtn.hidden = NO;
    }else{
        self.shareBtn.hidden = YES;
        self.startBtn.hidden = YES;
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.shareBtn.center = CGPointMake(self.width * 0.5, self.height * 0.7);
    self.startBtn.center = CGPointMake(self.width * 0.5, self.height * 0.8);
}
@end
