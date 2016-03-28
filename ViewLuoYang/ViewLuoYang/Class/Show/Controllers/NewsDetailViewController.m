//
//  NewsDetailViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()<UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) UIActivityIndicatorView *activity;
@property(nonatomic, strong) UILabel *lable;
@property(nonatomic, strong) UILabel *appearlabel;
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.activity];
    [self.view addSubview:self.lable];
    [self.webView.scrollView addSubview:self.appearlabel];

}

- (UIWebView *)webView{

    if (_webView==nil) {
        self.webView=[[UIWebView alloc]initWithFrame:self.view.frame];
        
        NSURLRequest *request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.detailUrl]];
        self.webView.scrollView.showsVerticalScrollIndicator = NO;
        self.webView.scrollView.bounces = NO;
        [self.webView loadRequest:request];
    }
    
    
    return _webView;
}



- (UILabel *)appearlabel{
    
    if (_appearlabel==nil) {
        _appearlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 150, KScreenWidth, 120)];
        _appearlabel.backgroundColor=[UIColor whiteColor];
    }
    
    
    return _appearlabel;
}




- (void)webViewDidFinishLoad:(UIWebView *)webView{

}






- (UIActivityIndicatorView *)activity{
    if (_activity == nil) {
        self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activity.backgroundColor = barColor;
        //显示位置
        self.activity.center = self.view.center;
        //
        // [self.activity startAnimating];

    }

    return _activity;
}




- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activity startAnimating];
}

- (UILabel *)lable{
    if (_lable == nil) {
        self.lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 80)];
        self.lable.backgroundColor = barColor;
        self.lable.text = @"全景洛阳欢迎您";
        self.lable.textAlignment = NSTextAlignmentCenter;
        self.lable.font = [UIFont systemFontOfSize:21.0f];
        self.lable.textColor = [UIColor whiteColor];
    }
    return _lable;
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
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
