//
//  LF_CoverVIew.h
//  LFWEIBO
//
//  Created by slimdy on 2017/4/25.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LF_CoverVIew;
@protocol LF_CoverViewDelegate <NSObject>

-(void)coverViewDidClick:(LF_CoverVIew *)coverView;

@end
@interface LF_CoverVIew : UIView
@property (nonatomic,weak)id<LF_CoverViewDelegate> delegate;
+(instancetype)show;

@end
