//
//  NearViewController.h
//  ViewLuoYang
//
//  Created by scjy on 16/3/17.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

#import <AMapSearchKit/AMapSearchKit.h>
@protocol AnnotationValeDelegate <NSObject>
- (void)AMapPOIValeDelegate:(AMapPOI *) poi;
@end
@interface NearViewController : UIViewController
@property(nonatomic, strong) CLLocation *currentLocation;
@property(nonatomic, copy) NSString *titleCty;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, assign) id<AnnotationValeDelegate> delegate;
@end
