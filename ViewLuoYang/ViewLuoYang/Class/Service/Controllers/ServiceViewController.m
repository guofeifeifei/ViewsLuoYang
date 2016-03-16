//
//  ServiceViewController.m
//  AllViewOfLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "ServiceViewController.h"
#import "ZMYNetManager.h"
#import "serviceModel.h"
#import <MJRefresh.h>
#import "ServicedidViewController.h"
#import "ServiceCollectionViewCell.h"
#import <AFNetworking/AFHTTPSessionManager.h>
@interface ServiceViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>{
    BOOL _refresh;
}
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *serviceArray;
@end

@implementation ServiceViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"服务";
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - KScreenWidth - 100)];
    headImageView.image = [UIImage imageNamed:@"bm_bg"];
   [self.view addSubview:headImageView];
    [self loadData];
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        _refresh = YES;
    } ];
    
}
- (void)loadData{
    if (![ZMYNetManager shareZMYNetManager].isZMYNetWorkRunning) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的网络有问题，请检查网络" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *quxiao = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [alert addAction:quxiao];
        [self presentViewController:alert animated:YES completion:nil];

    }else{
        
        AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        [sessionManager GET:kService parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            NSLog(@"%@", downloadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"%@", responseObject);
            NSDictionary *dic = responseObject;
            NSDictionary *appListDic = dic[@"appList"];
            NSArray *keyArray = appListDic.allKeys;

            
            NSArray *stortArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return [obj1 compare:obj2 options:NSNumericSearch];
            }];
            
            NSMutableArray *array = [stortArray mutableCopy];
            [array removeLastObject];
            if (_refresh) {
                if (self.serviceArray.count > 0) {
                    [self.serviceArray removeAllObjects];
                }
            }
            for (NSString *key in array) {
                NSDictionary *dict =  appListDic[key];
                serviceModel *model = [[serviceModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.serviceArray addObject:model];
            }
//            for (int i = 0; i < keyArray.count; i++) {
//                NSDictionary *dic = appListDic[keyArray[i]];
//                serviceModel *model = [[serviceModel alloc] init];
//                [model setValuesForKeysWithDictionary:dic];
//                [self.serviceArray addObject:model];
//            }
            
            [self.collectionView reloadData];
           
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
        }];
        
        
    }

}



#pragma mark -------------UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    ServiceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"itemIdentifier" forIndexPath:indexPath];
        if (self.serviceArray.count > 0) {
        cell.model = self.serviceArray[indexPath.row];
//            if (indexPath.row == self.serviceArray.count) {
//                cell.serviceImage.image = [UIImage imageNamed:@"map"];
//                cell.serviceLable.text = @"地图";
            //}
    }
   
    return cell;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.serviceArray.count ;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    serviceModel *model = [[serviceModel alloc] init];
    model = self.serviceArray[indexPath.row];
    ServicedidViewController *servicedidVC = [[ServicedidViewController alloc] init];
    servicedidVC.path = model.app_path;
    [self.navigationController pushViewController:servicedidVC animated:YES];
}


#pragma mark -------------UICollectionViewDelegate
#pragma mark -------------懒加载
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(KScreenWidth / 5, KScreenWidth / 5);
        //行间距
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, KScreenHeight - KScreenWidth - 100, KScreenWidth, KScreenWidth) collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[ServiceCollectionViewCell class] forCellWithReuseIdentifier:@"itemIdentifier"];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        
        
    }
    return _collectionView;
    
    
}
- (NSMutableArray *)serviceArray{
    if (_serviceArray == nil) {
        self.serviceArray = [NSMutableArray new];
    }
    return _serviceArray;
    
    
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
