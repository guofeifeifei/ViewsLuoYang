//
//  WeatherViewController.h
//  ViewLuoYang
//
//  Created by scjy on 16/3/18.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

#import <AMapSearchKit/AMapSearchKit.h>

@interface WeatherViewController : UIViewController
@property(nonatomic, strong) CLLocation *currentLocation;
@property(nonatomic, copy) NSString *titleCty;
@property(nonatomic, copy) NSString *address;
@end
