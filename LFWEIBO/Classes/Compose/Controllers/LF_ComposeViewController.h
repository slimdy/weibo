//
//  LF_ComposeViewController.h
//  LFWEIBO
//
//  Created by slimdy on 2017/5/3.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LF_ComposeViewController;
@protocol LF_ComposeViewControllerDelegate<NSObject>
@optional
-(void)composeViewController:(LF_ComposeViewController *)composeViewController;
@end
@interface LF_ComposeViewController : UIViewController
@property (nonatomic,weak)id<LF_ComposeViewControllerDelegate> delegate;
@end
