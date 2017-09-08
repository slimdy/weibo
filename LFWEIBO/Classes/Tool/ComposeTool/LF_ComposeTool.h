//
//  LF_ComposeTool.h
//  LFWEIBO
//
//  Created by slimdy on 2017/5/3.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LF_ComposeTool : NSObject
/**
 *  发送文字微博
 *
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)composeText:(NSString *)text WithSuccess:(void (^)())success failure:(void (^)(NSError * error))failure;
/**
 *  发送文字+图片微博
 *  @param image 图片文件
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)composeText:(NSString *)text image:(UIImage *)image WithSuccess:(void (^)())success failure:(void (^)(NSError * error))failure;
@end
