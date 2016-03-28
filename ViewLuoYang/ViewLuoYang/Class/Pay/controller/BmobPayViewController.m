//
//  BmobPayViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/27.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "BmobPayViewController.h"
#import <BmobPay/BmobPay.h>
#import "MoveStartViewController.h"
#import "MoveStartViewController.h"
@interface BmobPayViewController ()<BmobPayDelegate>

@end

@implementation BmobPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self showBarButtonWithImage:@"back_arrow"];
    self.navigationController.navigationBar.barTintColor = barColor;
    self.navigationController.navigationBar.translucent = NO;
}

- (IBAction)bmobPayBtn:(id)sender {
    BmobPay *bPay = [[BmobPay alloc] init];
    //设置代理
    bPay.delegate = self;
    //设置商品价格
  
    [bPay setPrice:[NSNumber numberWithDouble:0.01]];
//设置商品名
    [bPay setProductName:@"预告片"];
    
    //设置商品表述
    [bPay setBody:@"预告片抢先看"];
    //appscheme为创建URL SChemes中添加标识符
    [bPay setAppScheme:@"appScheme"];
//调用支付宝
    [bPay payInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"支付跳转成功");
        }else{
            NSLog(@"%@", [error description]);
        }
    }];
    

    
}
- (void)paySuccess{
    
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付结果" message:@"支付成功" delegate:nil cancelButtonTitle: @"关闭"otherButtonTitles:nil, nil];
    [alter show];
    MoveStartViewController *moveStartVC = [[MoveStartViewController alloc] init];
    [self.navigationController pushViewController:moveStartVC animated:YES];
}
- (void)payFailWithErrorCode:(int)errorCode{
    NSLog(@"errorCode = %d", errorCode);
    switch (errorCode) {
        case 6001:{
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付结果" message:@"用户中途取消" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
            [alter show];
        }
            break;
        case 6002:{
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付结果" message:@"网络连接出错" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
            [alter show];
        }
            break;
            
        case 4000:{
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付结果" message:@"订单支付失败" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
            [alter show];
        }
            break;

      
    }
    
    
}

- (IBAction)backAction:(id)sender {
  
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.tabBarController.tabBar.hidden = YES;
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
