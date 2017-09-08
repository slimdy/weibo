//
//  LF_HomeTableViewController.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/25.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_HomeTableViewController.h"
#import "LF_TitleView.h"
#import "LF_PopMenuView.h"
#import "LF_PopMenuViewController.h"
#import "UIView+Frame.h"
#import "UIBarButtonItem+LF_barButtonItem.h"
#import "LF_CoverVIew.h"
#import "AFNetworking.h"
#import "LF_AccountTool.h"
#import "LF_WeiboModel.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "LF_WeiboDataTool.h"
#import "LF_UserTool.h"
#import "LF_UserInfoModel.h"
#import "LF_WeiboCell.h"
#import "LF_WeiboViewModel.h"

//1 SDWEBimage 的好处
// 1.异步加载
//2.做好图片缓存
//3.解决循环利用的问题
//注意 很容易造成内存警告
//在appdelegate里面接收到内存警告的方法里  1.停止下载[[SDWebImageManager shareManager] cancleAll] 2.clearMemery
@interface LF_HomeTableViewController ()<LF_CoverViewDelegate>
@property (nonatomic,weak)LF_TitleView *titleView;
@property (nonatomic,strong) LF_PopMenuViewController *popVC;
@property (nonatomic,strong)NSMutableArray *weibos;
@end

@implementation LF_HomeTableViewController
-(NSMutableArray *)weibos{
    if (!_weibos) {
        _weibos = [NSMutableArray array];
    }
    return _weibos;
}
-(LF_PopMenuViewController *)popVC{
    if (!_popVC) {
        _popVC = [[LF_PopMenuViewController alloc]init];
    }
    return _popVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNarvigationBar];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    
    
    [self.tableView addHeaderWithTarget:self action:@selector(loadWeiBoData)];
    [self.tableView headerBeginRefreshing];
    
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreWeiBoData)];
    [self setupTitle];
}
-(void)setupTitle{
    [LF_UserTool getUnreadWithSuccess:^(id resultModel) {
        NSLog(@"%@",[(LF_UserInfoModel *)resultModel screen_name]);
        [self.titleView setTitle:[(LF_UserInfoModel *)resultModel screen_name] forState:UIControlStateNormal];
      LF_AccountModel*account = [LF_AccountTool getAccountModel];
        account.screen_name = [(LF_UserInfoModel *)resultModel screen_name];
        [LF_AccountTool saveAccountModelWith:account];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    } isUnread:NO];
}
- (void)loadMoreWeiBoData{

    NSString *max_id = [[[self.weibos lastObject] weibo] idstr];
    [LF_WeiboDataTool getMoreWeiboWithMaxId:max_id success:^(NSArray *weibos) {
        [self.tableView footerEndRefreshing];
        NSMutableArray *weiboVMArr = [NSMutableArray array];
        for (LF_WeiboModel *weibo in weibos) {
            LF_WeiboViewModel *weiboVM = [[LF_WeiboViewModel alloc]init];
            weiboVM.weibo = weibo;
            [weiboVMArr addObject:weiboVM];
        }

        [self.weibos addObjectsFromArray:weiboVMArr];
                
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}
-(void)refresh{
    [self.tableView headerBeginRefreshing];
}

-(void)setupRemindViewWith:(NSInteger)count{
    if (count == 0) return ;
    CGFloat viewX = 0;
    CGFloat viewH = 35;
    CGFloat viewY = CGRectGetMaxY(self.navigationController.navigationBar.frame)-viewH;
    CGFloat viewW = self.view.frame.size.width;
    UILabel *remindView = [[UILabel alloc]initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
    remindView.backgroundColor = [UIColor orangeColor];
    remindView.textColor = [UIColor whiteColor];
    remindView.text = [NSString stringWithFormat:@"有%ld条最新微博",(long)count];
    remindView.textAlignment =NSTextAlignmentCenter;
    [self.navigationController.view insertSubview:remindView belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:0.25 animations:^{
       remindView.transform =  CGAffineTransformMakeTranslation(0, viewH);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration: 0.25 delay:1.25 options:0 animations:^{
            remindView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [remindView removeFromSuperview];
        }];
    }];
    
    
    
}
- (void)loadWeiBoData{

    NSString *sinceId = [[[self.weibos firstObject] weibo] idstr];
    [LF_WeiboDataTool GetWeiboWithSinceId:sinceId success:^(NSArray *weibos) {
        [self.tableView headerEndRefreshing];
        [self setupRemindViewWith:weibos.count];
        NSMutableArray *weiboVMArr = [NSMutableArray array];
        for (LF_WeiboModel *weibo in weibos) {
            LF_WeiboViewModel *weiboVM = [[LF_WeiboViewModel alloc]init];
            weiboVM.weibo = weibo;
            [weiboVMArr addObject:weiboVM];
        }
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, weiboVMArr.count)];
        [self.weibos insertObjects:weiboVMArr atIndexes:indexSet];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)setupNarvigationBar{
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendSearch) forEvent:UIControlEventTouchUpInside];
    //右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forEvent:UIControlEventTouchUpInside];
    //中间按钮
    LF_TitleView *titleView = [LF_TitleView buttonWithType:UIButtonTypeCustom];
    self.titleView = titleView;
    [titleView setTitle:[LF_AccountTool getAccountModel].screen_name?[LF_AccountTool getAccountModel].screen_name:@"首页" forState:UIControlStateNormal];
    [titleView setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleView setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    [titleView addTarget:self action:@selector(titleDidClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)titleDidClick:(LF_TitleView *)titleView{
    titleView.selected = !titleView.selected;
    LF_CoverVIew *cover = [LF_CoverVIew show];
    cover.delegate = self;
    LF_PopMenuView *popView = [LF_PopMenuView showInRect:CGRectMake(self.view.width/2-75, 55, 150, 200)];
    popView.contentView = self.popVC.tableView;
}
-(void)friendSearch{
//    NSLog(@"%s",__func__);
}
-(void)pop{
//    NSLog(@"%s",__func__);
}

-(void)coverViewDidClick:(LF_CoverVIew *)coverView{
    [LF_PopMenuView hidePopMenuView];
    self.titleView.selected = NO;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weibos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LF_WeiboCell *cell = [LF_WeiboCell creatWeiboCellWith:tableView];
    cell.weiboVM =self.weibos[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.weibos[indexPath.row] cellHeight];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
