//
//  TitleViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/17.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "TitleViewController.h"
#import "DiscussViewController.h"
#import "ProgressHUD.h"
#import "CollectViewController.h"
@interface TitleViewController ()
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *discussBtn;//评论
@property (nonatomic, strong) UIButton *collectBtn;//收藏
@property (nonatomic, strong) UIButton *shareBtn;//分享
@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation TitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
    self.title = @"电子报";
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.webView];
    [self.view addSubview:self.discussBtn];
    [self.view addSubview:self.collectBtn];
    [self.view addSubview:self.shareBtn];
    
    
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(0, 0, 60, 44);
    [self.rightBtn setTitle:@"已收藏" forState:UIControlStateNormal];
    //调整btn标题所在的位置，距离btn顶部，左边，底部，右边的距离
    [self.rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    rightBarBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    

}

#pragma mark -------- lazyLoading

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-108)];
    }
    return _scrollView;
}


- (UIWebView *)webView{
    if (_webView == nil) {
        self.webView = [[UIWebView alloc] initWithFrame:self.scrollView.frame];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@",kArticle,self.paperId,self.nsid]]];
        [self.webView loadRequest:request];
        
    }
    return _webView;
}
//评论
- (UIButton *)discussBtn{
    if (_discussBtn == nil) {
        self.discussBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.discussBtn.frame = CGRectMake(0, KScreenHeight-108, KScreenWidth/3, 44);
        self.discussBtn.tag = 1;
        self.discussBtn.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
        self.discussBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.discussBtn setTitle:@"评论" forState:UIControlStateNormal];
        [self.discussBtn setImage:[UIImage imageNamed:@"recom_comment"] forState:UIControlStateNormal];
        [self.discussBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.discussBtn addTarget:self action:@selector(threeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _discussBtn;
}
//收藏
- (UIButton *)collectBtn{
    if (_collectBtn == nil) {
        self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.collectBtn.frame = CGRectMake(KScreenWidth/3, KScreenHeight-108, KScreenWidth/3, 44);
        self.collectBtn.tag = 2;
        self.collectBtn.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
        self.collectBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [self.collectBtn setImage:[UIImage imageNamed:@"recom_collection_02n"] forState:UIControlStateNormal];
        [self.collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.collectBtn addTarget:self action:@selector(threeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}
//分享
- (UIButton *)shareBtn{
    if (_shareBtn == nil) {
        self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.shareBtn.frame = CGRectMake(KScreenWidth/3*2, KScreenHeight-108, KScreenWidth/3, 44);
        self.shareBtn.tag = 3;
        self.shareBtn.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
        self.shareBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [self.shareBtn setImage:[UIImage imageNamed:@"recom_share"] forState:UIControlStateNormal];
        [self.shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.shareBtn addTarget:self action:@selector(threeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

#pragma mark -------- 3个按钮点击方法

- (void)threeBtnAction:(UIButton *)btn{
    switch (btn.tag) {
        case 1:
        {
            //评论
            DiscussViewController *discussVC = [[DiscussViewController alloc] init];
            
            [self.navigationController pushViewController:discussVC animated:YES];

        }
            break;
        case 2:
        {
            /*
             点击收藏是的接口：http://shouji.lyd.com.cn/tools/user/addFavorite
             打开收藏页面接口：http://hm.baidu.com/hm.gif?cc=0&ck=1&cl=32-bit&ds=320x570&ep=124629%2C124630&et=3&ja=1&ln=zh-CN&lo=0&lt=1458353341&nv=0&rnd=317449245&si=22a1fd52d71d27a688f488ceb244d3f8&st=4&v=1.1.26&lv=2
*/
            
            
            //收藏
            [self.collectBtn setImage:[UIImage imageNamed:@"people_star"] forState:UIControlStateNormal];
            
            [ProgressHUD showSuccess:@"收藏成功"];
            
            
            
            
        }
            
            break;
        case 3:
        {
            //分享
            [self share];
            
            
        }
            break;
            
        default:
            break;
    }
    
}



#pragma  mark ----------- rightBtn点击方法
- (void)rightBtnAction{
    CollectViewController *collectVC = [[CollectViewController alloc] init];
    [self.navigationController pushViewController:collectVC animated:YES];
}

- (void)share{
    
    
    
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
