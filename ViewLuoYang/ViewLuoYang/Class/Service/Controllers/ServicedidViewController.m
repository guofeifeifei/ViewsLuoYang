//
//  ServicedidViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "ServicedidViewController.h"
#import "ProgressHUD.h"
@interface ServicedidViewController ()<UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) UIActivityIndicatorView *activity;
@end

@implementation ServicedidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.title = self.typeTitle;
      self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.path]]];
    
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    
  self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activity.backgroundColor = barColor;
    //显示位置
    self.activity.center = self.view.center;
    //
    // [self.activity startAnimating];
    
    [self.view addSubview:self.activity];
    [self showBarButtonWithImage:@"back_arrow"];
    
   
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activity startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activity stopAnimating];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
}
   
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//      [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('adpic')[0].style.display = 'none'"];
//}
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
