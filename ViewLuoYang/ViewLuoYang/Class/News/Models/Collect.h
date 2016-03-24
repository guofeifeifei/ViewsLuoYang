//
//  Collect.h
//  ViewLuoYang
//
//  Created by scjy on 16/3/21.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Collect : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *image;

//创建便利构造器创建收藏内容
+ (instancetype)collectWithUrl:(NSString *)url image:(NSString *)image;

@end
