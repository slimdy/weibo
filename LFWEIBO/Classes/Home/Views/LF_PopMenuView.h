//
//  LF_PopMenuView.h
//  LFWEIBO
//
//  Created by slimdy on 2017/4/25.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LF_PopMenuView : UIImageView
@property (nonatomic,weak)UIView *contentView;
+(instancetype)showInRect:(CGRect)rect;
+(void)hidePopMenuView;
@end
