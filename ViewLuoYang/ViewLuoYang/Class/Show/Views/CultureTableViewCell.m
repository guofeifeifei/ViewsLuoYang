//
//  CultureTableViewCell.m
//  ViewLuoYang
//
//  Created by scjy on 16/4/7.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "CultureTableViewCell.h"
@interface CultureTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
@implementation CultureTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModelCuture:(CultureModel *)modelCuture{
    if (![modelCuture.resubImage hasPrefix:@"http://"]) {
        self.image.image=[UIImage imageNamed:@"defaultImage.jpg"];
    }else{
        NSString *url = [NSString stringWithFormat:@"%@%@", modelCuture.detailrl, modelCuture.resubImage];
        [self.image sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
        
    }
    self.title.text=[NSString stringWithFormat:@"%@", modelCuture.subTitle];
    
      self.time.text=modelCuture.mtime;
    
    
  
    
}
@end
