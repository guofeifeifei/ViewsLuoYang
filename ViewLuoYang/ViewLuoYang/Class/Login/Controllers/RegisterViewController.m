//
//  RegisterViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/17.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
//手机号
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *verifyTF;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
}




//获取验证码
- (IBAction)GetVerificationCodeAction:(id)sender {
    
    
    
}




//点击下一步
- (IBAction)nextBtnAction:(id)sender {
    
    
    
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
