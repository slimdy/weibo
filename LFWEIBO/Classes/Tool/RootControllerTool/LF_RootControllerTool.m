//
//  LF_RootControllerTool.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/26.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_RootControllerTool.h"
#import "LF_TabBarController.h"
#import "LF_NewFeatureController.h"
#define VersionKey @"versionNum"
@implementation LF_RootControllerTool
+(void)chooseRootViewController:(UIWindow *)window{
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:VersionKey];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    if ([lastVersion isEqualToString:currentVersion]) {
        //创建TabBarVC
        LF_TabBarController *tabBarVc = [[LF_TabBarController alloc] init];
        
        //设置窗口的根控制器
        window.rootViewController = tabBarVc;
    }else{
        LF_NewFeatureController *newFeatureVC = [[LF_NewFeatureController alloc]init];
        window.rootViewController = newFeatureVC;
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:VersionKey];
    }
    

}
@end
