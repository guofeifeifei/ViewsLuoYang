//
//  MoveViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/23.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "MoveViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "ZMYNetManager.h"
#import <SDWebImage/SDImageCache.h>

@interface MoveViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) AVAudioPlayer *avAudiopleayer;
@property (nonatomic, strong) NSString *musicbackground;
@property (weak, nonatomic) IBOutlet UIImageView *imagebackground;
@property (weak, nonatomic) IBOutlet UIView *Viewscroll;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipe;

@property (strong, nonatomic)  NSDictionary *mvobj;




@end

@implementation MoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    self.view.backgroundColor = [UIColor blackColor];
   
//    self.navigationController.navigationBar.translucent = NO;
//    self.swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(imageActionse)];
//    self.swipe.direction = UISwipeGestureRecognizerDirectionUp;
//    [self.scrollView addGestureRecognizer:self.swipe];
//    self.scrollView.userInteractionEnabled = YES;
//       self.view.userInteractionEnabled= YES;
    
}

- (void)loadData{
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的网络有问题，请检查网络" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    [sessionManager GET:kmovie parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
         NSLog(@"downloadProgress = %@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject = %@", responseObject);
        NSDictionary *dic = responseObject;
       self.mvobj = dic[@"mvobj"];
        NSString *image = self.mvobj[@"bgImg"];
        self.musicbackground = self.mvobj[@"bgmusic"];
        NSLog(@"ssssssssssmusicbackground = %@", self.musicbackground);
                 [self.imagebackground sd_setImageWithURL:[NSURL URLWithString:image] completed:nil];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 377, 80, 30)];
        lable.text = self.mvobj[@"cnTitle"];
        lable.font = [UIFont systemFontOfSize:20.0f];
        lable.textColor = [UIColor whiteColor];
        [self.scrollView addSubview:lable];
      
        UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 377 + 30, 200, 30)];
        lable2.text = self.mvobj[@"enTitle"];
         lable2.textColor = [UIColor grayColor];
       
        [self.scrollView addSubview:lable2];
        
        UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 377 + 30 + 30, 200, 30)];
        lable3.text = self.mvobj[@"genre"];
         lable3.textColor = [UIColor grayColor];
 
        [self.scrollView addSubview:lable3];
        UILabel *lable4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 377 + 30 + 30 + 30, 200, 44)];
        lable4.text = @"剧情简介";
        lable4.font = [UIFont systemFontOfSize:20.0f];
        lable4.textColor = [UIColor grayColor];
     
        [self.scrollView addSubview:lable4];
        
        UILabel *lable6 = [[UILabel alloc] initWithFrame:CGRectMake(20, 377 + 30 + 30 + 30 + 44, KScreenWidth - 40, 200)];
        lable6.numberOfLines = 0;
        lable6.text = self.mvobj[@"shortSummary"];
        lable6.textColor = [UIColor whiteColor];
        [self.scrollView addSubview:lable6];
      
        
        NSDictionary *dicbackReport = self.mvobj[@"backReport"];
        NSArray *list = dicbackReport[@"list"];
        NSDictionary *dicList = list[0];
        NSString *movieUrl = dicList[@"movieUrl"];
      //存储到设置里面
        NSUserDefaults *setDefaults = [NSUserDefaults standardUserDefaults];
        [setDefaults setObject:movieUrl forKey:@"movieUrl"];
        [setDefaults synchronize];
        [self.avAudiopleayer prepareToPlay];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"error = %@", error);
    }];
    }
    
   
}
- (AVAudioPlayer *)avAudiopleayer{
    if (_avAudiopleayer == nil) {
         //self.musicbackground = self.mvobj[@"bgmusic"];
        NSLog(@"xxxxxxxxxmusicbackground = %@", self.musicbackground);
        NSString *url = nil;
        
    if ([self.musicbackground hasPrefix:@"http://"]  ) {
           url = @"http://fastwebcache.yod.cn/a00E0000003pYMHIA2/201012211292916799817_15.mp3";
       }else{
         url = self.musicbackground;
     }
         NSURL *urlStr = [[NSURL alloc] initWithString:url];
        NSData *audioPath = [NSData dataWithContentsOfURL:urlStr];
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath, @"temp"];
        [audioPath writeToFile:filePath atomically:YES];
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        self.avAudiopleayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
        self.avAudiopleayer.delegate = self;
        
       
        [self.avAudiopleayer play];
        
    }
    return _avAudiopleayer;
    
}
- (NSDictionary *)mvobj{
    if (_mvobj == nil) {
        _mvobj  = [NSDictionary new];
    }
    return _mvobj;
    
    
}
- (void)updateViewConstraints{
    [super updateViewConstraints];
    self.height.constant = CGRectGetHeight([UIScreen mainScreen].bounds) + 50;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = barColor;

    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.tabBarController.tabBar.hidden = YES;
     self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
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
