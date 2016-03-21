//
//  CollectViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/19.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "CollectViewController.h"
#import "CollectTableViewCell.h"
@interface CollectViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
    self.title = @"我的收藏";
    [self.view addSubview:self.tableView];
    
    
    
    
    
    
}


#pragma mark ------------ UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIndentifiter = @"cellIndentifiter";
    CollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifiter];
    if (cell == nil) {
        cell = [[CollectTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifiter];
        
        cell.backgroundColor = [UIColor cyanColor];
        
        
    }
    
    return cell;
}

#pragma mark ------------- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
}





#pragma mark --------------- lazt Loading
- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        self.tableView.rowHeight = 120;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
    }
    return _tableView;
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
