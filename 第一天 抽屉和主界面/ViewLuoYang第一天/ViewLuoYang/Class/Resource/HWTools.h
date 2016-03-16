//
//  HWTools.h
//  Happyholiday
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWTools : NSObject



#pragma mark   -----时间转换的相关方法

//根据时间戳返回字符串
+ (NSString *)getDateFromString:(NSString *)timeStamp;


//获取系统时间


+ (NSDate *)getSystemNowdate;



#pragma mark ------自定义高度


+ (CGFloat)getTextHeightWithText:(NSString *)text  bigSize:(CGSize)bigSize textFont:(CGFloat)font;







@end
