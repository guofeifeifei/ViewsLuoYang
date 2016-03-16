//
//  ZMYNetManager.h
//  MVC
//
//  Created by 张茫原 on 15/6/5.
//  Copyright (c) 2015年 芒果科技. All rights reserved.
//

#import <Foundation/Foundation.h>

//网络类型
typedef enum : NSUInteger {
    
    ZMY_NetWork_TYPE_NONE = 0,          //没有网络
    
    ZMY_NetWork_TYPE_WIFI = 1,          //wifi环境
    
    ZMY_NetWork_TYPE_2G = 2,            //2G蜂窝网络
    
    ZMY_NetWork_TYPE_3G = 3,            //3G蜂窝网络
    
    ZMY_NetWork_TYPE_4G = 4,            //4G蜂窝网络
    
    ZMY_NetWork_TYPE_5G = 5             //5G蜂窝网络
    
} ZMY_NetWork_TYPE;


@interface ZMYNetManager : NSObject



+ (ZMYNetManager *)shareZMYNetManager;



//从状态栏检测网络类型
+ (ZMY_NetWork_TYPE)getZMYNetWorkTypeFromStatusBar;



//检测网络是否可用
- (BOOL)isZMYNetWorkRunning;


@end








