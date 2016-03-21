//
//  ShareView.m
//  ContactWeekend
//
//  Created by scjy on 16/1/14.
//  Copyright © 2016年 秦俊珍. All rights reserved.
//

#import "ShareView.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "WXApi.h"
@interface ShareView()<WeiboSDKDelegate,WBHttpRequestDelegate, WXApiDelegate,UIScrollViewDelegate>
{
    WBSDKRelationshipButton *relationshipButton;
    WBSDKCommentButton *commentButton;
}

@property(nonatomic, strong) UIView *blackView;
@property(nonatomic, strong) UIView *shareView;


@end


@implementation ShareView
- (instancetype)init{
    self = [super init];
    if (self) {
        [self configSharView];
    }
    return self;
    
    
}
- (void)configSharView{
    
    

    UIWindow *window = [[UIApplication sharedApplication ].delegate window];
    
    
    self.blackView = [[UIView alloc] initWithFrame:CGRectMake(0,0, KScreenWidth, KScreenHeight)];
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha =0.0;
    [window addSubview:self.blackView];
    
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0,KScreenHeight -250, KScreenWidth, 250)];
    self.shareView.backgroundColor = [UIColor whiteColor];
    [window addSubview:self.shareView];
    //微博
    UIButton *weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboBtn.frame = CGRectMake(KScreenWidth/7, 44, KScreenWidth/7,KScreenWidth/7);
    [weiboBtn setImage:[UIImage imageNamed:@"sina_normal"] forState:UIControlStateNormal];
    
    [self.shareView addSubview:weiboBtn];
    
    UILabel *weiboLable = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/7-5, KScreenWidth/7+44, KScreenWidth/7+10, 44)];
    weiboLable.textAlignment = NSTextAlignmentCenter;
    weiboLable.text = @"新浪微博";
    weiboLable.font = [UIFont systemFontOfSize:13.0f];
    [self.shareView addSubview:weiboLable];
    
    UIButton *weibo = [UIButton buttonWithType:UIButtonTypeCustom];
    weibo.frame = CGRectMake(KScreenWidth/7, 44, KScreenWidth/7, KScreenWidth/7+44);
    [weibo addTarget:self action:@selector(weiBoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:weibo];
    
    
    
    //朋友圈
    UIButton *friendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    friendBtn.frame = CGRectMake(KScreenWidth/7*3, 44, KScreenWidth/7, KScreenWidth/7);
    [friendBtn setImage:[UIImage imageNamed:@"py_normal"] forState:UIControlStateNormal];
    
    [self.shareView addSubview:friendBtn];
    
    UILabel *friendLable = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/7*3, KScreenWidth/7+44, KScreenWidth/7, 44)];
    friendLable.textAlignment = NSTextAlignmentCenter;
    friendLable.text = @"朋友圈";
    friendLable.font = [UIFont systemFontOfSize:14];
    [self.shareView addSubview:friendLable];
    
    UIButton *friend = [UIButton buttonWithType:UIButtonTypeCustom];
    friend.frame = CGRectMake(KScreenWidth/7*3, 44, KScreenWidth/7, KScreenWidth/7+44);
    [friend addTarget:self action:@selector(friendAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:friend];
    
    

    //微信
    UIButton *weixinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weixinBtn.frame = CGRectMake(KScreenWidth/7*5, 44, KScreenWidth/7, KScreenWidth/7);
    [weixinBtn setImage:[UIImage imageNamed:@"wx_normal"] forState:UIControlStateNormal];
    
    [self.shareView addSubview:weixinBtn];
    UILabel *weixinLable = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/7*5, KScreenWidth/7+44, KScreenWidth/7, 44)];
    weixinLable.textAlignment = NSTextAlignmentCenter;
    weixinLable.text = @"微信";
    weixinLable.font = [UIFont systemFontOfSize:14];
    [self.shareView addSubview:weixinLable];
    
    UIButton *weixin = [UIButton buttonWithType:UIButtonTypeCustom];
    weixin.frame = CGRectMake(KScreenWidth/7*5, 44, KScreenWidth/7, KScreenWidth/7+44);
    [weixin addTarget:self action:@selector(weixinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:weixin];
    
    
    
    //remove
    UIButton *removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    removeBtn.backgroundColor = barColor;
    removeBtn.frame = CGRectMake(KScreenWidth/14, KScreenWidth/4*2, KScreenWidth/7*6, 44);
    [removeBtn setTitle:@"取消" forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(removeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:removeBtn];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.blackView.alpha = 0.8;
        self.shareView.frame = CGRectMake(0, KScreenHeight - 250, KScreenWidth, 250);
    }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:1.0 animations:^{
                             self.blackView.alpha = 0.8;
                         }];
                     }];
    
    

    UILabel *fenxiangLable = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth/4, 0, KScreenWidth/2, 44)];
    fenxiangLable.textAlignment = NSTextAlignmentCenter;
    fenxiangLable.text = @"分享给你的";
    fenxiangLable.font = [UIFont systemFontOfSize:18];
    [self.shareView addSubview:fenxiangLable];
}

- (void)removeBtn{
    [UIView animateWithDuration:0.5 animations:^{
        self.blackView.alpha = 0.0;
        self.shareView.alpha = 0.0;
    }];
    [self.blackView removeFromSuperview];
    [self.shareView removeFromSuperview];

}


- (void)weiBoAction{
    [self removeBtn];
    ZPFLog(@"新浪");
    //新浪微博分享
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    WBAuthorizeRequest *authRequest1 =[WBAuthorizeRequest request];
    authRequest1.redirectURI = kRedirectURL;
    authRequest1.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest1 access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
    [self.blackView removeFromSuperview];
    [self.shareView removeFromSuperview];
   
  
}
- (WBMessageObject *)messageToShare{
    WBMessageObject *message = [WBMessageObject message];
    //把url分享到微博中
    message.text = self.url;
    return message;
    
}


- (void)friendAction{
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    //把url分享到朋友圈
    req.text = self.url;
    req.bText = YES;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}

- (void)weixinAction{
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    //把url分享到微信好友
    req.text = self.url;
    req.bText = YES;
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
    
}

- (void)onReq:(BaseReq *)req{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
        
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n\n", msg.title, msg.description, obj.extInfo, (unsigned long)msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)onResp:(BaseResp *)resp{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
