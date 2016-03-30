//
//  courenaoViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/28.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "courenaoViewController.h"

@interface courenaoViewController ()

@end

@implementation courenaoViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self alertViewTitile:@"当前无热闹可凑"];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self alertViewTitile:@"当前无热闹可凑"];
    
    
}
- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
