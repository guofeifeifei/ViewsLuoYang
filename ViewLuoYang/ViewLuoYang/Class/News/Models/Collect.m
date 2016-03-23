//
//  Collect.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/21.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "Collect.h"

@implementation Collect

- (instancetype)initWithCollectWithUrl:(NSString *)url image:(NSString *)image{
    self = [super init];
    if (self) {
        self.url = url;
        self.image = image;
    }
    return self;
}



+ (instancetype)collectWithUrl:(NSString *)url image:(NSString *)image{
    
    Collect *collect = [[Collect alloc] initWithCollectWithUrl:url image:image];
    return collect;
}


@end
