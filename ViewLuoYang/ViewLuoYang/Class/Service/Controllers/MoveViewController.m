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
@interface MoveViewController ()

@end

@implementation MoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    
    
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
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [sessionManager GET:kmovie parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    }
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
