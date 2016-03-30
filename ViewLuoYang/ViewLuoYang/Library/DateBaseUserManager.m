//
//  DateBaseManager.m
//  UIDateBase
//
//  Created by scjy on 15/12/18.
//  Copyright © 2015年 scjy. All rights reserved.
//

#import "DateBaseUserManager.h"


@interface DateBaseUserManager ()
{
    
    NSString *dateBasePath;//数据库创建路径
    
}
@end



@implementation DateBaseUserManager

//创建一个静态的单例对象，设置为空
static DateBaseUserManager *dbManager=nil;


+ (DateBaseUserManager *)sharedInstance{
    //如果单例对象为空
    if (dbManager == nil) {
        dbManager =[[DateBaseUserManager alloc]init];
    }
    return dbManager;
    
}

#pragma mark --- 数据库基础操作


//创建一个静态数据库实例对象

static sqlite3 *datebace =nil;




//创建数据库
-(void)createDateBase{
    //获取应用程序沙河路径
    
    
    NSString *document=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    
    dateBasePath=[document stringByAppendingPathComponent:@"/Mango.sqlite"];
    
    
    NSLog(@"%@",dateBasePath);
    
    
}





//打开数据库
-(void)openDateBase{
    
    //打开之前，需要创建数据库
    
    //如果数据库存在，就直接返回，如果不存在，就去创建一个新的数据库和表
    if (datebace != nil) {
        
        return ;
        
    }
    
    [self createDateBase];
    
    //第一个参数：数据库文件的路径名，注意是UTF-8格式
    //第二个参数：数据库对象的地址
    //如果数据库文件存在，就打开操作,如果不存在，就创建，打开
    
    
   int result=sqlite3_open([dateBasePath UTF8String], &datebace);
    
    
    if (result == SQLITE_OK) {
        
        //NSLog(@"数据库打开成功");
        //数据库打开成功之后创建表
        [self createDateBaseTable];
        
        
    }else{
        
        
       // NSLog(@"数据库打开失败");
    }
    
    
    
}




//创建数据库表
-(void)createDateBaseTable{
   /*
   
    //create table Students (number INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, gender TEXT, age INTEGER)
    
    number INTEFER PRIMARY KEY AUTOINCREMENT
    字段名  数据类型   主键          自增
    
    CREATE TABLE LinkMans (number INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, gender TEXT NOT NULL, age INTEGER DEFAULT 18, phoneNumber TEXT NOT NULL, remarks TEXT)
    
    
    
    */
    
    
    
     //建表语句
//    NSString *sql=@"CREATE  TABLE LinkMans(number INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,age INTEGER DEFAULT 18, phoneNumber TEXT NOT NULL, remarks TEXT)";
    
    
    NSString *sql=@"CREATE TABLE LinkMans(number integer primary key autoincrement, name text not null,gender text,headerImage text ,city text,followers text)";
    
    
    
    //执行sql语句
    /*
     第一个参数：sqlite3 *是数据库
     第二个参数：const char *sql,sql语句，utf——8格式
     第三个参数：int (*callback)是函数回调，当这条语句执行完之后，会调用你提供的函数，可以是null
     第四个参数：(void *, )是你提供的指针变量，这个参数最终会传到你的函数回调中，也可以是空,
     第五个参数：char **errmsg是错误信息，需要注意是指针类型，接受sqlite3执行的错误信息，也可以是null
     
     */
    
    
    char *error=nil;
    
    sqlite3_exec(datebace, [sql UTF8String], NULL, NULL, &error);
    
    
    
    
    
}



//关闭数据库
-(void)closeDateBase{
    
    int  result=sqlite3_close(datebace);
    
    
    if (result ==SQLITE_OK) {
      //  NSLog(@"关闭成功");
        
        datebace =nil;
        
    
    }else{
        
        
       // NSLog(@"关闭失败");
        
    }
    
}


#pragma mark --- 数据库常用操作增、删、改、查
//增
//插入一个新的联系人


