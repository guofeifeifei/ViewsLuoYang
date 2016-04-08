//
//  LoginViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/17.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "LoginViewController.h"
#import "WeiboSDK.h"

#import "NTESLoginViewController.h"
#import "NTESSessionViewController.h"
#import "NTESSessionUtil.h"
#import "NIMSDK.h"
#import "NTESMainTabController.h"
#import "UIView+Toast.h"
#import "SVProgressHUD.h"
#import "NTESService.h"
#import "UIView+NTES.h"
#import "NSString+NTES.h"
#import "NTESLoginManager.h"
#import "NTESNotificationCenter.h"
#import "UIActionSheet+NTESBlock.h"
#import "NTESLogManager.h"
#import "NTESRegisterViewController.h"
#import "UIViewController+NTES.h"
#import "AppDelegate.h"


#import "RegisterViewController.h"

@interface LoginViewController ()<RegisterViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
    self.passwordTF.secureTextEntry = YES;
    
}





//点击注册回传值
- (void)registDidComplete:(NSString *)account password:(NSString *)password
{
    
    self.nameTF.text=account;
    self.passwordTF.text=password;
    
    
}



//登录
- (IBAction)loginAction:(id)sender {
     
    [self.nameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    
    NSString *username = [self.nameTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = self.passwordTF.text;
    [SVProgressHUD show];
    
    
    NSString *loginAccount = username;
    NSString *loginToken   = [password tokenByPassword];
    
    //手动登陆
    [[[NIMSDK sharedSDK] loginManager] login:loginAccount
    token:loginToken completion:^(NSError *error) {
    [SVProgressHUD dismiss];
    if (error == nil)
    {
        LoginData *sdkData = [[LoginData alloc] init];
        sdkData.account   = loginAccount;
        sdkData.token     = loginToken;
        [[NTESLoginManager sharedManager] setCurrentLoginData:sdkData];
        
        [[NTESServiceManager sharedManager] start];
        
        
        NTESMainTabController * mainTab = [[NTESMainTabController alloc] initWithNibName:nil bundle:nil];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIViewController *vc = delegate.tabbar.viewControllers[2];
        vc = mainTab;
       [self.navigationController popToRootViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 44, 44);
        UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = barBtn;
        
    }else
    {   //存在错误
        NSString *toast = [NSString stringWithFormat:@"登录失败 code: %zd",error.code];
        [self.view makeToast:toast duration:2.0 position:CSToastPositionCenter];
    }
    }];
    
    
}
//立即注册
- (IBAction)registerAction:(id)sender {
    
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
    
    RegisterViewController *regist=[story instantiateViewControllerWithIdentifier:@"Regiest"];
    
    
    regist.delegate=self;
    
    
    [self.navigationController pushViewController:regist animated:YES];
    

    
    
    
}

//忘记密码
- (IBAction)lostPasswordActiom:(id)sender {
    
    
}

//微信登录
- (IBAction)weixinAction:(id)sender {
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURL;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];

    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
     [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
