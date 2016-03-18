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
#import "NearViewController.h"
@interface LocationViewController ()<AMapSearchDelegate, MAMapViewDelegate, UISearchBarDelegate>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    CLLocation *_currentLocation;
    
    
}
@property(nonatomic, copy)  NSString *titles;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *pois;
@property(nonatomic, strong) NSMutableArray *anotations;
@property(nonatomic, strong) UISearchBar *searchBar;

@property(nonatomic, strong) NSArray *array;


@property(nonatomic, strong) NSMutableArray *annotations;
@end

@implementation LocationViewController
- (void)initMapView{
    [MAMapServices sharedServices].apiKey = kLocationApk;
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22);
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22);
        [self.view addSubview:_mapView];
    
    
}
- (void)initSearch{
    [AMapSearchServices sharedServices].apiKey = kLocationApk;
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    //构造AMapInputTipsSearchRequest对象，设置请求参数
    AMapInputTipsSearchRequest *tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
    tipsRequest.keywords = @"肯德基";
    tipsRequest.city = self.titles;
    
    //发起输入提示搜索
    [_search AMapInputTipsSearch: tipsRequest];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.typeTitle;
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
    [self initMapView];
    [self initSearch];
    [self initBtn];
    
    
    
    
    [self.view addSubview:self.searchBar];
    
    
    
}//实现输入提示的回调函数
- (void)initBtn{
    
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect ];
        btn.frame = CGRectMake(i * KScreenWidth / 4, KScreenHeight - KScreenHeight / 4, KScreenWidth / 4, 30);
        
        [btn setTitle:self.array[i] forState:UIControlStateNormal];
       
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        btn.tag = i + 100;
        [btn addTarget:self action:@selector(btnAcion:) forControlEvents:UIControlEventTouchUpInside];
        [_mapView addSubview:btn];
        
    }
    
        
        
    }
-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response
{
    if(response.tips.count == 0)
    {
        return;
    }
    self.pois = response.tips;
    ZPFLog(@"self.pois  ******************    %@", self.pois);
    [_mapView removeAnnotations:_annotations];
    [_annotations removeAllObjects];
//    //通过AMapInputTipsSearchResponse对象处理搜索结果
//    NSString *strCount = [NSString stringWithFormat:@"count: %ld", response.count];
//    NSString *strtips = @"";
//    for (AMapTip *p in response.tips) {
//        strtips = [NSString stringWithFormat:@"%@\nTip: %@", strtips, p.description];
//    }
//    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strtips];
//    NSLog(@"InputTips: %@", result);
}
//出现大头针
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
//        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
//        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
//        if (annotationView == nil) {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
//        }
//        annotationView.canShowCallout = YES;
//       
//        
//        
//        return annotationView;
//        
//        
//        
//        
//        
//    }
//    return nil;
//    
//    
//    
//}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    ZPFLog(@"点击方法");
//    for (NSUInteger *i; i < [self.pois count ]; i++) {
//        AMapPOI *poi = _pois[i];
//        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
//        annotation.coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
//    }
   
    
    
    
}
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
           //取出当前位置的坐标
    NSLog(@"userLocation:%@", userLocation.location)
  
    _currentLocation = [userLocation.location copy];
}
//地理编码
- (void)reGeoAction{
    if (_currentLocation) {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        [_search AMapReGoecodeSearch:request];
    }
    
    
}


//解析地理编码
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    ZPFLog(@"response:%@", response);
    //城市地址
    self.titles = response.regeocode.addressComponent.city;
    if (self.titles.length == 0) {
        //详细地址
        self.titles = response.regeocode.addressComponent.province;
    }
    
    _mapView.userLocation.title = self.titles;
    _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
    
    
}
//选中地点
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        [self reGeoAction];
    }
    
}
#pragma mark -------- 懒加载
- (UISearchBar *)searchBar{

    if (_searchBar == nil) {
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(KScreenWidth/15, KScreenHeight / 15, KScreenWidth - 2*(KScreenWidth / 12), 44)];
        [self.searchBar setPlaceholder:@"搜索"];
     
        self.searchBar.delegate = self;
       
        [self.searchBar setTintColor:[UIColor whiteColor]];

    }
    return _searchBar;
}

- (void)btnAcion:(UIButton *)btn{
   
    switch (btn.tag - 100) {
        case 0:{
            
            
            
            
            ZPFLog(@"附近");
            NearViewController *nearVC = [[NearViewController alloc] init];
            nearVC.currentLocation = _currentLocation;
            [self.navigationController pushViewController:nearVC animated:YES];
        }
            break;
        case 1:
            ZPFLog(@"路线");
            break;
        case 2:
            ZPFLog(@"导航");
            break;
        case 3:
            ZPFLog(@"天气");
            break;

        default:
            break;
    }
    
    
    
}
- (NSArray *)array{
    if (_array == nil) {
        self.array = @[@"附近", @"路线", @"导航", @"天气"];
    }
    return _array;
    
}
- (NSArray *)pois{
    if (_pois == nil) {
        self.pois = [NSArray new];
    }
    return _pois;
    
    
}
- (NSMutableArray *)anotations{
    if (_anotations == nil) {
        self.anotations = [NSMutableArray new];
    }
    return _anotations;
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
}
- (NSMutableArray *)annotations{
    if (_annotations == nil) {
        self.annotations = [NSMutableArray new];
    }
    return _annotations;
    
    
    
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
