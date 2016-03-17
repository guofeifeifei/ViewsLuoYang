//
//  TitleViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/17.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "TitleViewController.h"

@interface TitleViewController ()
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation TitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
    self.title = @"电子报";
    self.view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.webView];
}






- (UIWebView *)webView{
    if (_webView == nil) {
        self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://shouji.lyd.com.cn/p/2/60374"]];
        [self.webView loadRequest:request];
    }
    return _webView;
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
