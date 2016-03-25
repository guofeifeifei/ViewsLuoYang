//
//  AppDelegate.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "AppDelegate.h"
#import "ShowViewController.h"
#import "NewsViewController.h"
#import "ServiceViewController.h"
#import "MessageViewController.h"
#import "LeftViewController.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "JPUSHService.h"
#import <BmobPay/BmobPay.h>
#import <AlipaySDK/AlipaySDK.h>
@interface AppDelegate (){
    
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
   
    //新浪微博分享
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    [WXApi registerApp:kWeixinAppSecret];
    
    
    //地图
    [AMapSearchServices sharedServices].apiKey = kLocationApk;
    
    [AMapLocationServices sharedServices].apiKey = kLocationApk;
    
    //bmob支付
    [BmobPaySDK registerWithAppKey:kBmobPay];
    
    //推送//监听方法
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    
    }else{
//        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                          UIRemoteNotificationTypeSound |
//                                                          UIRemoteNotificationTypeAlert)
//                                              categories:nil];
    }
    [JPUSHService setupWithOption:launchOptions appKey:appKey  channel:channel apsForProduction:isProduction
     ];
    
//    NSLog(@"kJPFNetworkDidSetupNotification = %@", kJPFNetworkDidSetupNotification);
//    
//     NSLog(@"kJPFNetworkDidCloseNotification = %@", kJPFNetworkDidCloseNotification);
//     NSLog(@"kJPFNetworkDidRegisterNotification = %@", kJPFNetworkDidRegisterNotification);
//     NSLog(@"kJPFNetworkDidLoginNotification = %@", kJPFNetworkDidLoginNotification);
    
    UILocalNotification *localNotification =  [JPUSHService setLocalNotification:[NSDate dateWithTimeIntervalSinceNow:100]
                          alertBody:@"全景洛阳有新消息"
                              badge:1
                        alertAction:nil
                      identifierKey:@"identifierKey"
                           userInfo:nil
                          soundName:nil];
   
    //前台显示
    [JPUSHService showLocalNotificationAtFront:localNotification  identifierKey:nil];
    
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    
    NSLog(@"remoteNotification = %@", remoteNotification);
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    
    UITabBarController *tabbar=[[UITabBarController alloc]init];
    //展示类
    ShowViewController *show=[[ShowViewController alloc]init];
    
    UINavigationController *showNav=[[UINavigationController alloc]initWithRootViewController:show];
    UIStoryboard *leftStoryboard = [UIStoryboard storyboardWithName:@"LeftStoryboard" bundle:nil];
    
    
    LeftViewController *leftVC = [leftStoryboard instantiateViewControllerWithIdentifier:@"leftVC"];
    //导航栏颜色
    showNav.navigationBar.barTintColor = barColor;
   
    showNav.tabBarItem.image=[UIImage imageNamed:@"vpi__tab_unselected_focused_holo.9-1"];
    UIImage *image=[UIImage imageNamed:@"huodong_pre"];
    //按图片原来状态显示
    showNav.tabBarItem.selectedImage=[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    showNav.tabBarItem.title=@"主页";
    

    
    
    NewsViewController *news=[[NewsViewController alloc]init];
    
    UINavigationController *newNav=[[UINavigationController alloc]initWithRootViewController:news];
    
    
    //导航栏颜色
    newNav.navigationBar.barTintColor = barColor;
    
    
    newNav.tabBarItem.image=[UIImage imageNamed:@"bottom_newspaper"];
    UIImage *newimage=[UIImage imageNamed:@"bottom_newspaper_on"];
    //按图片原来状态显示
    newNav.tabBarItem.selectedImage=[newimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    newNav.tabBarItem.title=@"电子报";
    
    MessageViewController *message=[[MessageViewController alloc]init];
    UINavigationController *messageNav=[[UINavigationController alloc]initWithRootViewController:message];
    
    
    messageNav.tabBarItem.image=[UIImage imageNamed:@"bottom_people"];
    
    UIImage *mineimage=[UIImage imageNamed:@"bottom_people_on"];
    //按图片原来状态显示
    messageNav.tabBarItem.selectedImage=[mineimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //导航栏颜色
    messageNav.navigationBar.barTintColor = barColor;
    messageNav.tabBarItem.title=@"消息";
    
    ServiceViewController *service=[[ServiceViewController alloc]init];
    UINavigationController *serviceNav=[[UINavigationController alloc]initWithRootViewController:service];
    
    
    serviceNav.tabBarItem.image=[UIImage imageNamed:@"bianmin"];
    
    UIImage *serviceNavimage=[UIImage imageNamed:@"bianmin_pre"];
    //按图片原来状态显示
    serviceNav.tabBarItem.selectedImage=[serviceNavimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    //导航栏颜色
    serviceNav.navigationBar.barTintColor =barColor;
    
    serviceNav.tabBarItem.title=@"服务";
    
    tabbar.tabBar.tintColor=[UIColor redColor];
    tabbar.tabBar.backgroundColor = [UIColor whiteColor];
    tabbar.viewControllers=@[showNav,newNav,messageNav,serviceNav];
    
    RESideMenu *sideMenuViewConttroller = [[RESideMenu alloc] initWithContentViewController:tabbar leftMenuViewController:leftVC rightMenuViewController:nil];
    
    sideMenuViewConttroller.backgroundImage = [UIImage imageNamed:@"Stars"];
    sideMenuViewConttroller.menuPreferredStatusBarStyle = 1;
    sideMenuViewConttroller.delegate = self;
    sideMenuViewConttroller.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewConttroller.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewConttroller.contentViewShadowOpacity = 0.6;
    sideMenuViewConttroller.contentViewShadowRadius = 12;
    sideMenuViewConttroller.contentViewShadowEnabled = YES;

    self.window.rootViewController = sideMenuViewConttroller;
    
    
    
    
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
  
    return YES;
}




#pragma mark ------- shareWeibo
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    if ([url.host isEqualToString:@"safepay"]) {
                [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                    NSLog(@"result  = %@", resultDic);
                }];
                return YES;
            }

    
    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
    return  isSuc;
    
    
    return [WeiboSDK handleOpenURL:url delegate:self];
    
}

#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}





- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  
    // Required
    [JPUSHService registerDeviceToken:deviceToken];
    
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"];//推送内容显示
    NSInteger badge = [[aps valueForKey:@"badge"]integerValue];//bade数量
    NSString *sound = [aps valueForKey:@"sound"];//播放音乐
    
    //取得Extras字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"];
    NSLog(@"content =[%@], badge=[%ld], sound=[%@], customize field  =[%@]",content,badge,sound,customizeField1);
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    
    
    
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    NSString *customizeField1 = [extras valueForKey:@"customizeField1"]; //自定义参数，key是自己定义的
    
    UILocalNotification *localNotification =  [JPUSHService setLocalNotification:[NSDate dateWithTimeIntervalSinceNow:100] alertBody:@"家母喊你回洛阳呢？" badge:1 alertAction:customizeField1 identifierKey:@"identifierKey" userInfo:userInfo soundName:nil region:nil regionTriggersOnce:nil category:nil];
    
    //前台显示
    [JPUSHService showLocalNotificationAtFront:localNotification  identifierKey:nil];
    

    
}


@end
