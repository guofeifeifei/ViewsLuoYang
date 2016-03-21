//
//  DiscussViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/19.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "DiscussViewController.h"
#import "ProgressHUD.h"
#import "TitleViewController.h"

@interface DiscussViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *discussView;
@property (nonatomic, strong) UIButton *sendBtn;//发送按钮
@end

@implementation DiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"评论";
    [self showBarButtonWithImage:@"back_arrow"];
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:233/255.0 blue:232/255.0 alpha:1.0];
    [self.view addSubview:self.discussView];
    

    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendBtn.frame = CGRectMake(0, 0, 60, 44);
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    //调整btn标题所在的位置，距离btn顶部，左边，底部，右边的距离
    [self.sendBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.sendBtn addTarget:self action:@selector(sendBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:self.sendBtn];
    rightBarBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarBtn;

}

#pragma mark ------------- lazy Loading
- (UITextView *)discussView{
    if (_discussView == nil) {
        self.discussView = [[UITextView alloc] initWithFrame:CGRectMake(20, KScreenWidth/10, KScreenWidth-40, KScreenWidth/2)];
        self.discussView.backgroundColor = [UIColor whiteColor];
        self.discussView.text = @"_说点什么吧";
        self.discussView.textColor = [UIColor lightGrayColor];
        self.discussView.font = [UIFont systemFontOfSize:15.0f];
    }
    return _discussView;
}


#pragma mark --------- 发送按钮的点击方法

- (void)sendBtnAction{
    if (self.discussView.text.length <= 0) {
        [ProgressHUD showError:@"评论内容不能为空呦"];
    }else{
        [ProgressHUD showSuccess:@"发送成功"];
    
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}





//点击空白处回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.discussView resignFirstResponder];
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
