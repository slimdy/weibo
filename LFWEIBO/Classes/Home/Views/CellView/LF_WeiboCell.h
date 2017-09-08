//
//  LF_WeiboCell.h
//  LFWEIBO
//
//  Created by slimdy on 2017/4/28.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LF_WeiboViewModel;
@interface LF_WeiboCell : UITableViewCell
@property (nonatomic,strong)LF_WeiboViewModel *weiboVM;
+(instancetype)creatWeiboCellWith:(UITableView *)tableView;
@end
