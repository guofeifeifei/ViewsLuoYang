//
//  MoveStartViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/27.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "MoveStartViewController.h"

@interface MoveStartViewController ()
@property(nonatomic, strong) MPMoviePlayerViewController *moviePlayer;
@property(nonatomic, strong) UIProgressView *progressView;
@property(nonatomic, copy) NSString *urlstr;
@property(nonatomic, strong) NSTimer *timer;
@end

@implementation MoveStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self showBarButtonWithImage:@"back_arrow"];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(100, 100, 40, 40);
//    [btn setTitle:@"订单查询" forState:UIControlStateNormal];
//    [self.moviePlayer.view addSubview:btn];
    NSUserDefaults *movie = [NSUserDefaults standardUserDefaults];
    NSString *movieUrl = [movie objectForKey:@"movieUrl"];
    NSLog(@"%@", movieUrl);
    self.urlstr = movieUrl;
    [self.view addSubview:self.moviePlayer.view];
}
- (MPMoviePlayerViewController *)moviePlayer{
    if (_moviePlayer == nil) {
        self.moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:self.urlstr]];
        self.moviePlayer.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        self.moviePlayer.modalPresentationStyle = UIModalPresentationFullScreen;
     

    }
    return _moviePlayer;
    
    
    
    
    
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
