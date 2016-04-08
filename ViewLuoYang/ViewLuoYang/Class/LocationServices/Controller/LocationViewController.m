//
//  LocationViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/16.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "LocationViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "NearViewController.h"
#import "UIView+YSTextInputKeyboard.h"

#import "WeatherViewController.h"

@interface LocationViewController ()<AMapSearchDelegate, MAMapViewDelegate, UISearchBarDelegate, AnnotationValeDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    CLLocation *_currentLocation;
    
    
    
}
@property(nonatomic, copy)  NSString *titles;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *pois;
@property(nonatomic, strong)UILongPressGestureRecognizer *longPressGesture;
@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) MAPointAnnotation *destinationPoint;//目的地图标
@property(nonatomic, strong) NSArray *array;
@property(nonatomic, strong) MAPointAnnotation *annotation;
@property(nonatomic, strong) MAPolylineView *polylineView;
@property(nonatomic, strong) NSArray *pathPolylines;
@property(nonatomic, strong) MAPolylineRenderer *polylineViewOver;
@property(nonatomic, strong) NSMutableArray *annotations;
@end

@implementation LocationViewController
- (void)initMapView{
    [MAMapServices sharedServices].apiKey = kLocationApk;
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    _mapView.delegate = self;
  self.titles = @"洛阳";

    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, 22);
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, 22);
        [self.view addSubview:_mapView];

    
}
- (void)initSearch{
    [AMapSearchServices sharedServices].apiKey = kLocationApk;
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.typeTitle;
    // Do any additional setup after loading the view.
    [self showBarButtonWithImage:@"back_arrow"];
    [self initMapView];
    [self initBtn];
       [_mapView addGestureRecognizer:self.longPressGesture];
    
   [self initSearch];
    [self.view addSubview:self.searchBar];
    
    [self reGeoAction];
    
}//实现输入提示的回调函数
- (void)initBtn{

    if (self.array.count > 0) {
        
    
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom ];
        btn.frame = CGRectMake(i * KScreenWidth / 4, KScreenHeight - KScreenHeight / 4, KScreenWidth / 4, 30);
        
        [btn setTitle:self.array[i] forState:UIControlStateNormal];

        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        btn.tag = i + 100;
        btn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [btn addTarget:self action:@selector(btnAcion:) forControlEvents:UIControlEventTouchUpInside];
        [_mapView addSubview:btn];
        
    }
    }
        
        
    }
-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response
{
    NSLog(@"request = %@", request);
    NSLog(@"response = %@", response);

    if(response.tips.count == 0)
    {
        return;
    }
    self.pois = response.tips;
    ZPFLog(@"self.pois  ******************    %@", self.pois);
    
   
        if (self.annotations != nil) {
            [_mapView removeAnnotations:self.annotations];
            self.annotations = nil;
        }
    
   
    for (NSInteger i = 0; i < self.pois.count; i++) {
      
    AMapTip *tip = self.pois[i];
   self.annotation = [[MAPointAnnotation alloc] init];
     self.annotation.coordinate = CLLocationCoordinate2DMake(tip.location.latitude, tip.location.longitude);
     self.annotation.title = tip.name;
   

       [self.annotations addObject:self.annotation];
       
    }
        [_mapView addAnnotations:self.annotations];

   
    
    
     NSLog(@"self.annotations = %@", self.annotations);
    
    
      }


//出现大头针

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if (annotation == _destinationPoint)
    {
        static NSString *reuseIndetifier = @"startAnnotationReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        annotationView.draggable = YES;
        annotationView.frame = CGRectMake(180, 200, 50, 50);
        return annotationView;
    }

    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"annotionReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.draggable = YES;
        annotationView.frame = CGRectMake(180, 200, 50, 50);
         annotationView.animatesDrop = YES;
        annotationView.canShowCallout = YES;
        return annotationView;
    }
        
    
    
    return nil;
  
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   
           

  
            ZPFLog(@"点击方法");
   
          //构造AMapInputTipsSearchRequest对象，设置请求参数
            AMapInputTipsSearchRequest *tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
            tipsRequest.keywords = self.searchBar.text;
            NSLog(@"00000000000000000%@", self.searchBar.text);
            tipsRequest.city = self.titles;
    NSLog(@"%@", self.titles);
            NSLog(@"%@", tipsRequest.city);
            //发起输入提示搜索
            [_search AMapInputTipsSearch: tipsRequest];
          
             [self.searchBar resignFirstResponder];
   
    
    
}

#pragma mark ------ 回收键盘



-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
   
   
         //取出当前位置的坐标
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
    NSLog(@"%@", _mapView.userLocation);
    
  
    
    
}

#pragma mark ------------ 路线规划
//手指协议
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)hanleLongPress:(UILongPressGestureRecognizer *)gesture{
//    if (_destinationPoint != nil) {
//        [_mapView removeAnnotation:_destinationPoint];
//        _destinationPoint = nil;
//    }
    // [_mapView removeOverlays:_pathPolylines];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        CLLocationCoordinate2D coordinate = [_mapView convertPoint:[gesture locationInView:_mapView] toCoordinateFromView:_mapView];
        if (_destinationPoint != nil || _annotation != nil) {
            [_mapView removeAnnotation:_destinationPoint];
            [_mapView removeAnnotation:_annotation];
            _destinationPoint = nil;
            _annotation = nil;
        }
        _destinationPoint = [[MAPointAnnotation alloc] init];
        _destinationPoint.coordinate = coordinate;
        _destinationPoint.title = @"终点";
        [_mapView addAnnotation:_destinationPoint];
        
    }
    
    
}


- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response{
    
    if (response.route == nil) {
        return;
    }
    
    [_mapView removeOverlays:_pathPolylines];
    _pathPolylines = nil;
    _pathPolylines = [self polylinesForPath:response.route.paths[0]];
    if(_destinationPoint == nil){
   
          [_mapView showAnnotations:@[_annotation, _mapView.userLocation] animated:YES];
        
    }else{
         [_mapView showAnnotations:@[_destinationPoint, _mapView.userLocation] animated:YES];
    }
    [_mapView addOverlays:_pathPolylines];
    
}
- (NSArray *)polylinesForPath:(AMapPath *)path
{
    if (path == nil || path.steps.count == 0)
    {
        return nil;
    }
    
  NSMutableArray *polylines = [NSMutableArray new];
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        
        NSUInteger count = 0;
        CLLocationCoordinate2D *coordinates = [self coordinatesForString:step.polyline
                                                         coordinateCount:&count
                                                              parseToken:@";"];
        
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
        [polylines addObject:polyline];
        
        free(coordinates), coordinates = NULL;
       
    }];
    
    return polylines;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay{
    if ([overlay isKindOfClass:[MAPolyline class]]) {
      
        self.polylineViewOver = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        self.polylineViewOver.lineWidth = 10;
        self.polylineViewOver.strokeColor = barColor;
       
        return self.polylineViewOver;
    }
    return nil;
}

#pragma mark --------- 字符串解析

- (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token
{
    if (string == nil)
    {
        return NULL;
    }
    
    if (token == nil)
    {
        token = @",";
    }
    
    NSString *str = @"";
    if (![token isEqualToString:@","])
    {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    
    else
    {
        str = [NSString stringWithString:string];
    }
    
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL)
    {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++)
    {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    return coordinates;
}

#pragma mark -------- 懒加载
- (NSArray *)pathPolylines{
    if (_pathPolylines == nil) {
        _pathPolylines = [NSArray new];
    }
    return _pathPolylines;
    
}
- (UILongPressGestureRecognizer *)longPressGesture{
    if (_longPressGesture == nil) {
        NSLog(@"长按手势");
        self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(hanleLongPress:)];
        self.longPressGesture.delegate = self;
        self.longPressGesture.minimumPressDuration = 1;
        self.longPressGesture.numberOfTouchesRequired = 1;
      
      //  _mapView.userInteractionEnabled = YES;
    }
    return _longPressGesture;
    
    
}
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
        case 1:{
            if (_destinationPoint != nil) {
                [_mapView removeAnnotation:_destinationPoint];
                _destinationPoint = nil;
            }
           
            
             [_mapView removeOverlays:_pathPolylines];
            ZPFLog(@"附近");
            NearViewController *nearVC = [[NearViewController alloc] init];
            nearVC.currentLocation = _currentLocation;
            nearVC.delegate = self;
            [self.navigationController pushViewController:nearVC animated:YES];
        }
            break;
        case 2:{
            ZPFLog(@"路线");
            if ( _currentLocation == nil||_search == nil) {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"长按屏幕选择目的地" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                return;
            }
            AMapWalkingRouteSearchRequest  *request = [[AMapWalkingRouteSearchRequest alloc] init];
            request.origin = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
//            request.destination = [AMapGeoPoint locationWithLatitude:_destinationPoint.coordinate.latitude longitude:_destinationPoint.coordinate.longitude];
            
            if(_destinationPoint == 0){
                
                request.destination = [AMapGeoPoint locationWithLatitude:_annotation.coordinate.latitude longitude:_annotation.coordinate.longitude];
                
                
                
            }else{
                
        request.destination = [AMapGeoPoint locationWithLatitude:_destinationPoint.coordinate.latitude longitude:_destinationPoint.coordinate.longitude];

            }
            
            
            [_search AMapWalkingRouteSearch:request];
        

            break;
        }
        case 0:{
            ZPFLog(@"定位");
             _mapView.showsUserLocation = YES;
                [_mapView setZoomLevel:kDefaultLocationZoomLevel animated:YES];
            
            
            
            break;
        }
        case 3:{
            ZPFLog(@"天气");
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"WeatherStoryboard" bundle:nil];
            WeatherViewController *weatherVC = [storyboard instantiateViewControllerWithIdentifier:@"weatherId"];
            weatherVC.currentLocation = _currentLocation;
            NSLog(@"%@", weatherVC.currentLocation);
            [self.navigationController pushViewController:weatherVC animated:YES];
            
        
            break;
        }
        default:
            break;
    }
    
    
    
}


#pragma mark ----delegate 
- (void)AMapPOIValeDelegate:(AMapPOI *)poi{
    if (self.annotation != nil) {
        [_mapView removeAnnotation:self.annotation];
        self.annotation = nil;
    }
    if (self.annotations != nil) {
        [_mapView removeAnnotations:self.annotations];
        self.annotations = nil;
    }
   // self.annotation = [[MAPointAnnotation alloc] init];
    self.annotation.coordinate = CLLocationCoordinate2DMake(poi.location.latitude, poi.location.longitude);
    self.annotation.title = poi.name;
    self.annotation.subtitle = poi.address;
    [_mapView addAnnotation:self.annotation];
    
    
    
    
}
- (MAPointAnnotation *)annotation{
    if (_annotation == nil) {
        self.annotation = [[MAPointAnnotation alloc] init];
    }
    return _annotation;
}
- (NSArray *)array{
    if (_array == nil) {
        self.array = @[@"定位", @"附近", @"路线", @"天气"];
    }
    return _array;
    
}
- (NSArray *)pois{
    if (_pois == nil) {
        self.pois = [NSArray new];
    }
    return _pois;
    
    
}


- (NSMutableArray *)annotations{
    if (_annotations == nil) {
        self.annotations = [NSMutableArray array];
    }
    return _annotations;
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.tabBarController.tabBar.hidden = YES;
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
