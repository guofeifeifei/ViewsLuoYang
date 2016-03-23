//
//  ServiceCollectionViewCell.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "ServiceCollectionViewCell.h"

@implementation ServiceCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadingView];
    }
    return self;
}
- (void)loadingView{
   
    self.serviceImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20,  self.frame.size.width - 20)];
   
    [self addSubview:self.serviceImage];
    self.serviceLable = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frame.size.width - 20, self.frame.size.width - 10, 20)];
    self.serviceLable.font = [UIFont systemFontOfSize:12.0];
       [self addSubview:self.serviceLable];
    
    
    
}
- (void)setModel:(serviceModel *)model{
    [self.serviceImage sd_setImageWithURL:[NSURL URLWithString:model.app_icon] completed:nil];
    self.serviceLable.text = model.app_name;
    
    
}
@end
