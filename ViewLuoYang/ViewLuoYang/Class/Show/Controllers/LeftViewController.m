//
//  LeftViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/22.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "LeftViewController.h"
#import "ShowViewController.h"

//判断是否有缓存账号
#import "NTESSessionViewController.h"
#import "NTESMainTabController.h"
#import "NTESLoginManager.h"
#import "NTESNotificationCenter.h"

#import "DateBaseUserManager.h"
#import "LinkMan.h"

@interface LeftViewController ()
@property (weak, nonatomic) IBOutlet UIButton *seting;


@property (weak, nonatomic) IBOutlet UIImageView *userImageView;


@property (weak, nonatomic) IBOutlet UILabel *nikcLabel;


@property (weak, nonatomic) IBOutlet UILabel *ofenWords;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selecData) name:@"zhang" object:nil];
 
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    
}






-(void)selecData{
    
    DateBaseUserManager *manager=[DateBaseUserManager sharedInstance];
    
    NSArray *arr=[manager selectAllLinkmans];
    
    LinkMan *link=arr[arr.count-1];
    
    [self.userImageView sd_setImageWithURL:[NSURL URLWithString:link.headImage] placeholderImage:nil];
    self.nikcLabel.text=link.name;
    if ([link.gender isEqualToString:@"m"]) {
        self.ofenWords.text=@"男";
    }else{
        self.ofenWords.text=@"女";
    }


}



//凑热闹
- (IBAction)hotTalk:(id)sender {
    
  

    
    
    
    
}
//贴子
- (IBAction)tiezi:(id)sender {
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
