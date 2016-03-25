//
//  NIMChatroomMessageDataProvider.h
//  NIM
//
//  Created by chris on 15/12/14.
//  Copyright © 2015年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NIMChatroomMessageDataProvider : NSObject<NIMKitMessageProvider>

- (instancetype)initWithChatroom:(NSString *)roomId;

@end
