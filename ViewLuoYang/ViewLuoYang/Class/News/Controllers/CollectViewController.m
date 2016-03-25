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
    self.tabBarController.tabBar.hidden = YES;
    
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
    

    [self.view addSubview:self.tableView];
    
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
    
        Collect *collect = self.urlArray[indexPath.row];
        
        cell.detailTextLabel.text = collect.url;
        cell.detailTextLabel.textColor = barColor;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0f];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:collect.image] placeholderImage:nil];
        
    }
    return cell;
}

#pragma mark ------------- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectResultViewController *collectResultVC = [[CollectResultViewController alloc] init];
    if (self.urlArray.count > 0) {
        Collect *collect = self.urlArray[indexPath.row];
        collectResultVC.url = collect.url;
    }
    
    [self.navigationController pushViewController:collectResultVC animated:YES];
    
}



#pragma mark --------------- lazt Loading
- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - 64)];

        self.tableView.rowHeight = 140;
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
