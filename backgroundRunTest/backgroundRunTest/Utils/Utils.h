//
//  Utils.h
//  wordview
//
//  Created by xianjunming on 14-10-21.
//  Copyright (c) 2014年 Gamabao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Utils : NSObject


#pragma mark - 获取加密request
+ (NSMutableURLRequest *)getRequestWithParameter:(NSDictionary *)dict;

#pragma mark - 获取解密数据
+ (NSDictionary *)getResultWithData:(NSData *)data;

#pragma mark - GPS状态
+(NSString*)locationServicesEnabledJudge;

#pragma mark - 获取网络状态
+ (NSString *)networkingStatesFromStatebar;
+(NSString*)networkingStatesFromReachability;


#pragma mark - 根据格式传data返回字符串
+(NSString*)stringFromDateWithFormat:(NSDate *)date andFormatStr:(NSString*) formatStr;


@end


