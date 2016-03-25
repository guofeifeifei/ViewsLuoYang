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
static NSString *appKey = @"da56b927d79da978d06d0fe0";

static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;
@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate,WXApiDelegate, RESideMenuDelegate>

{
    NSString* wbCurrentUserID;
    
    NSString *wbtoken;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *wbtoken;

@end

