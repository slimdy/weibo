//
//  LF_OAuthViewController.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/26.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_OAuthViewController.h"
#define BaseUrl @"https://api.weibo.com/oauth2/authorize"
#define Client_id @"1392991338"
#define Redirect_uri @"http://www.fanna.com.cn"
#define Client_secret @"c650e0b4c3a05082ef0d04c632e5b752"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "LF_AccountTool.h"
#import "LF_RootControllerTool.h"
@interface LF_OAuthViewController ()<UIWebViewDelegate>

@end

@implementation LF_OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   UIWebView *webView =  [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self setupWebView:webView];
    [self.view addSubview:webView];
    
}
-(void)setupWebView:(UIWebView *)webView{
    webView.delegate = self;
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",BaseUrl,Client_id,Redirect_uri];
    NSURL *RequsetUrl =[NSURL URLWithString:urlStr];
    NSURLRequest *requst = [[NSURLRequest alloc]initWithURL:RequsetUrl];
    [webView loadRequest:requst];
    
}
    
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载..."];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *url = request.URL.absoluteString;
    if ([url rangeOfString:@"code="].length != 0) {
        //NSLog(@"%@",url);
        NSLog(@"%lu",(unsigned long)[request.URL.absoluteString rangeOfString:@"code="].location);
        NSString *code = [url substringFromIndex:[url rangeOfString:@"code="].location + 5];
        //NSLog(@"%@",code);
        [self getAcessTokenWith:code];
        return NO;
    }
    
    return YES;
}
/*
 client_id	true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 必选	类型及范围	说明
 code	true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。*/
-(void)getAcessTokenWith:(NSString *)code{
//    NSString *ATurl = @"https://api.weibo.com/oauth2/access_token";
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    NSDictionary *param = @{@"client_id":Client_id,@"client_secret":Client_secret,@"grant_type":@"authorization_code",@"code":code,@"redirect_uri":Redirect_uri};
//    NSLog(@"%@",param);
//    [mgr POST:ATurl parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [MBProgressHUD hideHUD];
//        LF_AccountModel *accountModel = [LF_AccountModel creatAccountModelWith:responseObject];
//        [LF_AccountTool saveAccountModelWith:accountModel];
//        [LF_RootControllerTool chooseRootViewController:[UIApplication sharedApplication].keyWindow];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
    [LF_AccountTool  GetAccessTokenWith:code success:^{
        [MBProgressHUD hideHUD];
        [LF_RootControllerTool chooseRootViewController:[UIApplication sharedApplication].keyWindow];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
        
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
