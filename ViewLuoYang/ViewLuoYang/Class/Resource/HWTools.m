//
//  HWTools.m
//  Happyholiday
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "HWTools.h"

@implementation HWTools



#pragma mark   -----时间转换的相关方法


+ (NSString *)getDateFromString:(NSString *)timeStamp{
    
    
    
    
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]];
   
    NSDateFormatter  *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    
     NSString *dateString=[dateFormatter stringFromDate:date];
    
    return dateString;
    
    
}

//获取系统时间


+ (NSDate *)getSystemNowdate{
    
    //创建一个NSDataFormatter显示刷新时间
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [df stringFromDate:[NSDate date]];
    NSDate *date = [df dateFromString:dateStr];
    
    
    return date;
  
    
}




#pragma mark ---自定义高度

+ (CGFloat)getTextHeightWithText:(NSString *)text bigSize:(CGSize)bigSize textFont:(CGFloat)font{
    
    
    CGRect textRect=[text boundingRectWithSize:bigSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:font]} context:nil];
    
    return textRect.size.height;
    
}











@end
