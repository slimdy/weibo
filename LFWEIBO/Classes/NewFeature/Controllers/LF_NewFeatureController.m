//
//  LF_NewFeatureController.m
//  LFWEIBO
//
//  Created by slimdy on 2017/4/25.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_NewFeatureController.h"
#import "LF_NewFeatureCell.h"
#import "UIView+Frame.h"
@interface LF_NewFeatureController ()<UIScrollViewDelegate>
@property (nonatomic,weak)UIPageControl *pageControl;
@end

@implementation LF_NewFeatureController

static NSString * const reuseIdentifier = @"Cell";
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    return [super initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[LF_NewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    self.collectionView.pagingEnabled = YES;
    //无弹性
    self.collectionView.bounces  = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self setupPageControl];
    
    
}
-(void)setupPageControl{
    UIPageControl * pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = 4;
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.center = CGPointMake(self.view.width*0.5, self.view.height *0.9);
    self.pageControl = pageControl;
    //self.view 是当前固定于屏幕的View
    //self.collectionView则是整个所有可滑动区域的View
    [self.view addSubview:self.pageControl];
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/scrollView.bounds.size.width+0.5;
    self.pageControl.currentPage = page;
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LF_NewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row+1];
    //NSLog(@"%@",imageName);
//    cell.backgroundColor = [UIColor yellowColor];
    cell.image =[UIImage imageNamed:imageName];
    
    [cell setIndexPath:indexPath count:4];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
