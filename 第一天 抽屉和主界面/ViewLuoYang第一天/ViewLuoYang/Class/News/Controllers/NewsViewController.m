//
//  NewsViewController.m
//  AllViewOfLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "NewsViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
static NSString *itemIntentfier = @"itemIdentifier";
@interface NewsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *firstBtn;
@property (nonatomic, strong) UIButton *secondBtn;
@property (nonatomic, strong) UIButton *thirdBtn;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.firstBtn];
    [self.view addSubview:self.secondBtn];
    [self.view addSubview:self.thirdBtn];
}


#pragma mark ------------ lazyLoading
- (UIButton *)firstBtn{
    if (_firstBtn == nil) {
        self.firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.firstBtn.frame = CGRectMake(0, 64, KScreenWidth/3, 44);
        [self.firstBtn setTitle:@"洛阳晚报" forState:UIControlStateNormal];
        [self.firstBtn addTarget:self action:@selector(threeBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.firstBtn.tag = 1;
        self.firstBtn.backgroundColor = [UIColor whiteColor];
        [self.firstBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _firstBtn;
}
- (UIButton *)secondBtn{
    if (_secondBtn == nil) {
        self.secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.secondBtn.frame = CGRectMake(KScreenWidth/3, 64, KScreenWidth/3, 44);
        [self.secondBtn setTitle:@"洛阳晚报" forState:UIControlStateNormal];
        [self.secondBtn addTarget:self action:@selector(threeBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.secondBtn.tag = 2;
        self.secondBtn.backgroundColor = [UIColor whiteColor];
        [self.secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _secondBtn;
}
- (UIButton *)thirdBtn{
    if (_thirdBtn == nil) {
        self.thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.thirdBtn.frame = CGRectMake(KScreenWidth/3*2, 64, KScreenWidth/3, 44);
        [self.thirdBtn setTitle:@"洛阳晚报" forState:UIControlStateNormal];
        [self.thirdBtn addTarget:self action:@selector(threeBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.thirdBtn.tag = 3;
        self.thirdBtn.backgroundColor = [UIColor whiteColor];
        [self.thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _thirdBtn;
}
#pragma mark ---------- 三个按钮的点击方法
- (void)threeBtn:(UIButton *)btn{
    switch (btn.tag) {
        case 1:
        {
            [self dataLoad];
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
}
//解析数据
- (void)dataLoad{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:[NSString stringWithFormat:@"%@",kNews] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZPFLog(@"downloadProgress = %@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZPFLog(@"responseObject = %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZPFLog(@"error = %@",error);
    }];
}
#pragma mark ---------- UICollectionViewDataSource
//返回的是Item的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}
//返回1个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    return cell;
    
}
#pragma mark -------- 点击选择哪个图片
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma mark ----------- lazy loading
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        //创建一个layout布局类
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向（默认垂直方向）
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每一行间距
        layout.minimumLineSpacing = 5;
        //设置item间距
        layout.minimumInteritemSpacing = 1;
        //section的间距 上，左，下，右
        layout.sectionInset = UIEdgeInsetsMake(2, 10, 2, 10);
        //设置每个item的大小
        layout.itemSize = CGSizeMake(KScreenWidth/3-20,KScreenHeight/4);
        //通过一个layout布局来创建一个collectionView
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, KScreenWidth, KScreenHeight) collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor lightGrayColor];
        //设置代理
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        //注册item类型
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"itemIdentifier"];
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
