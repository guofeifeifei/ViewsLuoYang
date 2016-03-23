//
//  Collect.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/21.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "Collect.h"

@implementation Collect

- (instancetype)initWithCollectWithUrl:(NSString *)url{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}



+ (instancetype)collectWithUrl:(NSString *)url{
    Collect *collect = [[Collect alloc] initWithCollectWithUrl:url];
    return collect;
}


@end
