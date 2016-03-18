//
//  NearViewController.h
//  ViewLuoYang
//
//  Created by scjy on 16/3/17.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface NearViewController : UIViewController
@property(nonatomic, strong) CLLocation *currentLocation;
@end
