//
//  UIBarButtonItem+LF_barButtonItem.h
//  LFWEIBO
//
//  Created by slimdy on 2017/4/25.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LF_barButtonItem)
+(instancetype)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forEvent:(UIControlEvents)event;
@end
