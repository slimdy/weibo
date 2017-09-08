//
//  LF_TabBarController.m
//  LF微博
//
//  Created by slimdy on 2017/4/24.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_TabBarController.h"
#import "UIImage+LF_UIImage.h"
#import "LF_TabBar.h"
#import "LF_HomeTableViewController.h"
#import "LF_MessageTableViewController.h"
#import "LF_DiscoverTableViewController.h"
#import "LF_ProfileTableViewController.h"
#import "LF_NavigationController.h"
#import "LF_UserTool.h"
#import "LF_ComposeViewController.h"
@interface LF_TabBarController ()<LF_Tbabr_Delegate,LF_ComposeViewControllerDelegate>
@property (nonatomic,strong)NSMutableArray *items;
@property (nonatomic,strong)LF_HomeTableViewController *home;
@property (nonatomic,strong)LF_MessageTableViewController *message;
@property (nonatomic,strong)LF_ProfileTableViewController *profile;
@property (nonatomic,strong)LF_DiscoverTableViewController *dicover;
@property (nonatomic,strong)NSTimer  *timer;
@end

@implementation LF_TabBarController
#pragma mask --这个是用于继承自UITabbar的LF_tabbar时需要用于改变字体颜色的富文本方法
//当第一次使用本类，和子类的时候调用
//设置全局的uitabbar按钮的文字颜色
//+(void)initialize{
//    //获取所有的uitabbaritem
////    UITabBarItem *tabbarItems  =  [UITabBarItem appearance]; //只要一个类遵守UIAppearance 就能获取全局外观
//    UITabBarItem *tabbarItems = [UITabBarItem appearanceWhenContainedIn:self, nil];//这个只是修改自己的tabbar的外观
//    //如果通过模型设置控件的文字，只能通过文本属性也就是说 富文本（颜色，字体，空心，，阴影，图文混排）;
//    NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
//    attDic[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    [tabbarItems setTitleTextAttributes:attDic forState:UIControlStateSelected];
//    
//}
//加载类到内存时调用，程序一使用就类的内存 在main之前
//+(void)load{
//    
//}
//UIViewController 的view 是懒加载的，而tabbarController在一创建就会加载View
#pragma mask -------end






-(NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加4个子控制器
    [self addAllChildViewControllers];
 #pragma mask --这个是用于继承自UITabbar的LF_tabbar时需要用于替换系统自带的tabbar
    //把系统默认的tabbar 换成 自定义的tabbar
//    LF_Tabbar *LFTabbar = [[LF_Tabbar alloc]init];
//    [self setValue:LFTabbar forKeyPath:@"tabBar"];//因为self.tabbar属性是只读的，不能修改就用 KVC的方法赋值 KVC的底层是消息发送机制
#pragma mask ---end
    [self setupTabar];
    //设置未读数
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getUreadMessage) userInfo:nil repeats:YES];
    
    
    
}
-(void)getUreadMessage{
    [LF_UserTool getUnreadWithSuccess:^(LF_UserResultModel *resultModel) {
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",resultModel.status];
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",resultModel.messageCount];
        self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",resultModel.follower];
        [UIApplication sharedApplication].applicationIconBadgeNumber = resultModel.totoalCount;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    } isUnread:YES];
}
-(void)setupTabar{
    LF_TabBar *tabBar = [[LF_TabBar alloc]initWithFrame:self.tabBar.bounds];
    tabBar.backgroundColor = [UIColor whiteColor];
    tabBar.items = self.items;
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated]; //这个父类的函数里面干了 给self.tabbar 添加 uitabbarBUTTON
    //注意 这willappear 后于 didload 函数 触发 所以在这添加
    
}
//添加所有的子控制器
-(void)addAllChildViewControllers{
    //tabbarController的子控制器有四个
    //首页
    self.home = [[LF_HomeTableViewController alloc]init];
    [self addOneChildViewControllerWith:self.home Image:[UIImage imageWithRenderingOriginalName:@"tabbar_home"] SelectedImage:[UIImage imageWithRenderingOriginalName:@"tabbar_home_selected"] title:@"首页"];
    
    //消息
    self.message= [[LF_MessageTableViewController alloc]init];
    [self addOneChildViewControllerWith:self.message Image:[UIImage imageWithRenderingOriginalName:@"tabbar_message_center"] SelectedImage:[UIImage imageWithRenderingOriginalName:@"tabbar_message_center_selected"] title:@"消息"];
    //发现
    self.dicover = [[LF_DiscoverTableViewController alloc]init];
    [self addOneChildViewControllerWith:self.dicover Image:[UIImage imageWithRenderingOriginalName:@"tabbar_discover"] SelectedImage:[UIImage imageWithRenderingOriginalName:@"tabbar_discover_selected"] title:@"发现"];
    //我
    self.profile  = [[LF_ProfileTableViewController alloc]init];
    [self addOneChildViewControllerWith:self.profile Image:[UIImage imageWithRenderingOriginalName:@"tabbar_profile"] SelectedImage:[UIImage imageWithRenderingOriginalName:@"tabbar_profile_selected"] title:@"我"];
}

//添加一个子控制器  多态 父类的指针可以指向子类 所以可以使用UIVIEWcONTROLE 当成指针
-(void)addOneChildViewControllerWith:(UIViewController *)vc  Image:(UIImage *)image SelectedImage:(UIImage *)selectedImage  title:(NSString *)title{
//    vc.tabBarItem.badgeValue = @"10";  //苹果的item 都是模型 tabbaritem是决定tabbar上的按钮的内容
    vc.tabBarItem.title = title;//tabbarController的子控制器的标题 在子控制器的tabbarItem里设置
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    //保存这些item到self.items 里面方便给自定义的uitabbarbutton 赋值
    [self.items addObject:vc.tabBarItem];
    
//    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
    LF_NavigationController *nav = [[LF_NavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
}

#pragma mark --- 自定义tabbar的代理
-(void)lfTabBar:(LF_TabBar *)tabbar didClickButton:(NSInteger)index{
    if (self.selectedIndex == 0 && index == 0) {
        [self.home refresh];
    }
    self.selectedIndex = index;
}
-(void)lfTaBar:(LF_TabBar *)tabbar didClickPlusButton:(UIButton *)plusBtn{
    LF_ComposeViewController *composeVC = [[LF_ComposeViewController alloc]init];
    LF_NavigationController *nav = [[LF_NavigationController alloc]initWithRootViewController:composeVC];
    composeVC.delegate = self;
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark --发送界面的代理
-(void)composeViewController:(LF_ComposeViewController *)composeViewController{
    [self.home refresh];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [self.timer invalidate];
    self.timer=nil;
    self.home = nil;
    self.message = nil;
    self.dicover = nil;
    self.profile = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
