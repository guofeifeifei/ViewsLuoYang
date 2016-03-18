//
//  NearViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/17.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "NearViewController.h"

@interface NearViewController ()<UITableViewDelegate, UITableViewDataSource, AMapSearchDelegate, MAMapViewDelegate, AMapLocationManagerDelegate>{
        AMapSearchAPI *_search;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *nameArray;

@end

@implementation NearViewController
- (void)initSearch{
    [AMapSearchServices sharedServices].apiKey = kLocationApk;
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self headView];
    [self initSearch];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellInder = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInder];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellInder];
    }
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
       
    }
    return _tableView;
    
    
}
- (void)headView{
     UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth/ 2)];
    NSArray *imageArray = @[@"beauty", @"cinema", @"group", @"bath", @"bar", @"bank", @"dinner", @"hotel"];
    self.nameArray = @[@"丽人", @"电影", @"团购", @"洗浴", @"网吧", @"银行", @"美食", @"酒店"];
    
    for (NSInteger i = 0; i < 8; i++) {
          UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect ];
        if (i >= 4) {
            i -= 4;
            btn.frame = CGRectMake(i * KScreenWidth / 4, KScreenWidth / 4, KScreenWidth / 4, KScreenWidth / 4);
             i += 4;
        }else{
            btn.frame = CGRectMake(i * KScreenWidth / 4, 0, KScreenWidth / 4, KScreenWidth / 4);
           
        }
      
       
        [btn setTitle:self.nameArray[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(KScreenWidth / 10, 0, -KScreenWidth / 10, 0)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        
       
        btn.tag = i + 100;
        [btn addTarget:self action:@selector(btnAcion:) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:btn];
    }
    
    self.tableView.tableHeaderView = headView;
    
}
- (void)btnAcion:(UIButton *)btn{
    NSString *stringkey = self.nameArray[btn.tag - 100];
    NSLog(@"%@", stringkey);
    if (_currentLocation == nil || _search == nil ) {
        ZPFLog(@"search failed");
        return;
    }
    
    
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
