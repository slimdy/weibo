//
//  UIImage+LF_UIImage.m
//  LF微博
//
//  Created by slimdy on 2017/4/24.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "UIImage+LF_UIImage.h"

@implementation UIImage (LF_UIImage)
+(instancetype)imageWithRenderingOriginalName:(NSString *)imageName{
   return  [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
+(instancetype)imageWithStretchableImage:(UIImage *)image{
    return [image stretchableImageWithLeftCapWidth:image.size.width *0.5 topCapHeight:image.size.height *0.5];
}
@end
