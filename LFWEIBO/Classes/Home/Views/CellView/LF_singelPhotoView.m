//
//  LF_singelPhotoView.m
//  LFWEIBO
//
//  Created by slimdy on 2017/5/3.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_singelPhotoView.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
@interface LF_singelPhotoView()
@property (nonatomic,weak)UIImageView *gifView;
@end
@implementation LF_singelPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        UIImageView *gifView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        self.gifView = gifView;
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height-self.gifView.height; 
}
-(void)setPhoto:(LF_PhotoModel *)photo{
    _photo = photo;
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    if ([[photo.thumbnail_pic absoluteString] hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}
@end
