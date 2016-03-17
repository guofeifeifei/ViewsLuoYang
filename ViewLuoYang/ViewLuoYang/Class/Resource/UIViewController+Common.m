//
//  UIViewController+Common.m
//  Happyholiday
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "UIViewController+Common.h"
#import "ProgressHUD.h"
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







@end
