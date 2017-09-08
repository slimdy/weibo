//
//  LF_ComposeViewController.m
//  LFWEIBO
//
//  Created by slimdy on 2017/5/3.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_ComposeViewController.h"
#import "LF_TextView.h"
#import "LF_ComposeToolBar.h"
#import "UIView+Frame.h"
#import "LF_PhotosView.h"
#import "LF_ComposeTool.h"
#import "MBProgressHUD+MJ.h"
#import "LF_HomeTableViewController.h"
@interface LF_ComposeViewController ()<UITextViewDelegate,LF_ComposeToolBarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,weak) LF_TextView*textView;
@property (nonatomic,weak) LF_ComposeToolBar *toolBar;
@property (nonatomic,weak) LF_PhotosView *photosView;
@property (nonatomic,strong)UIBarButtonItem  *rightBarItem;
@property (nonatomic,strong)NSMutableArray  *imagesArr;
@end

@implementation LF_ComposeViewController
-(NSMutableArray *)imagesArr{
    if (!_imagesArr) {
        NSMutableArray *imagesArr = [NSMutableArray array];
        _imagesArr = imagesArr;
    }
    return _imagesArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    [self setupTextView];
    [self setupToolBar];
    [self setupPhotosView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)keyBoardFrameChange:(NSNotification *)noti{
    CGRect frame =  [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (frame.origin.y == self.view.height) {
        [UIView animateWithDuration: [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            self.toolBar.transform = CGAffineTransformIdentity;
        }];
    }else{
        [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            
            self.toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}
-(void)setupNavigationBar{
    self.navigationItem.title = @"发微博";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"发送" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    rightBtn.enabled = NO;
    [rightBtn addTarget:self action:@selector(sendWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    _rightBarItem = self.navigationItem.rightBarButtonItem;
}
-(void)setupToolBar{
    CGFloat h = 44;
    LF_ComposeToolBar *toolBar = [[LF_ComposeToolBar alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - h, [UIScreen mainScreen].bounds.size.width, h)];
    toolBar.buttonImages = @[@"compose_emoticonbutton_background",@"compose_keyboardbutton_background",@"compose_mentionbutton_background",@"compose_toolbar_picture",@"compose_trendbutton_background"];
    toolBar.delegate = self;
    _toolBar = toolBar;
    [self.view addSubview:toolBar];
}
-(void)setupTextView{
    LF_TextView *textView = [[LF_TextView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    textView.placehoder = @"写些什么呢...";
    textView.font = [UIFont systemFontOfSize:13];
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
}
-(void)setupPhotosView{
    LF_PhotosView *photosView = [[LF_PhotosView alloc]initWithFrame:CGRectMake(0, 70, self.view.width, self.view.height-70)];
    self.photosView = photosView;
    [self.textView addSubview:photosView];
}
-(void)textChange:(NSNotification *)noti{
    if (self.textView.text.length) {
        self.textView.placehoderHide = YES;
        self.rightBarItem.enabled = YES;
    }else{
        self.textView.placehoderHide = NO;
        self.rightBarItem.enabled = NO;
    }
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.textView endEditing:YES];
}
-(void)composeToolBar:(LF_ComposeToolBar *)composeToolBar didClickBtn:(UIButton *)clickBtn{
    if (clickBtn.tag == 3) {
        UIImagePickerController *pickVC = [[UIImagePickerController alloc]init];
        pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickVC.delegate = self;
        [self presentViewController:pickVC animated:YES completion:nil];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.photosView.image = image;
    [self.imagesArr addObject:image];
    self.rightBarItem .enabled = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)sendWeibo:(UIButton *)sendBtn{
    self.rightBarItem.enabled = NO;
    if (self.imagesArr.count) {
        [self sendPic];
    }else{
        
        [self sendText];
    }
}
-(void)sendText{
    MBProgressHUD *hud = [MBProgressHUD showMessage:@"正在发送..."];
    [LF_ComposeTool composeText:self.textView.text WithSuccess:^{
        self.rightBarItem.enabled = YES;
        [hud hide:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        [MBProgressHUD showSuccess:@"发送文字微博成功"];
        if ([self.delegate respondsToSelector:@selector(composeViewController:)]) {
            [self.delegate composeViewController:self];
        }
    } failure:^(NSError *error) {
        [hud hide:YES];
        [MBProgressHUD showError:@"发送文字微博失败"];
        self.rightBarItem.enabled = YES;
        NSLog(@"%s--%@",__func__,error);
    }];
}
-(void)sendPic{
    UIImage *image = self.imagesArr[0];
    NSString *text = self.textView.text.length?self.textView.text:@"分享图片:";
    MBProgressHUD *hud = [MBProgressHUD showMessage:@"正在发送..."];
    [LF_ComposeTool composeText:text image:image WithSuccess:^{
        [hud hide:YES];
        self.rightBarItem.enabled = YES;
        [self dismissViewControllerAnimated:YES completion:nil];
        [MBProgressHUD showSuccess:@"发送图片微博成功"];
        if ([self.delegate respondsToSelector:@selector(composeViewController:)]) {
            [self.delegate composeViewController:self];
        }
    } failure:^(NSError *error) {
        [hud hide:YES];
        [MBProgressHUD showError:@"发送图片微博失败"];
        self.rightBarItem.enabled = YES;
        NSLog(@"%s--%@",__func__,error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
