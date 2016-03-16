//
//  NewsScondCollectionViewCell.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/16.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "NewsScondCollectionViewCell.h"

@implementation NewsScondCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}
-(void)customView{
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.image];
    
}

@end
