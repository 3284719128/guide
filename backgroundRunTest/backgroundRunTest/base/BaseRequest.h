//
//  BaseRequest.h
//  AnLi
//
//  Created by Yaoquan Li on 16/3/14.
//  Copyright © 2016年 ZengXinKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject


#pragma mark- 连接Node.js服务器,其他人勿用.
+ (void)requestWithInCode2:(NSString *)InCode Parameters:(NSDictionary *)parameters Block:(void (^)(NSDictionary* contentDict,NSString* message))block;


@end
