//
//  CollectResultViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/22.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "CollectResultViewController.h"

@interface CollectResultViewController ()<UIWebViewDelegate>
@property(nonatomic, strong) UIActivityIndicatorView *activity;//刷新图标

@end

@implementation CollectResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"已经收藏";
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    webView.delegate = self;
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activity.backgroundColor = barColor;
    //显示位置
    self.activity.center = self.view.center;
    [self.view addSubview:self.activity];
}

//刷新
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activity startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activity stopAnimating];
    
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
