//
//  LF_NewFeatureCell.h
//  LFWEIBO
//
//  Created by slimdy on 2017/4/25.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LF_NewFeatureCell : UICollectionViewCell
@property (nonatomic,weak)UIImage *image;
-(void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;
@end
