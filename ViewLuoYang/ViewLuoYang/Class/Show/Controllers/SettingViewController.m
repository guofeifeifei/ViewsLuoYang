//
//  SettingViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/22.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "SettingViewController.h"
#import "ShowViewController.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)backShow:(id)sender {
    ShowViewController *showVC = [[ShowViewController alloc] init];
    [self presentViewController:showVC animated:NO completion:nil];
    
}

- (IBAction)cleanCPU:(id)sender {
}
- (IBAction)advice:(id)sender {
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
