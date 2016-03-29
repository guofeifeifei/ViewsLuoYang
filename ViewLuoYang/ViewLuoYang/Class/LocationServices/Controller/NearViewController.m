//
//  NearViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/17.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "NearViewController.h"

@interface NearViewController ()<UITableViewDelegate, UITableViewDataSource, AMapSearchDelegate, MAMapViewDelegate>{
        AMapSearchAPI *_search;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *pois;
@property(nonatomic, strong) NSArray *nameArray;
@property(nonatomic, strong) NSMutableArray *annotations;
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
    [self showBarButtonWithImage:@"back_arrow"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellInder = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellInder];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellInder];
    }
      AMapPOI *poi = self.pois[indexPath.row];
    NSLog(@"%@", poi);
    cell.textLabel.text = poi.name;
    cell.detailTextLabel.text = poi.name;
    cell.backgroundColor = barColor;
    cell.backgroundColor = [UIColor cyanColor];
    return cell;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.pois.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       AMapPOI *poi = _pois[indexPath.row];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(AMapPOIValeDelegate:)]) {
        [self.delegate AMapPOIValeDelegate:poi];
    }
    
    [self.navigationController popViewControllerAnimated:YES];

    
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.rowHeight = 80;
        self.tableView.separatorColor = [UIColor clearColor];
    }
  
    return _tableView;
    
    
}
- (void)headView{
     UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth/ 2)];
    NSArray *imageArray = @[@"beauty", @"cinema", @"group", @"bath", @"bar", @"bank", @"dinner", @"hotel"];
    self.nameArray = @[@"丽人", @"电影", @"商场", @"洗浴", @"网吧", @"银行", @"美食", @"酒店"];
    
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
    [AMapSearchServices sharedServices].apiKey = kLocationApk;
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;

    NSString *stringkey = self.nameArray[btn.tag - 100];
    ZPFLog(@"_currentLocation = %@", _currentLocation);
    if (_currentLocation == nil || _search == nil ) {
        ZPFLog(@"search failed");
        return;
    }
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
    request.keywords = stringkey;
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
  // request.types = @"餐饮服务|生活服务";
    request.sortrule = 0;
    request.requireExtension = YES;
    
    //发起周边搜索
    [_search AMapPOIAroundSearch: request];
    
}
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    NSLog(@"request%@", request);
    
    NSLog(@"response%ld", (unsigned long)response.pois.count);
  
    if(response.pois.count > 0)
    {
        _pois = response.pois;
        NSLog(@"_pois %@", _pois);
        [self.tableView reloadData];
        
        //清空标注
        // [_mapView removeAnnotations:_annottaions];
        [_annotations removeAllObjects];
        
     
    }
    

    
}

#pragma mark search delegate
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    
    ZPFLog(@"response:%@", response);
    NSString *title = response.regeocode.addressComponent.city;
    if (title.length == 0) {
        title = response.regeocode.addressComponent.province;
    }
    _titleCty = title;
    _address = response.regeocode.formattedAddress;
    
    
    
}
- (NSMutableArray *)annotations{
    if (_annotations == nil) {
        self.annotations = [NSMutableArray new];
    }
    return _annotations;
    
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.tabBarController.tabBar.hidden = YES;
}
- (NSArray *)pois{
    if (_pois == nil) {
        _pois = [NSArray new];
    }
    return _pois;
    
    
}
- (NSArray *)nameArray{
    if (_nameArray == nil) {
        self.nameArray = [NSArray new];
    }
    return _nameArray;
    
    
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