-(void)insertIntoLinkMans:(LinkMan *)linkman{
    //打开数据库
    [self openDateBase];
    //简单的理解它里面就是sql语句
    sqlite3_stmt *stmt=nil;
    //sql  语句number integer primary key autoincrement, name text not null,gender text,headerImage text ,city text,followers text)";

    
    NSString *sql=@"INSERT INTO LinkMans(name,gender,headerImage,city, followers)values(?,?,?,?,?)";
    
    //验证sql语句
    
    /*
     
     第三个参数：int nByte
     nByte：如果nByte小于0，则函数取出zSql中从开始到第一个0终止符的内容；如果nByte不是负的，那么它就是这个函数能从zSql中读取的字节数的最大值。如果nBytes非负，zSql在第一次遇见’/000/或’u000’的时候终止
     pzTail：上面提到zSql在遇见终止符或者是达到设定的nByte之后结束，假如zSql还有剩余的内容，那么这些剩余的内容被存放到pZTail中，不包括终止符
     ppStmt：能够使用sqlite3_step()执行的编译好的准备语句的指针，如果错误发生，它被置为NULL，如假如输入的文本不包括sql语句。调用过程必须负责在编译好的sql语句完成使用后使用sqlite3_finalize()删除它。
     
     
     
     
     
     */
    
    
    
    
    int result=sqlite3_prepare_v2(datebace,[sql UTF8String], -1, &stmt, NULL);
    
    
    
    if (result == SQLITE_OK) {
        //sql语句没有问题————绑定数据(绑定的是上面的sql语句的？，也就是将？替换成应该存储的值)
        //绑定？时，标记从1开始不是0
        //name,gender,headerImage,city, followers
        //绑定第一个？号，，name
        
        sqlite3_bind_text(stmt, 1, [linkman.name UTF8String], -1, NULL);
        //绑定第二个？号  gender
        
        
        sqlite3_bind_text(stmt, 2, [linkman.gender UTF8String], -1, NULL);
        
        //绑定第三个？号  age
        
        sqlite3_bind_text(stmt, 3, [linkman.headImage UTF8String], -1, NULL);
        
        //绑定第四个？号  phonenumber
        
        sqlite3_bind_text(stmt, 4, [linkman.city UTF8String], -1, NULL);
        //绑定第五个？号Remarks
        
        sqlite3_bind_text(stmt, 5, [linkman.followers UTF8String], -1, NULL);
        
        
        //执行
        sqlite3_step(stmt);
        
        
        
        
    } else {
      //  NSLog(@"sql语句有问题");
    }
    
    //删除掉
    sqlite3_finalize(stmt);
    
}



//删

//删除全部联系人


- (void)deleteLinkMans{
    
    [self openDateBase];
    
    
    NSString *sql=@"delete from LinkMans";
    
    int result=sqlite3_exec(datebace, [sql UTF8String], NULL, NULL, NULL);
    
    
    
    if (result ==SQLITE_OK) {
       // NSLog(@"删除成功");
        
    }else{
        
       // NSLog(@"删除失败");
        
    }
    
    
    
    
    
    
}




//根据姓名删除联系人


-(void)deleteLinkMansName:(NSString *)name{
    //打开数据库
    [self openDateBase];
    
    
    //创建一个存数sql语句的变量
    
    sqlite3_stmt *stmt=nil;
    
    
    //sql语句
    
    NSString *sql=@"delete from LinkMans where name = ?";
    
    //验证语句
    
    int resulet=sqlite3_prepare_v2(datebace, [sql UTF8String], -1, &stmt, NULL);
    
    if (resulet == SQLITE_OK) {
       // NSLog(@"删除ok");
        //绑定name的值
        
        sqlite3_bind_text(stmt, 1, [name UTF8String], -1, NULL);
        //执行
        sqlite3_step(stmt);
        
        
        
        
    }else{
        
     //   NSLog(@"删除失败");
        
    }
    
    
    
    
    
    sqlite3_finalize(stmt);
    
    
    
    
    
    
}



//改
//根据姓名修改电话
-(void)updateLinkManPhoneNumber:(NSString *)phoneNumber withName:(NSString *)name{
    
    
    [self openDateBase];
    
    //创建sql语句的指针变量
    sqlite3_stmt *stmt=nil;
    
    NSString *sql=@"update LinkMans set phoneNumber = ? where name = ?";
    
    
    //验证sql
    int result=sqlite3_prepare_v2(datebace, [sql UTF8String], -1, &stmt, NULL);
    
    
    
    if (result == SQLITE_OK) {
      //  NSLog(@"更新成功");
        //第二个参数数？的位置
        //const char * 是把传进来的参数转换成c
        sqlite3_bind_text(stmt, 1, [phoneNumber UTF8String], -1, NULL);
        
      sqlite3_bind_text(stmt, 2, [name UTF8String], -1, NULL);
        
      
        
        sqlite3_step(stmt);
        
        
    }else{
        
       // NSLog(@"更新失败");
        
    }
    
    sqlite3_finalize(stmt);
}
//查
//查询所有联系人

-(NSMutableArray *)selectAllLinkmans{
    
    
    
    [self openDateBase];
    sqlite3_stmt *stmt=nil;
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSString *sql=@"SELECT * FROM LinkMans";
    
    
    
    int result = sqlite3_prepare_v2(datebace, [sql UTF8String], -1, &stmt, NULL);
    
    
    
    
    if (result == SQLITE_OK) {
      //  NSLog(@"selete ok");
        
        
       while (sqlite3_step(stmt)== SQLITE_ROW) {
        
            NSString *name=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            
            
            NSString *gender=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
           
             NSString *headimage=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            
            NSString *city=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            
            NSString *folleows=[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)];
            
            
            
            LinkMan *lingkman=[LinkMan linkManWithName:name andheadImage:headimage gender:gender andcity:city andfollowers:folleows];
            
            [arr addObject:lingkman];
            
        }
        
        
        
        
        
    }else {
        
     //   NSLog(@"selete fail");
        
    }
    
    
    
    
    
    return arr;
}








@end
