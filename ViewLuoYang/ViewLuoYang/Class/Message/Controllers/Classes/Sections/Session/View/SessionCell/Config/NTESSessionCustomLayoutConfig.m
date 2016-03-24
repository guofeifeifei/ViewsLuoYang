//
//  NTESSessionCustomConfig.m
//  NIM
//
//  Created by chris on 15/7/24.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NTESSessionCustomLayoutConfig.h"
#import "NTESCustomAttachmentDefines.h"
#import "NTESSessionUtil.h"
#import "NTESSessionCustomContentConfig.h"

@interface NTESSessionCustomLayoutConfig()

@property (nonatomic,strong) NTESSessionCustomContentConfig *contentConfig;

@end

@implementation NTESSessionCustomLayoutConfig

- (instancetype)init{
    self = [super init];
    if (self) {
        _contentConfig = [[NTESSessionCustomContentConfig alloc] init];
    }
    return self;
}

+ (BOOL)supportMessage:(NIMMessage *)message{
    NSArray *supportType = [NTESSessionCustomLayoutConfig supportAttachmentType];
    NIMCustomObject *object = message.messageObject;
    return [supportType indexOfObject:NSStringFromClass([object.attachment class])] != NSNotFound;
}

- (CGSize)contentSize:(NIMMessageModel *)model cellWidth:(CGFloat)width{
    id<NIMSessionContentConfig> config = [self sessionContentConfig:model.message];
    return [config contentSize:width];
}

- (NSString *)cellContent:(NIMMessageModel *)model{
    id<NIMSessionContentConfig> config = [self sessionContentConfig:model.message];
    return [config cellContent];
}

- (UIEdgeInsets)contentViewInsets:(NIMMessageModel *)model
{
    id<NIMSessionContentConfig> config = [self sessionContentConfig:model.message];
    return [config contentViewInsets];
}


+ (NSArray *)supportAttachmentType
{
    static NSArray *types = nil;
    static dispatch_once_t onceTypeToken;
    //所对应的contentView只适用于cellClass为NTESSessionChatCell的情况，其他cellClass则需要自己实现布局
    dispatch_once(&onceTypeToken, ^{
        types =  @[
                   @"NTESJanKenPonAttachment",
                   @"NTESSnapchatAttachment",
                   @"NTESChartletAttachment",
                   @"NTESWhiteboardAttachment"
                   ];
    });
    return types;
}


- (NSString *)formatedMessage:(NIMMessageModel *)model{
    NIMCustomObject *object = (NIMCustomObject *)model.message.messageObject;
    id<NTESCustomAttachmentInfo> attachment = (id<NTESCustomAttachmentInfo>)object.attachment;
    if ([attachment respondsToSelector:@selector(formatedMessage)]) {
        return [attachment formatedMessage];
    }else{
        return @"";
    }
}

- (id<NIMSessionContentConfig>)sessionContentConfig:(NIMMessage *)message{
    self.contentConfig.message = message;
    return self.contentConfig;
}

@end
