//
//  WeatherViewController.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/18.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()<AMapSearchDelegate, UIGestureRecognizerDelegate>
{
    AMapSearchAPI *_search;
}



@property (weak, nonatomic) IBOutlet UILabel *cityLable;
@property (weak, nonatomic) IBOutlet UILabel *wearthLable;
@property (weak, nonatomic) IBOutlet UILabel *wenduLable;


@property (weak, nonatomic) IBOutlet UILabel *shiLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;


@property (weak, nonatomic) IBOutlet UILabel *oneDay;
@property (weak, nonatomic) IBOutlet UILabel *oneWearth;

@property (weak, nonatomic) IBOutlet UILabel *oneWen;
@property (weak, nonatomic) IBOutlet UILabel *TwoDay;
@property (weak, nonatomic) IBOutlet UILabel *TwoWeather;
@property (weak, nonatomic) IBOutlet UILabel *TwoWen;
@property (weak, nonatomic) IBOutlet UILabel *ThreeDay;
@property (weak, nonatomic) IBOutlet UILabel *ThreeWearth;
@property (weak, nonatomic) IBOutlet UILabel *ThreeWen;

@end

@implementation WeatherViewController
- (void)initWeather{
    //构造AMapWeatherSearchRequest对象，配置查询参数
    AMapWeatherSearchRequest *request = [[AMapWeatherSearchRequest alloc] init];
    request.city = self.titleCty;
    NSLog(@"self.titleCty ================%@", self.titleCty);
    request.type = AMapWeatherTypeLive; //AMapWeatherTypeLive为实时天气；AMapWeatherTypeForecase为预报天气
    
    //发起行政区划查询
    [_search AMapWeatherSearch:request];
    
    AMapWeatherSearchRequest *request2 = [[AMapWeatherSearchRequest alloc] init];
    request2.city = self.titleCty;
    NSLog(@"self.titleCty ================%@", self.titleCty);
    request2.type = AMapWeatherTypeForecast; //AMapWeatherTypeLive为实时天气；AMapWeatherTypeForecase为预报天气
    
    //发起行政区划查询
    [_search AMapWeatherSearch:request2];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //配置用户Key
    [AMapSearchServices sharedServices].apiKey = kLocationApk;
    
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
    
    
    if (self.currentLocation) {
        AMapReGeocodeSearchRequest *request = [[AMapReGeocodeSearchRequest alloc] init];
        request.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        [_search AMapReGoecodeSearch:request];
    }
    

    

}

- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response{
    
    
    //如果是实时天气
    if(request.type == AMapWeatherTypeLive)
    {
        if(response.lives.count == 0)
        {
            return;
        }
        for (AMapLocalWeatherLive *live in response.lives) {
            self.cityLable.text = live.city;
            self.wearthLable.text = live.weather;
           
            self.wenduLable.text = [NSString stringWithFormat:@"%@°", live.temperature];
         
            self.shiLable.text = [NSString stringWithFormat:@"%@风 %@级  %@", live.windDirection, live.windPower , live.humidity];
            
//            self.timeLable.text = live.reportTime;
            NSLog(@"%@当前时间字符串", live.reportTime);
           
            
            NSDateFormatter *dateFornatter = [[NSDateFormatter alloc] init];
            [dateFornatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *date = [dateFornatter dateFromString:live.reportTime];
            NSLog(@"date  当前时间%@", date);
            
            NSTimeInterval late = [date timeIntervalSince1970] * 1;
            NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
            NSTimeInterval now = [dat timeIntervalSince1970] * 1;
            NSString *timeString = @"";
            NSTimeInterval cha = now - late;
            
            if (cha / 86400 > 1) {
                timeString = [NSString stringWithFormat:@"%f", cha/86400];
                timeString = [timeString substringToIndex:timeString.length - 7];
                self.timeLable.text = [NSString stringWithFormat:@"%d小时前", [timeString intValue]];
            }
           
            if (cha / 3600 < 1) {
                timeString = [NSString stringWithFormat:@"%f", cha/60];
                timeString = [timeString substringToIndex:timeString.length - 7];
                self.timeLable.text = [NSString stringWithFormat:@"%d分钟前", [timeString intValue]];
                
                
                
            }
            
        }
    }
    
    
    
    //如果是实时天气
    if(request.type == AMapWeatherTypeForecast)
    {
        if(response.forecasts.count == 0)
        {
            return;
        }
        for (AMapLocalWeatherForecast *forecasts in response.forecasts) {
            if (forecasts.casts.count > 3) {
                
                
                
            
            AMapLocalDayWeatherForecast *one = forecasts.casts[0];
                NSLog(@"%@", one.week);
                 NSLog(@"%ld", [one.week integerValue]);
                switch ([one.week integerValue]) {
                case 0:
                    self.oneDay.text = @"周一";
                    break;
                    case 1:
                        self.oneDay.text = @"周二";
                        break;
                    case 2:
                        self.oneDay.text = @"周三";
                        break;
                    case 3:
                        self.oneDay.text = @"周四";
                        break;
                    case 4:
                        self.oneDay.text = @"周五";
                        break;
                   
                    case 5:
                        self.oneDay.text = @"周六";
                        break;
                    case 6:
                        self.oneDay.text = @"周天";
                        break;
                        
                default:
                    break;
                }
              //   self.oneDay.text = [NSString stringWithFormat:@"%@", [self initDay:one.week]];
                self.oneWearth.text = [NSString stringWithFormat:@"%@ ", one.dayWeather];
                self.oneWen.text =[NSString stringWithFormat:@"%@/%@", one.dayTemp, one.nightTemp];
                
             AMapLocalDayWeatherForecast *two = forecasts.casts[1];
                switch ([two.week integerValue]) {
                    case 0:
                        self.TwoDay.text = @"周一";
                        break;
                    case 1:
                        self.TwoDay.text = @"周二";
                        break;
                    case 2:
                       self.TwoDay.text = @"周三";
                        break;
                    case 3:
                      self.TwoDay.text = @"周四";
                        break;
                    case 4:
                        self.TwoDay.text = @"周五";
                        break;
                        
                    case 5:
                        self.TwoDay.text = @"周六";
                        break;
                    case 6:
                         self.TwoDay.text = @"周天";
                        break;
                        
                    default:
                        break;
                }
 //self.TwoDay.text = [NSString stringWithFormat:@"%@", [self initDay:two.week]];
                self.TwoWeather.text = [NSString stringWithFormat:@"%@", two.dayWeather];
                self.TwoWen.text =[NSString stringWithFormat:@"%@/%@", two.dayTemp, two.nightTemp];
                
                
             AMapLocalDayWeatherForecast *three = forecasts.casts[2];
//                switch ([three.week integerValue]) {
//                    case 0:
//                         self.ThreeDay.text = @"周一";
//                        break;
//                    case 1:
//                       self.ThreeDay.text = @"周二";
//                        break;
//                    case 2:
//                        self.ThreeDay.text= @"周三";
//                        break;
//                    case 3:
//                         self.ThreeDay.text= @"周四";
//                        break;
//                    case 4:
//                      self.ThreeDay.text= @"周五";
//                        break;
//                        
//                    case 5:
//                        self.ThreeDay.text = @"周六";
//                        break;
//                    case 6:
//                        self.ThreeDay.text = @"周天";
//                        break;
//                        
//                    default:
//                        break;
//                }

                self.ThreeDay.text = [NSString stringWithFormat:@"%@", [self initDay:three.week]];
                self.ThreeWearth.text = [NSString stringWithFormat:@"%@ ", three.dayWeather];
                self.ThreeWen.text =[NSString stringWithFormat:@"%@/%@", one.dayTemp, three.nightTemp];
            }
            
        }
    }
    

}


- (instancetype)initDay:(NSString *)weak{
    NSString *week = nil;
    switch ([weak integerValue]) {
        case 0:{
            week = @"周一";
            break;
        }
        case 1:{
            week = @"周二";
            break;
        }
        case 2:{
            week= @"周三";
            break;
        }
        case 3:{
           week = @"周四";
            break;
        }
        case 4:{
           week= @"周五";
            break;
        }
            
        case 5:{
            week = @"周六";
            break;
        }
        case 6:{
            week = @"周天";
            break;
        }
    }
    return nil;
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    NSLog(@"response %@", response);
    self.titleCty = response.regeocode.addressComponent.city;
    if (self.titleCty.length == 0) {
        self.titleCty = response.regeocode.addressComponent.province;
    }
    NSLog(@"%@ =========== ", self.titleCty);
    [self initWeather];
    

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
