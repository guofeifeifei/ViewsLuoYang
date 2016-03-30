//
//  DataBaseManger.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/21.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "DataBaseManger.h"
#import "CollectViewController.h"
//引入数据库头文件
#import <sqlite3.h>

@interface DataBaseManger (){
    NSString *dataBasePath;//数据库创建路径
}
@property (nonatomic, strong) NSMutableArray *allUrlArray;

@end

@implementation DataBaseManger
//创建静态单例对象（DataBaseManger ）,设置初始值为空
static DataBaseManger *dbManger = nil;

+ (DataBaseManger *)shareInstance{
    //如果单利对象为空，就去创建一个
    if (dbManger == nil) {
        dbManger = [[DataBaseManger alloc] init];
    }
    return dbManger;
}

#pragma mark --------- 数据库基础操作
//创建一个静态数据库实例对象
static sqlite3 *dataBase = nil;
//创建数据库
- (void)createDataBase{
    //获取应用程序沙盒路径
    NSString *documentpath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    dataBasePath = [documentpath stringByAppendingPathComponent:@"/mango.sqlite"];
    ZPFLog(@"%@",dataBasePath);
    
}
//打开数据库
- (void)openDataBase{
    //如果数据库存在就直接返回，如果不存在就去创建一个新的数据库 和 表
    if (dataBase != nil) {
        return;
    }
    //再打开之前需要创建数据库
    [self createDataBase];
    //第一个参数，数据库文件的路径名,注意是UIF8String编码格式
    //第二个：数据库对象地址
    //如果数据库文件已经存在，就是打开操作，如果数据库文件不存在，则先创建后打开
    int result = sqlite3_open([dataBasePath UTF8String], &dataBase);
    if (result == SQLITE_OK) {
        ZPFLog(@"数据库打开成功");
        //数据库打开成功之后区创建数据库表
        [self createDataBaseTable];
    }else{
        ZPFLog(@"数据库打开失败");
    }
}
//创建数据库表
- (void)createDataBaseTable{
    NSString *sql = @"CREATE TABLE Collect (number INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT NOT NULL, image TEXT NOT NULL)";
    char *error = nil;
    sqlite3_exec(dataBase, [sql UTF8String], NULL, NULL, &error);
    
}


//关闭数据库
- (void)closeDataBase{
    int result = sqlite3_close(dataBase);
    if (result == SQLITE_OK) {
       
        dataBase = nil;
    }else{
      
    }
}

#pragma mark -------- 数据库常用操作

//增加：

- (void)insertIntoNewUrl:(Collect *)url{
    //第一步：打开数据库
    [self openDataBase];
    //第二步：定义一个sqlite3_stmt(简单的理解为它里边就是sql语句)
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"INSERT INTO Collect (url, image) values (?, ?)";
    
    int result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        //绑定？ ---- url
        sqlite3_bind_text(stmt, 1, [url.url UTF8String], -1, NULL);
        ZPFLog(@"添加语句通过");
        //绑定？ ---- image
        sqlite3_bind_text(stmt, 2, [url.image UTF8String], -1, NULL);
        
        
     //执行
    sqlite3_step(stmt);
        }
    else{
    ZPFLog(@"sql语句有问题");
}
    //删除释放掉
    sqlite3_finalize(stmt);
    [self closeDataBase];
}


//删
- (void)deleteColectWithUrl:(NSString *)url{
    //1.打开数据库
    [self openDataBase];
    //2.定义一个sqlite3_stmt（简单的理解为它里边就是sql语句）
    sqlite3_stmt *stmt = nil;
    //3.sql语句
    NSString *sql = @"DELETE FROM Collect WHERE url = ?";
    int result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        
       // NSLog(@"删除语句通过");
        //绑定name的值
        sqlite3_bind_text(stmt, 1, [url UTF8String], -1, NULL);
        //执行
        sqlite3_step(stmt);
        
        
    }else{
        //NSLog(@"删除语句break");
    }
    
    //删除释放掉
    sqlite3_finalize(stmt);
    [self closeDataBase];
    
}

//查
- (NSMutableArray *)selectAllUrl{
        //打开数据库
        [self openDataBase];
        //创建sql语句的指针变量
        sqlite3_stmt *stmt = nil;
        //sql语句
        NSString *sql = @"SELECT url, image FROM Collect";
        int result = sqlite3_prepare_v2(dataBase, [sql UTF8String], -1, &stmt, NULL);
        
        self.allUrlArray = [NSMutableArray new];
        if (result == SQLITE_OK) {
          //  NSLog(@"查询所有url成功");
            //while循环添加查询出来的数据
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                NSString *url = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 0)];
                NSString *image = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 1)];
                
                Collect *collect = [Collect collectWithUrl:url image:image];
                [self.allUrlArray addObject:collect];
                
            }
            
        }else{
            ZPFLog(@"查询不成功");
            
        }
    for (int i = 0; i < self.allUrlArray.count; i++) {
        Collect *allUrl = self.allUrlArray[i];
        ZPFLog(@"allUrl = %@",allUrl);
    }
    
    
    //释放
    sqlite3_finalize(stmt);
//    [self closeDataBase];
    return self.allUrlArray;
}


















@end
