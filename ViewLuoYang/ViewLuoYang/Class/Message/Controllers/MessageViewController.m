//
//  MessageViewController.m
//  AllViewOfLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "MessageViewController.h"
#import "LoginViewController.h"



//判断是否有缓存账号
#import "NTESSessionViewController.h"
#import "NTESMainTabController.h"
#import "NTESLoginManager.h"
#import "NTESNotificationCenter.h"


@interface MessageViewController ()
@property (nonatomic, strong) UIImageView *imageView;//图片
@property (nonatomic, strong) UILabel *lable;
@property (nonatomic, strong) UIButton *loginBtn;//登录按钮

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息";
    [self showBarButtonWithcode];
//    //去掉navigationBar下的黑色线条
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor] , NSFontAttributeName:[UIFont systemFontOfSize:18.0f]}];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //查看数据库，如果有缓存的用户，就直接登陆，没有就去登陆
    [self setupMainViewController];
    
       
}




- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden=NO;
    [self setupMainViewController];
    
}



//查看数据库，如果有缓存的用户，就不用登陆

- (void)setupMainViewController
{
    LoginData *data = [[NTESLoginManager sharedManager] currentLoginData];
    NSString *account = [data account];
    NSString *token = [data token];
    
    //如果有缓存用户名密码推荐使用自动登录
    if ([account length] && [token length])
    {
        [[[NIMSDK sharedSDK] loginManager] autoLogin:account
                                               token:token];
        [[NTESServiceManager sharedManager] start];
        NTESMainTabController *mainTab = [[NTESMainTabController alloc] initWithNibName:nil bundle:nil];
        
        [self.navigationController pushViewController:mainTab animated:YES];
        
    }else{
        
        [self.view addSubview:self.imageView];
        [self.view addSubview:self.lable];
        [self.view addSubview:self.loginBtn];
        
        
    }
  
}

#pragma mark ------- lazyLoading
- (UIImageView *)imageView{
    if (_imageView == nil) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth/2-30, KScreenHeight/2-120, KScreenWidth/8, 60)];
        self.imageView.image = [UIImage imageNamed:@"img_login_forum"];
    }
    return _imageView;
}

- (UILabel *)lable{
    if (_lable == nil) {
        self.lable = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/4, KScreenHeight/2-44, KScreenWidth/2, 40)];
        self.lable.text = @"登陆后和朋友聊天吧";
        self.lable.textColor = [UIColor lightGrayColor];
        self.lable.textAlignment = NSTextAlignmentCenter;
        self.lable.font = [UIFont systemFontOfSize:14.0];
    }
    return _lable;
}
- (UIButton *)loginBtn{
    if (_loginBtn == nil) {
        self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.loginBtn.frame = CGRectMake(KScreenWidth/4, KScreenHeight/2, KScreenWidth/2, 44);
        self.loginBtn.backgroundColor = barColor;
        [self.loginBtn setTitle:@"去登录" forState:UIControlStateNormal];
        [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (void)loginAction{
    UIStoryboard *loginStoryBoard = [UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil];
    LoginViewController *loginVC = [loginStoryBoard instantiateViewControllerWithIdentifier:@"loginVC"];
    [self.navigationController pushViewController:loginVC animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
