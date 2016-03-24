//
//  SettingViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/22.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "SettingViewController.h"
#import "ProgressHUD.h"
#import <MessageUI/MessageUI.h>
#import <SDWebImage/SDImageCache.h>
@interface SettingViewController ()<MFMailComposeViewControllerDelegate, UIAlertViewDelegate>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)backShow:(id)sender {

    
    [self dismissViewControllerAnimated:YES completion:nil];
    

    
    
}

- (IBAction)cleanCPU:(id)sender {
    
    [ProgressHUD show:@"正在为你清理"];
    [self performSelector:@selector(cleanAction) withObject:nil afterDelay:5.0];
    
}
- (void)cleanAction{
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    NSInteger cachesize = [imageCache getSize];
 
    
    [imageCache cleanDisk];
    [ProgressHUD showSuccess:[NSString stringWithFormat:@"清理缓存(%.02f)M", (float)cachesize / 1024 / 1024]];
    
    
}
- (IBAction)advice:(id)sender {
    [self sendEmail];
}
- (void)sendEmail{
    Class mailClass = NSClassFromString(@"MFMailComposeViewController");
    if (mailClass != nil) {
        if ([MFMailComposeViewController canSendMail]) {
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            [picker setSubject:@"用户反馈"];
            NSArray *receiveArray = [NSArray arrayWithObjects:@"2545706530@qq.com", nil];
            [picker setToRecipients:receiveArray];
            NSString *text = @"请留下你宝贵的意见";
            [picker setMessageBody:text isHTML:YES];
            [self presentViewController:picker animated:YES completion:nil];
            
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"未配置邮箱"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            alert.delegate = self;
            [alert show];
        }
        }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前设备不能发送邮件" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"邮件发送取消" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.delegate = self;
            [alert show];

        }
            
            break;
        case MFMailComposeResultSaved:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"邮件将保存" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.delegate = self;
            [alert show];

        }
            
            break;
        case MFMailComposeResultSent:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"邮件发送成功" message:@"邮件发送成功，谢谢您的宝贵意见，我们将认真改进" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            alert.delegate = self;
            [alert show];

        }
            
            break;
        case MFMailComposeResultFailed:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"邮件发送失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.delegate = self;
            [alert show];

        }
            
            break;
        default:
            break;
    }
    
    
    
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self dismissViewControllerAnimated:YES completion:nil];
                                      
                                      
                                      
                                      
                                      
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [ProgressHUD dismiss];
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
