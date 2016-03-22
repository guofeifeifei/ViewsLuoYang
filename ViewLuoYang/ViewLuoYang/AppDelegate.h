//
//  AppDelegate.h
//  ViewLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import "RESideMenu.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate,WXApiDelegate, RESideMenuDelegate>

{
    NSString* wbCurrentUserID;
    
    NSString *wbtoken;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *wbtoken;

@end

