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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //新浪微博分享
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    [WXApi registerApp:kWeixinAppID];
    
    
    
    [AMapSearchServices sharedServices].apiKey = kLocationApk;
    
    [AMapLocationServices sharedServices].apiKey = kLocationApk;
    
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

    self.window.rootViewController=sideMenuViewConttroller;
    
    
    
    
    
    
    
    
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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
