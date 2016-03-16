//
//  ServiceCollectionViewCell.h
//  ViewLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "serviceModel.h"
@interface ServiceCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) UIImageView *serviceImage;
@property(nonatomic, strong) UILabel *serviceLable;
@property(nonatomic, strong) serviceModel *model;
@end
