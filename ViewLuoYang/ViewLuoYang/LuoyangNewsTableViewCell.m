//
//  LuoyangNewsTableViewCell.m
//  ViewLuoYang
//
//  Created by scjy on 16/3/15.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "LuoyangNewsTableViewCell.h"



@interface LuoyangNewsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *comeFromLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;



@property (weak, nonatomic) IBOutlet UILabel *wantchLabel;


@end



@implementation LuoyangNewsTableViewCell

- (void)setModel:(LuoyangNews *)model{
    
    if (![model.resubImage hasPrefix:@"http://"]) {
        self.leftImageView.image=[UIImage imageNamed:@"defaultImage.jpg"];
    }else{
        
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.resubImage] placeholderImage:nil];
        
    }
    

    self.wantchLabel.text=[NSString stringWithFormat:@"%@", model.views];

    self.titleLabel.text=model.title;
    self.timeLabel.text=model.mtime;
    self.comeFromLabel.text=model.source;
    
    
    
    
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
