//
//  AppDelegate.m
//  LF微博
//
//  Created by slimdy on 2017/4/24.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "AppDelegate.h"
#import "LF_OAuthViewController.h"
#import "LF_AccountTool.h"
#import "LF_RootControllerTool.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>
/*
 LaunchScreen 程序碰到模拟器尺寸不对，大概率是这个的问题。因为默认的模拟器尺寸根据启动图片来的。
 看需求 如果使用固定图片当作是启动图片则使用不要使用lanchscreen ，如果要使用动画或者是其他跟多效果的启动页面就使用lanchscreen。  
 lanchscreen的优先级大于启动图片
 
 */
@interface AppDelegate ()
@property (nonatomic,strong) AVAudioPlayer*player;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //注册bageValue 的 通知
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:settings];
    
    
    // Override point for customization after application launch.
    //创建
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    if ([LF_AccountTool getAccountModel]) {
        [LF_RootControllerTool chooseRootViewController:self.window];
    }else{
      self.window.rootViewController = [[LF_OAuthViewController alloc]init];
        
    }
    
    
    
    //显示窗口
    [self.window makeKeyAndVisible];//这个方法的底层：让1.self.window.hidden = NO;2.application.keyWindow = self.winodw;
    return YES;
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence" withExtension:@"mp3"];
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    [self.player prepareToPlay];
    self.player.numberOfLoops = -1;
    [self.player play];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
