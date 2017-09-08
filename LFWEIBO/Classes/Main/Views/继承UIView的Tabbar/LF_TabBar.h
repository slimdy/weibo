//
//  LF_TabBar.h
//  LFWEIBO
//
//  Created by slimdy on 2017/4/24.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LF_TabBar;
@protocol LF_Tbabr_Delegate <NSObject>
@optional
-(void)lfTabBar:(LF_TabBar *)tabbar didClickButton:(NSInteger)index;
-(void)lfTaBar:(LF_TabBar *)tabbar didClickPlusButton:(UIButton *)plusBtn;
@end
@interface LF_TabBar : UIView
@property (nonatomic,strong)NSArray *items;
@property (nonatomic,weak)id<LF_Tbabr_Delegate>delegate;
@end
