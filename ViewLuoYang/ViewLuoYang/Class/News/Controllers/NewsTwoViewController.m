//
//  NewsTwoViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "NewsTwoViewController.h"
#import "NewsSecondModel.h"
#import "NewsScondCollectionViewCell.h"
static NSString *itemIntentfier = @"itemIdentifier";
@interface NewsTwoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, copy) NSString *pageId;//图片Id
@property (nonatomic, copy) NSString *layoutImageBig;//图片


@end

@implementation NewsTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
    
}


//解析数据
- (void)dataLoad{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *b=[NSString stringWithFormat:@"%@%@?_fs=2&_vc=58",ktouch,@(86)];
    
    ZPFLog(@"%@",b);
    
    [sessionManager GET:b parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"responseObject = %@",responseObject);
        
        NSDictionary *dic = responseObject;
        NSDictionary *dataDic = dic[@"data"];
        self.pageId = dataDic[@"pageId"];
        
        NSDictionary *layoutInfoDic = dataDic[@"layoutInfo"];
        self.layoutImageBig = layoutInfoDic[@"layoutImageBig"];
       
        [self.collectionView reloadData];
        
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZPFLog(@"error = %@",error);
    }];
}


#pragma mark ---------- UICollectionViewDataSource
//返回的是Item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

//返回一个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NewsScondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:self.layoutImageBig] placeholderImage:nil];
    
    return cell;
}
#pragma mark ---------- 点击item实现的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor lightGrayColor];
        //设置代理
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        //注册item类型
        [self.collectionView registerClass:[NewsScondCollectionViewCell class] forCellWithReuseIdentifier:@"itemIdentifier"];
        
    }
    return _collectionView;
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
