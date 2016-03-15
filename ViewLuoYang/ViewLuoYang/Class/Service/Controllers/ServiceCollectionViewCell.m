//
//  ServiceCollectionViewCell.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
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
   
    self.serviceImage = [[UIImageView alloc] initWithFrame:CGRectMake(50 / 2, 0, self.frame.size.width - 50,  self.frame.size.width - 50)];
   
    [self addSubview:self.serviceImage];
    self.serviceLable = [[UILabel alloc] initWithFrame:CGRectMake(20, self.frame.size.width - 40, self.frame.size.width - 20, 20)];
    self.serviceLable.font = [UIFont systemFontOfSize:12.0];
       [self addSubview:self.serviceLable];
    
    
    
}
- (void)setModel:(serviceModel *)model{
    [self.serviceImage sd_setImageWithURL:[NSURL URLWithString:model.app_icon] completed:nil];
    self.serviceLable.text = model.app_name;
    
    
}
@end
