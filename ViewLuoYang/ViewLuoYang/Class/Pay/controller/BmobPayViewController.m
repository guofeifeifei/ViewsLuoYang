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
#import <PassKit/PassKit.h>
#import <AddressBook/AddressBook.h>

@interface BmobPayViewController ()<BmobPayDelegate,PKPaymentAuthorizationViewControllerDelegate>

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
         //   NSLog(@"支付跳转成功");
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
//取消支付
- (IBAction)backAction:(id)sender {
  
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)applePay:(id)sender {
    
    //判断是否支持支付功能
    if ([PKPaymentAuthorizationViewController canMakePayments]) {
        
        //初始化订单请求对象
        PKPaymentRequest *requst = [[PKPaymentRequest alloc]init];
        
        //设置商品订单信息对象
        PKPaymentSummaryItem *widget1 = [PKPaymentSummaryItem summaryItemWithLabel:@"预告片" amount:[NSDecimalNumber decimalNumberWithString:@"0.01"]];
    
        //设置支付对象
        PKPaymentSummaryItem *widget4 = [PKPaymentSummaryItem summaryItemWithLabel:@"全景洛阳" amount:[NSDecimalNumber decimalNumberWithString:@"0.01"]type:PKPaymentSummaryItemTypeFinal];
        requst.paymentSummaryItems = @[widget1 ,widget4];
    
        //设置国家地区编码
        requst.countryCode = @"CN";
        //设置国家货币种类 :人民币
        requst.currencyCode = @"CNY";
        //支付支持的网上银行支付方式
        requst.supportedNetworks =  @[PKPaymentNetworkChinaUnionPay, PKPaymentNetworkMasterCard, PKPaymentNetworkVisa];
        
        //设置的支付范围限制
        requst.merchantCapabilities = PKMerchantCapabilityEMV;
        // 这里填的是就是我们创建的merchat ID  smerchant.com.QinJunzhen.ViewLuoYangs
        //        requst.merchantIdentifier = @"merchant.com.ZJF";
        requst.merchantIdentifier = @"merchant.com.QinJunzhen.ViewLuoYangs";
        
        
        //设置支付窗口
        PKPaymentAuthorizationViewController * payVC = [[PKPaymentAuthorizationViewController alloc]initWithPaymentRequest:requst];
        //设置代理
        payVC.delegate = self;
        if (!payVC) {
            //有问题  直接抛出异常
            @throw  [NSException exceptionWithName:@"CQ_Error" reason:@"创建支付显示界面不成功" userInfo:nil];
        }else
        {
            //支付没有问题,则模态出支付创口
            [self presentViewController:payVC animated:YES completion:nil];
        }
    }else{
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付结果" message:@"没有此支付功能" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
        [alter show];
        
    }
    

        
    
}


//代理的回调方法
-(void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion{
    
    //在这里将token和地址发送到自己的服务器，有自己的服务器与银行和商家进行接口调用和支付将结果返回到这里
    //我们根据结果生成对应的状态对象，根据状态对象显示不同的支付结构
    //状态对象
  //  NSLog(@"%@",payment.token);
    
    //在这里了 为了测试方便 设置为支付失败的状态
    //可以选择枚举值PKPaymentAuthorizationStatusSuccess   (支付成功)
    PKPaymentAuthorizationStatus staus = PKPaymentAuthorizationStatusSuccess;
    completion(staus);
}


//支付完成的代理方法
-(void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
   // NSLog(@"支付完成");
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付结果" message:@"支付成功" delegate:nil cancelButtonTitle: @"关闭"otherButtonTitles:nil, nil];
    [alter show];
    MoveStartViewController *moveStartVC = [[MoveStartViewController alloc] init];
    [self.navigationController pushViewController:moveStartVC animated:YES];
    
    
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
