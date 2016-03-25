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
#import "ShareView.h"
#import "Collect.h"
#import "DataBaseManger.h"

@interface TitleViewController ()<UIWebViewDelegate>
{
    NSInteger i;
}
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *discussBtn;//评论
@property (nonatomic, strong) UIButton *collectBtn;//收藏
@property (nonatomic, strong) UIButton *shareBtn;//分享
@property (nonatomic, strong) UIButton *rightBtn;
@property(nonatomic, strong) UIActivityIndicatorView *activity;//刷新图标

@property (nonatomic, copy) NSString *url;//传网址


@end

@implementation TitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"电子报";
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.webView];
    [self.scrollView addSubview:self.activity];
    [self.view addSubview:self.discussBtn];
    [self.view addSubview:self.collectBtn];
    [self.view addSubview:self.shareBtn];
    
  
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.frame = CGRectMake(0, 0, 60, 44);
    [self.rightBtn setTitle:@"已收藏" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(threeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtn.tag = 4;
    //调整btn标题所在的位置，距离btn顶部，左边，底部，右边的距离
    [self.rightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    rightBarBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    
    //创建数据库管理对象
    DataBaseManger *dbManger = [DataBaseManger shareInstance];
    //打开数据库
    [dbManger openDataBase];
    
    
    
    
}

#pragma mark -------- lazyLoading
- (UIActivityIndicatorView *)activity{
    if (_activity == nil) {
        //刷新
        self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activity.backgroundColor = barColor;

        //显示位置
        self.activity.center = self.scrollView.center;

    }
    return _activity;
}

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-108)];
    }
    return _scrollView;
}


- (UIWebView *)webView{
    if (_webView == nil) {
        self.webView = [[UIWebView alloc] initWithFrame:self.scrollView.frame];
        self.url = [NSString stringWithFormat:@"%@/%@/%@",kArticle,self.paperId,self.nsid];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        self.webView.delegate = self;
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
    
    DataBaseManger *dbManger = [DataBaseManger shareInstance];
    
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
                    //收藏
            i +=1;
            if (i % 2 == 0) {
                [self.collectBtn setImage:[UIImage imageNamed:@"recom_collection_02n"] forState:UIControlStateNormal];
                [ProgressHUD showSuccess:@"取消收藏"];
                
                //删除url
                
                [dbManger deleteColectWithUrl:self.url];
                
                
            }else{
                [self.collectBtn setImage:[UIImage imageNamed:@"people_star"] forState:UIControlStateNormal];
                [ProgressHUD showSuccess:@"收藏成功"];
                Collect *shoucang = [Collect collectWithUrl:self.url image:self.image];
                
                //添加url
                [dbManger insertIntoNewUrl:shoucang];
                if (shoucang) {
                    [self.collectBtn setImage:[UIImage imageNamed:@"people_star"] forState:UIControlStateNormal];
                }
                
                
           
            
   
    
            }
    

        }

            break;
        case 3:
        {
            //分享
            [self share];
            
            
        }
            break;
        case 4:
        {
            //已收藏
            CollectViewController *collectVC = [[CollectViewController alloc] init];
            
            [self.navigationController pushViewController:collectVC animated:YES];
            
            //查看所有url
            [dbManger selectAllUrl];
            
            
            
            
            
        }
            
        default:
            break;
    }
    
}


//分享
- (void)share{
    UIWindow *window = [[UIApplication sharedApplication ].delegate window];
    
    ShareView *shareView = [[ShareView alloc] init];
    //属性传值，把需要分享用到的url传到下一页
    shareView.url = self.url;
    
    [window addSubview:shareView];
    return;
    
}


//刷新方法：
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
