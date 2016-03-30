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
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, - 50, 0, 0)];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *legtbtn=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem=legtbtn;
    
    
}


-(void)backButtonAction{
    
    [self.navigationController popViewControllerAnimated:YES];
    

}

- (void)showRightBarButtonWithTitle:(NSString *)title{
    
    
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 44, 44);
   
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *legtbtn=[[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem=legtbtn;
    

    
    
    
}


// 提示框

- (void)alertViewTitile:(NSString *)title{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:action];
    [alert addAction:action1];
    
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
    NSLog(@"调用系统相机");
    
    
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

//二维码
- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result{
    
        QRCodeViewController *qrCodeVC = [[QRCodeViewController alloc] init];
    qrCodeVC.resultStr = result;
    [self presentViewController:qrCodeVC animated:YES completion:nil];
    
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader{
    
    
    [self dismissViewControllerAnimated:YES completion:NULL
     ];
}







- (void)showMeButton{
    //左侧按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 25, 25);
    [leftBtn setImage:[UIImage imageNamed:@"ic_select_phost_lz_on"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, - 10, 0, 0)];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;

}




@end
