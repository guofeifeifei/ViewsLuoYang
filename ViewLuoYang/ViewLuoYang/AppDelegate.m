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


#import "LinkMan.h"
#import "DateBaseUserManager.h"

//消息
#import "NIMSDK.h"
#import "NTESDemoConfig.h"
#import "NIMKit.h"
#import "NTESService.h"
#import "NTESNotificationCenter.h"
#import "NTESLogManager.h"
#import "NTESDemoConfig.h"
#import "NTESSessionUtil.h"
#import "NTESMainTabController.h"
#import "NTESLoginManager.h"
#import "NTESCustomAttachmentDecoder.h"
#import "NTESClientUtil.h"
#import "NTESNotificationCenter.h"
#import "NTESDataManager.h"
NSString *NTESNotificationLogout = @"NTESNotificationLogout";



@interface AppDelegate ()<NIMLoginManagerDelegate>//登陆协议
@property(nonatomic, strong)UITabBarController *tabbar;

@property(nonatomic, strong)RESideMenu *sideMenuViewConttroller;

@end

@implementation AppDelegate

@synthesize wbtoken=_wbtoken;

#pragma mark - logic impl
- (void)setupServices
{
    [[NTESLogManager sharedManager] start];
    [[NTESNotificationCenter sharedCenter] start];
}

#pragma mark - misc
- (void)registerAPNs
{
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
}



- (void)commonInitListenEvents
{
    //添加通知
    [[NSNotificationCenter defaultCenter]addObserver:self  selector:@selector(doLogout) name:NTESNotificationLogout
            object:nil];
    
    [[[NIMSDK sharedSDK] loginManager] addDelegate:self];
}

- (void)doLogout
{
    [[NTESLoginManager sharedManager] setCurrentLoginData:nil];
    [[NTESServiceManager sharedManager] destory];
    
    self.window.rootViewController=self.sideMenuViewConttroller;
    
}
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[NIMSDK sharedSDK] updateApnsToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    DDLogInfo(@"receive remote notification:  %@", userInfo);
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    DDLogError(@"fail to get apns token :%@",error);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[[NIMSDK sharedSDK] loginManager] removeDelegate:self];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //消息注册
    
    NSString *appKey = [[NTESDemoConfig sharedConfig] appKey];
    NSString *cerName= [[NTESDemoConfig sharedConfig] cerName];
    
    [[NIMSDK sharedSDK] registerWithAppID:appKey
                                  cerName:cerName];
    
    [NIMCustomObject registerCustomDecoder:[NTESCustomAttachmentDecoder new]];
    //注册apn
    [self registerAPNs];
    [self commonInitListenEvents];
    [[NIMKit sharedKit] setProvider:[NTESDataManager sharedInstance]];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    
    
    //新浪微博分享
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    [WXApi registerApp:kWeixinAppSecret];
    
    
    
    [AMapSearchServices sharedServices].apiKey = kLocationApk;
    
    [AMapLocationServices sharedServices].apiKey = kLocationApk;
    
    self.tabbar=[[UITabBarController alloc]init];
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
    
    self.tabbar.tabBar.tintColor=[UIColor redColor];
    
    self.tabbar.viewControllers=@[showNav,newNav,messageNav,serviceNav];
    
    self.sideMenuViewConttroller = [[RESideMenu alloc] initWithContentViewController:self.tabbar leftMenuViewController:leftVC rightMenuViewController:nil];
    
    self.sideMenuViewConttroller.backgroundImage = [UIImage imageNamed:@"Stars"];
    self.sideMenuViewConttroller.menuPreferredStatusBarStyle = 1;
    self.sideMenuViewConttroller.delegate = self;
    self.sideMenuViewConttroller.contentViewShadowColor = [UIColor blackColor];
    self.sideMenuViewConttroller.contentViewShadowOffset = CGSizeMake(0, 0);
    self.sideMenuViewConttroller.contentViewShadowOpacity = 0.6;
    self.sideMenuViewConttroller.contentViewShadowRadius = 12;
    self.sideMenuViewConttroller.contentViewShadowEnabled = YES;

    self.window.rootViewController=self.sideMenuViewConttroller;
    
    
    
    
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}




#pragma mark ------- shareWeibo
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self] && [WXApi handleOpenURL:url delegate:self];
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    
    
    return [WeiboSDK handleOpenURL:url delegate:self] && [WXApi handleOpenURL:url delegate:self];

    
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

#pragma mark ---微博代理
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    NSString *accessToken = [(WBAuthorizeResponse *)response accessToken];
    NSString *uid = [(WBAuthorizeResponse *)response userID];
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"application/json"];
    
    [manager GET:[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",accessToken,uid] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        NSDictionary *dic=responseObject;
        
        NSString *followers=[NSString stringWithFormat:@"%@",dic[@"followers_count"]];
        
        
        LinkMan *link=[LinkMan linkManWithName:dic[@"name"] andheadImage:dic[@"avatar_hd"] gender:dic[@"gender"] andcity:dic[@"location"] andfollowers:followers];
        
        DateBaseUserManager *manager=[DateBaseUserManager sharedInstance];
        [manager openDateBase];
        [manager insertIntoLinkMans:link];
        [manager closeDateBase];
       
        
        
        [self.sideMenuViewConttroller presentLeftMenuViewController];
        
        
        
     
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
 
    
}




@end
