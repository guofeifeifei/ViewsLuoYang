//
//  NewsModel.h
//  ViewLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, copy) NSString *periodImageIcon;
@property (nonatomic, copy) NSString *periodImage;//图片
@property (nonatomic, copy) NSString *periodName;//title

@property (nonatomic, copy) NSString *curpage;


@property (nonatomic, copy) NSString *periodId;//文章详情
@property (nonatomic, copy) NSString *paperId;//报纸的类型
@property (nonatomic, copy) NSString *lastLayout;//最后一个数字
@property (nonatomic, copy) NSString *periodDate;







@end
