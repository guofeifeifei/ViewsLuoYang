//
//  UIViewController+Common.h
//  Happyholiday
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeReaderDelegate.h"
@interface UIViewController (Common)<QRCodeReaderDelegate>

- (void)showBarButtonWithImage:(NSString *)imageName;
- (void)showBarButtonWithcode;
- (void)showMeButton;
- (void)showRightBarButtonWithTitle:(NSString *)title;


- (void)showalertView:(NSString *)alertTitle andMessage:(NSString *)message andstyle:(UIAlertControllerStyle)style addAction:(NSString *)actionTitle andActionStyle:(UIAlertActionStyle)actionStyle and:(NSString *)info;


@end
