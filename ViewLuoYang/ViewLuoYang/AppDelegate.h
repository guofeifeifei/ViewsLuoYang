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

static NSString *appKey = @"178fe8164fdf68ad9e32ae28";

static NSString *channel = @"App Store";
static BOOL isProduction = false;
@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate,WXApiDelegate, RESideMenuDelegate>

{
    NSString* wbCurrentUserID;
    
    NSString *wbtoken;
}
@property(nonatomic, strong)RESideMenu *sideMenuViewConttroller;

@property(nonatomic, strong)UITabBarController *tabbar;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *wbtoken;

@end

