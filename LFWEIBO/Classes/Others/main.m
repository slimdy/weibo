 //
//  main.m
//  LF微博
//
//  Created by slimdy on 2017/4/24.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//ios程序启动原理
//1.先进入main函数，在调用UIApplicationMain（）；
//2.UIApplicationMain（）的第三个参数也就是现在为NIL的参数，默认是nil也就是创建一个uiapplication对象
//3.在创建appDelegate对象
//4.开启主运行循环。监听用户事件
//5.根据info。plist指定了main。xib，就加载main



//main.storyboard 加载步骤
//1.初始化窗口
//2.加载story.storyboard.[UIStoryboard storyboardWithName:@""]; [storyboar instantiateInitialViewController];默认加载箭头指向的控制器
// 3.把新创建的viewcontroller 作为rootViewController。把控制器的view加载到窗口上。
//4.makekeyavisible  让你的窗口显示
int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
