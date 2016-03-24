//
//  NTESDemoService.m
//  NIM
//
//  Created by amao on 1/20/16.
//  Copyright © 2016 Netease. All rights reserved.
//

#import "NTESDemoService.h"

@implementation NTESDemoService
+ (instancetype)sharedService
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}


- (void)registerUser:(NTESRegisterData *)data
          completion:(NTESRegisterHandler)completion
{
    NTESDemoRegisterTask *task = [[NTESDemoRegisterTask alloc] init];
    task.data = data;
    task.handler = completion;
    [self runTask:task];
}

- (void)fetchDemoChatrooms:(NTESChatroomListHandler)completion
{
    NTESDemoFetchChatroomTask *task = [[NTESDemoFetchChatroomTask alloc] init];
    task.handler = completion;
    [self runTask:task];
}


- (void)runTask:(id<NTESDemoServiceTask>)task
{
    if ([[NIMSDK sharedSDK] isUsingDemoAppKey])
    {
        NSURLRequest *request = [task taskRequest];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                                   id jsonObject = nil;
                                   NSError *error = connectionError;
                                   if (connectionError == nil &&
                                       [response isKindOfClass:[NSHTTPURLResponse class]] &&
                                       [(NSHTTPURLResponse *)response statusCode] == 200)
                                   {
                                       if (data)
                                       {
                                           jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                        options:0
                                                                                          error:&error];
                                       }
                                   }
                                   [task onGetResponse:jsonObject
                                                 error:error];
                                   
                               }];
    }
    else
    {
        //Demo Service中我们模拟了APP服务器所应该实现的部分功能，上层开发需要构建相应的APP服务器，而不是直接使用我们的DEMO服务器
        [task onGetResponse:nil
                      error:[NSError errorWithDomain:@"ntes domain"
                                                code:-1
                                            userInfo:@{@"description" : @"use your own app server"}]];
    }
}
@end
