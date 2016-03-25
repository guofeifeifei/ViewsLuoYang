//
//  LinkMan.m
//  UIDateBase
//
//  Created by scjy on 15/12/18.
//  Copyright © 2015年 scjy. All rights reserved.
//

#import "LinkMan.h"

@implementation LinkMan

- (instancetype)initWithName:(NSString *)name
                 andheadImage:(NSString *)headImage gender:(NSString *)gender andcity:(NSString *)city andfollowers:(NSString *)followers{
    
    
    self=[super self];
    if (self) {
        
        
        _name=name;
        _headImage=headImage;
        _gender=gender;
        _city=city;
        _followers=followers;
        
        
        
        
    }
    
    
    
    return self;
    
}






+(instancetype)linkManWithName:(NSString *)name andheadImage:(NSString *)headImage gender:(NSString *)gender andcity:(NSString *)city andfollowers:(NSString *)followers{
    
    
    LinkMan *linkman=[[LinkMan alloc]initWithName:name andheadImage:headImage gender:gender andcity:city andfollowers:followers];
    
    
    return linkman;
    
}









@end
