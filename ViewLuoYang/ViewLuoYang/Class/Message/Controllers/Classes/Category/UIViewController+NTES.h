//
//  UIViewController+NTES.h
//  NIM
//
//  Created by chris on 15/12/17.
//  Copyright © 2015年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NTES)

//在viewWillAppear的时候或之后调用
- (void)useClearNavigationBar;

- (void)useDefaultNavigationBar;

@end
