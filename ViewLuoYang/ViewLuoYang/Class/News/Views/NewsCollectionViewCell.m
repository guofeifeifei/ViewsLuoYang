//
//  NewsCollectionViewCell.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "NewsCollectionViewCell.h"

@implementation NewsCollectionViewCell

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
    
    
   self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20)];
    
    //设置字体大小
    self.titleLable.font = [UIFont systemFontOfSize:15.0];
    self.titleLable.numberOfLines = 0;
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.backgroundColor = [UIColor redColor];
    self.titleLable.textColor = [UIColor whiteColor];
    [self addSubview:self.image];
    [self addSubview:self.titleLable];
    
    
}

@end
