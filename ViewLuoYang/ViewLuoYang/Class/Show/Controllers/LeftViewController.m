//
//  LeftViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/22.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "LeftViewController.h"
#import "ShowViewController.h"
#import "CollectViewController.h"
@interface LeftViewController ()
@property (weak, nonatomic) IBOutlet UIButton *seting;

//收藏按钮
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;



@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}


- (IBAction)collectAction:(id)sender {
    
//    CollectViewController *collectVC = [[CollectViewController alloc] init];
//    [self presentViewController:collectVC animated:YES completion:nil];
    
    
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
