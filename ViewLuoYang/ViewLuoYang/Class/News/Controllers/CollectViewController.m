//
//  CollectViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/19.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "CollectViewController.h"
#import "CollectTableViewCell.h"
#import "DataBaseManger.h"
#import "CollectResultViewController.h"
#import <MJRefresh/MJRefresh.h>
@interface CollectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _pageCount;
}
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) UIButton *button;//清除收藏按钮

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
    self.title = @"我的收藏";
    
    DataBaseManger *manager=[DataBaseManger shareInstance];
    [manager openDataBase];
    
    
    self.urlArray=[manager selectAllUrl];
    
    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.button];
    
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //添加数据
        [self.tableView.mj_header beginRefreshing];
        _pageCount = 1;
        self.isRefresh = YES;
        [self.urlArray removeAllObjects];
        self.urlArray = [manager selectAllUrl];
        [self.tableView.mj_header endRefreshing];
    }];
    
//    //上拉加载
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self.tableView.mj_footer beginRefreshing];
//        _pageCount+=1;
//        self.isRefresh=NO;
//        
//        [self.tableView.mj_footer endRefreshing];
//    }];
    
}


#pragma mark ------------ UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.urlArray.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIndentifiter = @"cellIndentifiter";
    CollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifiter];
    if (cell == nil) {
        cell = [[CollectTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentifiter];
        
//        cell.backgroundColor = [UIColor yellowColor];
        //赋值
        
        cell.detailTextLabel.text = self.urlArray[indexPath.row];
        
    
        
    }
    
    return cell;
}

#pragma mark ------------- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectResultViewController *collectResultVC = [[CollectResultViewController alloc] init];
    if (self.urlArray.count > 0) {
        collectResultVC.url = self.urlArray[indexPath.row];
    }
    
    [self.navigationController pushViewController:collectResultVC animated:YES];
    
}





#pragma mark --------------- lazt Loading
- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 125)];
        self.tableView.rowHeight = 120;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
    }
    return _tableView;
}


- (NSMutableArray *)urlArray{
    if (_urlArray == nil) {
        self.urlArray = [NSMutableArray new];
    }
    return _urlArray;
}

//- (UIButton *)button{
//    if (_button == nil) {
//        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.button.frame = CGRectMake(20, KScreenHeight-120, KScreenWidth-40, 44);
//        self.button.backgroundColor = barColor;
//        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.button setTitle:@"清空收藏" forState:UIControlStateNormal];
//        [self.button addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
//        self.button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
//        self.button.layer.cornerRadius = 7;
//        
//    }
//    return _button;
//}
//
//- (void)clearAction{
//    
//    
//}

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
