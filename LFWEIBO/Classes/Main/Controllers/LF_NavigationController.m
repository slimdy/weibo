//
//  LF_NavigationController.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/25.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_NavigationController.h"
#import "UIBarButtonItem+LF_barButtonItem.h"
@interface LF_NavigationController ()<UINavigationControllerDelegate>
@property (nonatomic,strong)id gestureDelegate;
@end

@implementation LF_NavigationController
+ (void)initialize
{
    if (self == [LF_NavigationController class]) {
       UIBarButtonItem *items =  [UIBarButtonItem appearanceWhenContainedIn:self, nil];
        [items setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateNormal];
       //导航条的不能按属性不能用富文本设置
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.gestureDelegate = self.interactivePopGestureRecognizer.delegate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITabBarController * tabBarVC = (UITabBarController *)window.rootViewController;
        for (UIView *view in tabBarVC.tabBar.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [view removeFromSuperview];
            }
        }
    
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers[0] == viewController) {
        self.interactivePopGestureRecognizer.delegate = self.gestureDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    NSLog(@"%lu",(unsigned long)self.viewControllers.count);//这里是指每一个nav（包括homenav，messageNAV等）的子控制器不存在，特别指的是NAV 而不是tabbarcontroller
    if(self.viewControllers.count != 0 ){
        
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(pop2root) forEvent:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(pop2back) forEvent:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
    
}

-(void)pop2root{
    [self popToRootViewControllerAnimated:YES];
}
-(void)pop2back{
    [self popViewControllerAnimated:YES];
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
