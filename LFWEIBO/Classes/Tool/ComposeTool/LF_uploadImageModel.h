//
//  LF_uploadImageModel.h
//  LFWEIBO
//
//  Created by slimdy on 2017/5/3.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LF_uploadImageModel : NSObject
@property (nonatomic,strong)NSData *data;
@property (nonatomic,copy) NSString* fileName;
@property (nonatomic,copy) NSString* mineType;
@property (nonatomic,copy) NSString* name;
@end
