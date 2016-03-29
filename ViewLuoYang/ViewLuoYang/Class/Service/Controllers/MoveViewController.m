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

@interface MoveViewController ()
@property (nonatomic, strong) AVAudioPlayer *avAudiopleayer;
@property (nonatomic, strong) NSString *musicbackground;
@property (weak, nonatomic) IBOutlet UIImageView *imagebackground;
@property (weak, nonatomic) IBOutlet UIView *Viewscroll;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipe;
@end

@implementation MoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    self.view.backgroundColor = [UIColor blackColor];
   
    self.navigationController.navigationBar.translucent = NO;
    self.swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(imageActionse)];
    self.swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:self.swipe];
    
    
    [UIView animateWithDuration:5.0 animations:^{
        CGRect frame = [self.imagebackground frame];
        CGRect frame1 = [self.scrollView frame];
//        if (isNavigationButtonShow) {
//            frame.origin.y -= frame.size.height;
//            frame1.origin.y+=frame1.size.height;
//        } else {
//            frame.origin.y+= frame.size.height;
//            frame1.origin.y-=frame1.size.height;
//        }
        
        [UIView beginAnimations:nil context:nil];
        [self.imagebackground setAnimationDuration:0.3];
        [self.imagebackground setFrame:frame];
        [self.scrollView setFrame:frame1];
        [UIView commitAnimations];
        
       
        
    } completion:^(BOOL finished) {
        
    }];
    

    

    
}
//- (void)updateViewConstraints{
//    [super updateViewConstraints];
//    self.scrollView.constraints = CGRectGetHeight();
//    
//    
//}
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
        NSDictionary *mvobj = dic[@"mvobj"];
        NSString *image = mvobj[@"bgImg"];
        self.musicbackground = mvobj[@"bgmusic"];
        [self.imagebackground sd_setImageWithURL:[NSURL URLWithString:image] completed:nil];
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 377, 80, 30)];
        lable.text = mvobj[@"cnTitle"];
        lable.font = [UIFont systemFontOfSize:20.0f];
        lable.textColor = [UIColor whiteColor];
        [self.scrollView addSubview:lable];
      
        UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 377 + 30, 200, 30)];
        lable2.text = mvobj[@"enTitle"];
         lable2.textColor = [UIColor grayColor];
       
        [self.scrollView addSubview:lable2];
        
        UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 377 + 30 + 30, 200, 30)];
        lable3.text = mvobj[@"genre"];
         lable3.textColor = [UIColor grayColor];
 
        [self.scrollView addSubview:lable3];
        UILabel *lable4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 377 + 30 + 30 + 30, 200, 44)];
        lable4.text = @"剧情简介";
        lable4.font = [UIFont systemFontOfSize:20.0f];
        lable4.textColor = [UIColor grayColor];
     
        [self.scrollView addSubview:lable4];
        
        UILabel *lable6 = [[UILabel alloc] initWithFrame:CGRectMake(20, 377 + 30 + 30 + 30 + 44, KScreenWidth - 40, 200)];
        lable6.numberOfLines = 0;
        lable6.text = mvobj[@"shortSummary"];
        lable6.textColor = [UIColor whiteColor];
        [self.scrollView addSubview:lable6];
      
        
        NSDictionary *dicbackReport = mvobj[@"backReport"];
        NSArray *list = dicbackReport[@"list"];
        NSDictionary *dicList = list[0];
        NSString *movieUrl = dicList[@"movieUrl"];
      //存储到设置里面
        NSUserDefaults *setDefaults = [NSUserDefaults standardUserDefaults];
        [setDefaults setObject:movieUrl forKey:@"movieUrl"];
        [setDefaults synchronize];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"error = %@", error);
    }];
    }
    
}
- (AVAudioPlayer *)avAudiopleayer{
    if (_avAudiopleayer == nil) {
        NSURL *urlStr = [[NSURL alloc] initWithString:self.musicbackground];
        NSData *audioPath = [NSData dataWithContentsOfURL:urlStr];
        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath, @"temp"];
        [audioPath writeToFile:filePath atomically:YES];
        NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
        self.avAudiopleayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
        self.avAudiopleayer.delegate = self;
        
        
        
        
    }
    return _avAudiopleayer;
    
}
- (void)updateViewConstraints{
    [super updateViewConstraints];
    self.height.constant = CGRectGetHeight([UIScreen mainScreen].bounds) + 50;
    
}
- (void)imageActionse{
    
    NSLog(@"向下滑动");
    
    
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.avAudiopleayer play];
    
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
