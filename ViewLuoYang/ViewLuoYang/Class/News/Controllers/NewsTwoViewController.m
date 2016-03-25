//
//  NewsTwoViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "NewsTwoViewController.h"
#import "NewsScondCollectionViewCell.h"
#import "TitleViewController.h"
static NSString *itemIntentfier = @"itemIdentifier";
@interface NewsTwoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) UICollectionView *collectionView;

@property (nonatomic, copy) NSString *nsid;
@property (nonatomic, copy) NSString *all;//拼接生成一个字符串
@end
@implementation NewsTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self showBarButtonWithImage:@"back_arrow"];
    
    
}

- (void)loadData{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSLog(@"%@",self.periodDate);//2016-03-16
    
    NSString *a = self.periodDate;
    //去年份
    NSString *b = [a substringToIndex:4];
    //取日期
    NSString *c = [a substringFromIndex:8];
    //取月份
    NSString *d = [a substringToIndex:7];
    ZPFLog(@"%@",d);
    NSString *e = [d substringFromIndex:5];
    ZPFLog(@"%@",e);
    //拼加成一个字符串
    self.all = [NSString stringWithFormat:@"%@%@%@",b,e,c];
    ZPFLog(@"%@",self.all);
    
    [sessionManager GET:[NSString stringWithFormat:@"%@%@/%@/%@?_fs=2&_vc=58",ktouch,self.paperId,self.all,self.lastLayout] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"responseObject = %@",responseObject);
        
        
//      解析数据拿到属性nsid，传到下一个页面。
        NSDictionary *dic = responseObject;
        NSDictionary *dataDic = dic[@"data"];
        NSArray *areamaplistArray = dataDic[@"areamaplist"];
        if (areamaplistArray.count >= 1) {
            NSDictionary *dict = areamaplistArray[0];
            self.nsid = dict[@"nsid"];
        }
 
        [self.view addSubview:self.collectionView];
        [self.collectionView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZPFLog(@"error = %@",error);
    }];
}

#pragma mark ---------- UICollectionViewDataSource
//返回的是Item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

//返回一个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NewsScondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemIdentifier" forIndexPath:indexPath];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:self.image] placeholderImage:nil];
    return cell;
}
#pragma mark ---------- 点击item实现的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TitleViewController *titleVC = [[TitleViewController alloc] init];
    //往第三页面传值
    titleVC.periodId = self.periodId;
    titleVC.paperId = self.paperId;
    titleVC.nsid = self.nsid;
    titleVC.image = self.image;
    [self.navigationController pushViewController:titleVC animated:YES];
}
#pragma mark ---------- lazy Loading
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        //创建一个layout布局类
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向（默认垂直方向）（现在是水平方向）
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置每一行间距
        layout.minimumLineSpacing = 5;
        //设置item间距
        layout.minimumInteritemSpacing = 1;
        //section的间距 上，左，下，右
        layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
        //设置每个item的大小
        layout.itemSize = CGSizeMake(KScreenWidth,KScreenHeight);
        //通过一个layout布局来创建一个collectionView
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-64) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor lightGrayColor];
        //设置代理
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        //注册item类型
        [self.collectionView registerClass:[NewsScondCollectionViewCell class] forCellWithReuseIdentifier:@"itemIdentifier"];
        
    }
    return _collectionView;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
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
