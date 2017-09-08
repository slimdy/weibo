//
//  UIImage+LF_UIImage.h
//  LF微博
//
//  Created by slimdy on 2017/4/24.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LF_UIImage)
+(instancetype)imageWithRenderingOriginalName:(NSString *) imageName;
+(instancetype)imageWithStretchableImage:(UIImage *)image;
@end
