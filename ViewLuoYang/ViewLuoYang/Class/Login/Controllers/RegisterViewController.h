//
//  RegisterViewController.h
//  ViewLuoYang
//
//  Created by scjy on 16/3/17.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import <UIKit/UIKit.h>
//为注册添加代理
@protocol RegisterViewControllerDelegate <NSObject>

@optional
- (void)registDidComplete:(NSString *)account password:(NSString *)password;

@end
@interface RegisterViewController : UIViewController
//代理属性
@property (nonatomic, weak) id<RegisterViewControllerDelegate> delegate;


@end
