//
//  DataBaseManger.h
//  ViewLuoYang
//
//  Created by scjy on 16/3/21.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Collect.h"
@interface DataBaseManger : NSObject
+ (DataBaseManger *)shareInstance;

#pragma mark---------数据库基础操作
//创建数据库
- (void)createDataBase;
//创建数据库表
- (void)createDataBaseTable;
//打开数据库
- (void)openDataBase;
//关闭数据库
- (void)closeDataBase;

#pragma magk -------- 数据库常用操作

//增
- (void)insertIntoNewUrl:(Collect *)url;

//删
- (void)deleteColectWithUrl:(NSString *)url;


//查
- (NSMutableArray *)selectAllUrl;



@end
