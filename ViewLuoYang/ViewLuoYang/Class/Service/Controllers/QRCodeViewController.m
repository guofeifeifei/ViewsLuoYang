//
//  QRCodeViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/20.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface QRCodeViewController ()
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) UIActivityIndicatorView *activity;
@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Device
   
    [self showBarButtonWithImage:@"back_arrow"];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.resultStr]]];
    [self.view addSubview:webView];
    
    self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activity.backgroundColor = barColor;
    //显示位置
    self.activity.center = self.view.center;
    //
    // [self.activity startAnimating];
    
    [self.view addSubview:self.activity];
   
    
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activity startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activity stopAnimating];
    
}
- (void)viewWillDisappear:(BOOL)animated{
}
- (void)backButtonAction:(UIButton *)btn{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
