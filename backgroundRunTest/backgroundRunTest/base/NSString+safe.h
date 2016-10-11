//
//  NSString+safe.h
//  ZENGXIN
//
//  Created by Yaoquan Li on 15/4/10.
//  Copyright (c) 2015年 panda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (safe)

+ (NSString *)getSafeWithTokenID:(NSString *)tokenID dict:(NSDictionary *)dict;

+ (NSString *)getSafeWithdict:(NSDictionary *)dict;

+ (NSString *)getTimeStr:(NSString *)timeStr;

+ (NSString *)getUpdateTimeWithDate:(NSDate *)dateUpdate;


@end
