//
//  LF_WeiboCell.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/28.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_WeiboCell.h"
#import "LF_OriginalWeiboView.h"
#import "LF_RetweetWeiboView.h"
#import "LF_WeiboToolBar.h"
#import "LF_WeiboViewModel.h"
@interface LF_WeiboCell()
@property (nonatomic,weak) LF_OriginalWeiboView *originalView;
@property (nonatomic,weak) LF_RetweetWeiboView *reweetView;
@property (nonatomic,weak) LF_WeiboToolBar *toolBar;
@end
@implementation LF_WeiboCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        LF_OriginalWeiboView *originalView = [[LF_OriginalWeiboView alloc]init];
        [self addSubview:originalView];
        _originalView = originalView;
        LF_RetweetWeiboView *retweetView = [[LF_RetweetWeiboView alloc]init];
        
        [self addSubview:retweetView];
        _reweetView = retweetView;
        LF_WeiboToolBar *toolBar = [[LF_WeiboToolBar alloc]init];
        [self addSubview:toolBar];
        _toolBar = toolBar;
    }
    return self;
}
+(instancetype)creatWeiboCellWith:(UITableView *)tableView{
     LF_WeiboCell *cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[LF_WeiboCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
    }
   
    
//    [cell.imageView sd_setImageWithURL:weibo.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    return cell;
}
-(void)setWeiboVM:(LF_WeiboViewModel *)weiboVM{
    _weiboVM =weiboVM;
    [self setupChildFrame];
    [self setupChildData];
}
-(void)setupChildFrame{
    _originalView.frame = _weiboVM.originalViewFrame;
    _reweetView.frame = _weiboVM.reweetViewFrame;
    _toolBar.frame = _weiboVM.toolBarViewFrame;
}
-(void)setupChildData{
    _originalView.weiboVM = _weiboVM;
    _reweetView.weiboVM = _weiboVM;
    _toolBar.weibo = _weiboVM.weibo;
    
}
@end
