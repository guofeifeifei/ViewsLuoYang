//
//  UIViewController+Common.m
//  Happyholiday
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "UIViewController+Common.h"
#import "ProgressHUD.h"
#import "QRCodeReaderViewController.h"
#import "QRCodeViewController.h"
@implementation UIViewController (Common)

-(void)showBarButtonWithImage:(NSString *)imageName{
    
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 44, 44);
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *legtbtn=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=legtbtn;
    
    
}


-(void)backButtonAction{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}

- (void)showRightBarButtonWithTitle:(NSString *)title{
    
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 44, 44);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *legtbtn=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem=legtbtn;
    

    
    
    
}



- (void)showalertView:(NSString *)alertTitle andMessage:(NSString *)message andstyle:(UIAlertControllerStyle)style addAction:(NSString *)actionTitle andActionStyle:(UIAlertActionStyle)actionStyle and:(NSString *)info{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:alertTitle message:message preferredStyle:style];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:actionTitle style:actionStyle handler:^(UIAlertAction * _Nonnull action) {
        
        [ProgressHUD show:info];
        
    }];
    
    [alert addAction:action];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (void)showBarButtonWithcode{

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 25, 25);
    
    
   
   [btn setImage:[UIImage imageNamed:@"ibtn_mall_code"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(scanAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbar = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = leftbar;
    
    
    
}

- (void)scanAction{
    
    
    static QRCodeReaderViewController *reader = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        reader                        = [QRCodeReaderViewController new];
        reader.modalPresentationStyle = UIModalPresentationFormSheet;
    });
    reader.delegate = self;
    
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        NSLog(@"Completion with result: %@", resultAsString);
    }];
    
    [self presentViewController:reader animated:YES completion:NULL];
    
}

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result{
    
    
    QRCodeViewController *qrCodeVC = [[QRCodeViewController alloc] init];
    qrCodeVC.resultStr = result;
    [self presentViewController:qrCodeVC animated:YES completion:nil];
    
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader{
    
    
    [self dismissViewControllerAnimated:YES completion:NULL
     ];
}












@end
