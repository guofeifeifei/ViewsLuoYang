//
//  RegisterViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/17.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "RegisterViewController.h"

#import "NTESDemoService.h"
#import "NSString+NTES.h"
#import "UIView+Toast.h"
#import "UIView+NTES.h"
#import "SVProgressHUD.h"
#import "UIViewController+NTES.h"


@interface RegisterViewController ()

//用户名
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

//昵称
@property (weak, nonatomic) IBOutlet UITextField *nickNameTF;

//密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
    self.passwordTF.secureTextEntry = YES;
    
    
}



//点击下一步
- (IBAction)nextBtnAction:(id)sender {
   
    
    
    
    
    
    
    
    
    NTESRegisterData *data = [[NTESRegisterData alloc] init];
    data.account = self.nameTF.text;
    data.nickname= self.nickNameTF.text;
    data.token = [self.passwordTF.text tokenByPassword];
    //判断是否符合注册条件
    if (![self check]) {
        return;
    }
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    
    [[NTESDemoService sharedService] registerUser:data
                                       completion:^(NSError *error, NSString *errorMsg)
     {
         [SVProgressHUD dismiss];
         if (error == nil) {
             [weakSelf.navigationController.view makeToast:@"注册成功"
                                                  duration:2 position:CSToastPositionCenter];
             if ([weakSelf.delegate respondsToSelector:@selector(registDidComplete:password:)]) {
                 //触发代理，回传值
                 [weakSelf.delegate registDidComplete:data.account password:self.passwordTF.text];
             }
             [weakSelf.navigationController popViewControllerAnimated:YES];
         }
         else{
             if ([weakSelf.delegate respondsToSelector:@selector(registDidComplete:password:)]) {
                 [weakSelf.delegate registDidComplete:nil password:nil];
             }
             
             NSString *toast = [NSString stringWithFormat:@"注册失败"];
             if ([errorMsg isKindOfClass:[NSString class]] &&errorMsg.length) {
                 toast = [toast stringByAppendingFormat:@": %@",errorMsg];
             }
             [weakSelf.view makeToast:toast duration:2 position:CSToastPositionCenter];
             
         }
         
     }];

    
    
}

- (BOOL)check{
    if (!self.checkAccount) {
        [self.view makeToast:@"账号长度有误"
                    duration:2
                    position:CSToastPositionCenter];
        
        return NO;
    }
    if (!self.checkPassword) {
        [self.view makeToast:@"密码长度有误"
                    duration:2
                    position:CSToastPositionCenter];
        
        return NO;
    }
    if (!self.checkNickname) {
        [self.view makeToast:@"昵称长度有误"
                    duration:2
                    position:CSToastPositionCenter];
        
        return NO;
    }
    return YES;
}

- (BOOL)checkAccount{
    NSString *account = self.nameTF.text;
    return account.length > 0 && account.length <= 20;
}

- (BOOL)checkPassword{
    NSString *checkPassword = self.passwordTF.text;
    return checkPassword.length >= 6 && checkPassword.length <= 20;
}

- (BOOL)checkNickname{
    NSString *nickname= self.nickNameTF.text;
    return nickname.length > 0 && nickname.length <= 10;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
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
