//
//  LocationViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/16.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "LocationViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface LocationViewController ()<AMapSearchDelegate>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
}
@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UISegmentedControl *segment;
@property(nonatomic, strong) NSArray *array;
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
   
    [AMapSearchServices sharedServices].apiKey = kLocationApk;
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    //构造AMapInputTipsSearchRequest对象，设置请求参数
    AMapInputTipsSearchRequest *tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
    tipsRequest.keywords = @"肯德基";
    tipsRequest.city = @"北京";
    
    //发起输入提示搜索
    [_search AMapInputTipsSearch: tipsRequest];
    
    
}//实现输入提示的回调函数
-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response
{
    if(response.tips.count == 0)
    {
        return;
    }
    
    //通过AMapInputTipsSearchResponse对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %ld", response.count];
    NSString *strtips = @"";
    for (AMapTip *p in response.tips) {
        strtips = [NSString stringWithFormat:@"%@\nTip: %@", strtips, p.description];
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strtips];
    NSLog(@"InputTips: %@", result);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [MAMapServices sharedServices].apiKey = kLocationApk;
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    _mapView.showsUserLocation = YES;//随着用户移动而移动
    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    _mapView.pausesLocationUpdatesAutomatically = NO;//即便你的app退到后台，且位置不变动时，也不会被系统挂起，可持久记录位置信息。该功能适用于记轨迹录或者出行类App司机端。
  //显示卫星地图
   // _mapView.mapType = MAMapTypeSatellite;
   // _mapView.showTraffic = YES;//实时交通图
    
    
    
    [self.view addSubview:_mapView];
    [self.view addSubview:self.segment];
    [self.view addSubview:self.searchBar];
}

- (UISearchBar *)searchBar{

    if (_searchBar == nil) {
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(KScreenWidth/15, KScreenHeight / 15, KScreenWidth - 2*(KScreenWidth / 12), 44)];
        [self.searchBar setPlaceholder:@"搜索"];
        [self.searchBar setShowsCancelButton:YES];
       
        [self.searchBar setTintColor:[UIColor whiteColor]];
       
       
      
        
    }
    return _searchBar;
}
- (UISegmentedControl *)segment{
    if (_segment == nil) {
        self.segment = [[UISegmentedControl alloc] initWithItems:self.array];
        self.segment.frame = CGRectMake(KScreenWidth/15, KScreenWidth + KScreenWidth / 3, KScreenWidth - 2 * (KScreenWidth / 12), 44);
        self.segment.tintColor = barColor;
         
    }
    return _segment;
    
}
- (NSArray *)array{
    if (_array == nil) {
        self.array = @[@"附近", @"路线", @"导航", @"天气"];
    }
    return _array;
    
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
