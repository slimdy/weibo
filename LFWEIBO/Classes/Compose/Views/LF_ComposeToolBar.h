//
//  LF_ComposeToolBar.h
//  LFWEIBO
//
//  Created by slimdy on 2017/5/3.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LF_ComposeToolBar;
@protocol LF_ComposeToolBarDelegate <NSObject>
@optional
-(void)composeToolBar:(LF_ComposeToolBar *)composeToolBar didClickBtn:(UIButton *)clickBtn;
@end
@interface LF_ComposeToolBar : UIImageView
@property (nonatomic,strong)NSArray *buttonImages;
@property (nonatomic,weak)id<LF_ComposeToolBarDelegate> delegate;
@end
