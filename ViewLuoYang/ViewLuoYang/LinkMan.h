//
//  LinkMan.h
//  UIDateBase
//
//  Created by scjy on 15/12/18.
//  Copyright © 2015年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkMan : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *headImage;
@property(nonatomic, copy) NSString *gender;
@property(nonatomic, copy) NSString *city;
@property(nonatomic, copy) NSString *followers;//粉丝

+(instancetype)linkManWithName:(NSString *)name andheadImage:(NSString *)headImage gender:(NSString *)gender andcity:(NSString *)city andfollowers:(NSString *)followers;

@end
