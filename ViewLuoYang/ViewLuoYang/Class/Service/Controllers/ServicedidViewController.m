//
//  ServicedidViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "ServicedidViewController.h"

@interface ServicedidViewController ()<UIWebViewDelegate>
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) UIActivityIndicatorView *activity;
@property(nonatomic, strong) UILabel *lable;
@end

@implementation ServicedidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.title = self.typeTitle;
        [self.view addSubview:self.webView];
    NSLog(@"self.pathm = %@", self.path);
   
    
    [self.view addSubview:self.activity];
    [self showBarButtonWithImage:@"back_arrow"];
        [self.view addSubview:self.lable];
}
- (UIWebView *)webView{
    if (_webView == nil) {
        self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.path]]];
        self.webView.backgroundColor = [UIColor whiteColor];
        self.webView.opaque = NO;
        self.webView.delegate = self;
        self.webView.scrollView.showsVerticalScrollIndicator = NO;
        self.webView.scrollView.bounces = NO;

    }
    return _webView;
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

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activity stopAnimating];
//     [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('ad')[0].style.display = 'none'"];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (UILabel *)lable{
    if (_lable == nil) {
        self.lable = [[UILabel alloc] initWithFrame:CGRectMake(0, KScreenHeight - 100, KScreenWidth, 40)];
        self.lable.backgroundColor = barColor;
        self.lable.text = @"全景洛阳欢迎您";
        self.lable.textAlignment = NSTextAlignmentCenter;
        self.lable.font = [UIFont systemFontOfSize:18.0f];
        self.lable.textColor = [UIColor whiteColor];
    }
    return _lable;
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
