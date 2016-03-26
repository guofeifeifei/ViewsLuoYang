//
//  NewsViewController.m
//  AllViewOfLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCollectionViewCell.h"
#import "NewsModel.h"
#import <MJRefresh/MJRefresh.h>
#import "NewsTwoViewController.h"
#import "ZMYNetManager.h"
static NSString *itemIntentfier = @"itemIdentifier";
@interface NewsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSInteger _pageCount;
    
}

@property(nonatomic, assign) BOOL isRefresh;
@property (nonatomic, retain) UICollectionView *collectionView;
@property(nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) UIButton *firstBtn;
@property (nonatomic, strong) UIButton *secondBtn;
@property (nonatomic, strong) UIButton *thirdBtn;
@property (nonatomic, strong) NSMutableArray *allNewsArray;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showMeButton];
    // Do any additional setup after loading the view.
    [self showBarButtonWithcode];
    self.navigationController.navigationBar.translucent = NO;
    //去掉navigation下一条黑色的线条
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
   //设置文字
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor] , NSFontAttributeName:[UIFont systemFontOfSize:18.0f]}];
    self.title = @"电子报";
    //默认是晚报
    _pageCount=1;
    self.urlString = knightNews;
    
    ZPFLog(@"%@",self.urlString);
    [self dataLoad];
    [self.view addSubview:self.firstBtn];
    [self.view addSubview:self.secondBtn];
    [self.view addSubview:self.thirdBtn];

    
    //下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //增加数据
        [self.collectionView.mj_header beginRefreshing];
        //网络请求
        _pageCount=1;
        self.isRefresh=YES;
        [self dataLoad];
        
    }];
    
    //上拉加载
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.collectionView.mj_footer beginRefreshing];
        //请求网络
        
        _pageCount+=1;
        self.isRefresh=NO;
        [self dataLoad];

    }];
    
}

//当页面将要出现的时候隐藏tabBar
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark ------------ lazyLoading
- (UIButton *)firstBtn{
    if (_firstBtn == nil) {
        self.firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.firstBtn.frame = CGRectMake(0, 0, KScreenWidth/3, 44);
        [self.firstBtn setTitle:@"洛阳晚报" forState:UIControlStateNormal];
        [self.firstBtn addTarget:self action:@selector(threeBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.firstBtn.tag = 1;
        [self.secondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.firstBtn.backgroundColor = barColor;
    }
    return _firstBtn;
}
- (UIButton *)secondBtn{
    if (_secondBtn == nil) {
        self.secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.secondBtn.frame = CGRectMake(KScreenWidth/3, 0, KScreenWidth/3, 44);
        [self.secondBtn setTitle:@"洛阳日报" forState:UIControlStateNormal];
        [self.secondBtn addTarget:self action:@selector(threeBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.secondBtn.tag = 2;
        self.secondBtn.backgroundColor = barColor;
        [self.secondBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _secondBtn;
}
- (UIButton *)thirdBtn{
    if (_thirdBtn == nil) {
        self.thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.thirdBtn.frame = CGRectMake(KScreenWidth/3*2, 0, KScreenWidth/3, 44);
        [self.thirdBtn setTitle:@"洛阳商报" forState:UIControlStateNormal];
        [self.thirdBtn addTarget:self action:@selector(threeBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.thirdBtn.tag = 3;
        self.thirdBtn.backgroundColor = barColor;
        [self.thirdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _thirdBtn;
}
#pragma mark ---------- 三个按钮的点击方法
- (void)threeBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 1:
        {
            [self.allNewsArray removeAllObjects];
            self.urlString=knightNews;
            
            [self dataLoad];
        }
            break;
        case 2:
        {
            [self.allNewsArray removeAllObjects];
            self.urlString=KdayNew;
            [self dataLoad];
        }
            break;
        case 3:
        {
            [self.allNewsArray removeAllObjects];
            self.urlString=KbusinessNews;
            [self dataLoad];

        }
            break;
            
        default:
            break;
    }
}
//解析数据
- (void)dataLoad{
    
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的网络有问题，请检查网络" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            ZPFLog(@"确定");
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            ZPFLog(@"取消");
        }];
        //
        [alert addAction:action];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    
    
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:[NSString stringWithFormat:@"%@%@/12?_fs=2&_vc=58",self.urlString,@(_pageCount)] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"responseObject = %@",responseObject);
        NSDictionary *dic = responseObject;
        if (self.isRefresh) {
            if (self.allNewsArray.count>0) {
                [self.allNewsArray removeAllObjects];
            }
        }
        NSDictionary *dataDic = dic[@"data"];
        NSArray *periodlistArray = dataDic[@"periodlist"];
        for (NSDictionary *dict in periodlistArray) {
            NewsModel *newModel = [[NewsModel alloc] init];
            [newModel setValuesForKeysWithDictionary:dict];
            [self.allNewsArray addObject:newModel];
        }
        [self.view addSubview:self.collectionView];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZPFLog(@"error = %@",error);
    }];
}
#pragma mark ---------- UICollectionViewDataSource
//返回的是Item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allNewsArray.count;
}
//返回1个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemIdentifier" forIndexPath:indexPath];
    
    if (self.allNewsArray.count > 0) {
        NewsModel *model = self.allNewsArray[indexPath.row];
        
        
        //当是第一个item的时候，出现"最新"
        if (indexPath.row == 0) {
            cell.titleLable.text = @"最新";
        }else{
            cell.titleLable.text=model.periodName;
        }
        
        [cell.image sd_setImageWithURL:[NSURL URLWithString:model.periodImage] placeholderImage:nil];
    }
    
    return cell;
}
#pragma mark -------- 点击选择哪个图片
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsTwoViewController *newsTwoVC = [[NewsTwoViewController alloc] init];
    
    NewsModel *model = self.allNewsArray[indexPath.row];
    
    newsTwoVC.image = model.periodImage;
    newsTwoVC.periodId = model.periodId;
    newsTwoVC.paperId = model.paperId;
    newsTwoVC.periodDate = model.periodDate;
    newsTwoVC.lastLayout = model.lastLayout;
    
    [self.navigationController pushViewController:newsTwoVC animated:YES];
}
#pragma mark ----------- lazy loading
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        //创建一个layout布局类
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向（默认垂直方向）
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每一行间距
        layout.minimumLineSpacing = 10;
        //设置item间距
        layout.minimumInteritemSpacing = 1;
        //section的间距 上，左，下，右
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 20, 15);
        //设置每个item的大小
        layout.itemSize = CGSizeMake(KScreenWidth/3-20,KScreenHeight/4);
        //通过一个layout布局来创建一个collectionView
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 70, KScreenWidth, KScreenHeight) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor lightGrayColor];
        //设置代理
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        //注册item类型
        [self.collectionView registerClass:[NewsCollectionViewCell class] forCellWithReuseIdentifier:@"itemIdentifier"];
        self.collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}



- (NSMutableArray *)allNewsArray{
    if (_allNewsArray == nil) {
        self.allNewsArray = [NSMutableArray new];
    }
    return _allNewsArray;
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
