//
//  DateBaseManager.h
//  UIDateBase
//
//  Created by scjy on 15/12/18.
//  Copyright © 2015年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LinkMan.h"

//引入数据库头文件
#import <sqlite3.h>
@interface DateBaseUserManager : NSObject

//用单例创建数据库管理对象
+(DateBaseUserManager *)sharedInstance;

#pragma mark --- 数据库基础操作

//创建数据库
-(void)createDateBase;

//创建数据库表
-(void)createDateBaseTable;



//打开数据库
-(void)openDateBase;


//关闭数据库
-(void)closeDateBase;


#pragma mark --- 数据库常用操作增、删、改、查
//增
//插入一个新的联系人


-(void)insertIntoLinkMans:(LinkMan *)linkman;



//删

//删除全部联系人
- (void)deleteLinkMans;





//根据姓名删除联系人


-(void)deleteLinkMansName:(NSString *)name;



//改
//根据姓名修改电话
-(void)updateLinkManPhoneNumber:(NSString *)phoneNumber withName:(NSString *)name;

//查
//查询所有联系人

-(NSMutableArray *)selectAllLinkmans;





@end
