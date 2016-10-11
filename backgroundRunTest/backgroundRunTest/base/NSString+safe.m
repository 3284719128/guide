//
//  NSString+safe.m
//  ZENGXIN
//
//  Created by Yaoquan Li on 15/4/10.
//  Copyright (c) 2015年 panda. All rights reserved.
//

#import "NSString+safe.h"
#import "SBJson4Writer.h"
#import "NSString+HMACSHA1.h"
//#import "Interface.h"
@implementation NSString (safe)


+ (NSString *)getSafeWithTokenID:(NSString *)tokenID dict:(NSDictionary *)dict {
    
    
    SBJson4Writer * writer = [[SBJson4Writer alloc]init];
    
    NSString * json_str = [writer stringWithObject:dict];
    
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    
    NSString * time_str = [NSString stringWithFormat:@"%0.0f",time];
    

    NSInteger random = arc4random();
    
    NSString * random_str = [NSString stringWithFormat:@"%ld",(long)random];
    
    
    NSArray * array1 = @[tokenID,json_str,time_str,random_str];
    
    NSArray * sort = [array1 sortedArrayUsingSelector:@selector(compare:)];
    
    
    NSString * sort_str = [NSString stringWithFormat:@"[%@, %@, %@, %@]",sort[0],sort[1],sort[2],sort[3]];
    
    NSString * sha1 = [sort_str sha1];
    
    
    NSString * result = [NSString stringWithFormat:@"%@?time=%@&rd=%@&sign=%@",WebPageURL,time_str,random_str,sha1];
    
    return [result stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}

+ (NSString *)getSafeWithdict:(NSDictionary *)dict {
    
    
    SBJson4Writer * writer = [[SBJson4Writer alloc]init];
    
    NSString * json_str = [writer stringWithObject:dict];
    
    
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    
    NSString * time_str = [NSString stringWithFormat:@"%0.0f",time];
    
    
    NSInteger random = arc4random();
    
    NSString * random_str = [NSString stringWithFormat:@"%ld",(long)random];
    
    
    NSArray * array1 = @[TOKENID,json_str,time_str,random_str];
    
    NSArray * sort = [array1 sortedArrayUsingSelector:@selector(compare:)];
    
    NSString * sort_str = [NSString stringWithFormat:@"[%@, %@, %@, %@]",sort[0],sort[1],sort[2],sort[3]];

    NSString * sha1 = [sort_str sha1];

    NSString * result = [NSString stringWithFormat:@"%@?time=%@&rd=%@&sign=%@",WebPageURL,time_str,random_str,sha1];
    
    return [result stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

+ (NSString *)getTimeStr:(NSString *)timeStr {
    NSString * result;
    NSDateFormatter * formatter=[[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter * formatter2=[[NSDateFormatter alloc] init];
    formatter2.dateFormat = @"MM-dd HH:mm";
    NSDate * date1 = [formatter dateFromString:timeStr];
    NSTimeInterval time1 = -[date1 timeIntervalSinceNow];
    
    if (time1 < 60) {
        result = @"一分钟前";
    }
    
    else if (time1 < 3600) {
        result = [NSString stringWithFormat:@"%u分钟前",(unsigned)(time1 / 60)];
    }
    
    else if (time1 < 18000) {
        result = [NSString stringWithFormat:@"%u小时前",(unsigned)(time1 / 3600)];
    }
    
    else {
        result = [formatter2 stringFromDate:date1];
    }

    return result;
}

+ (NSString *)getUpdateTimeWithDate:(NSDate *)dateUpdate {
    NSString * result;
    NSTimeInterval time1 = - [dateUpdate timeIntervalSinceNow];
    
    NSDateFormatter * formatter2=[[NSDateFormatter alloc] init];
    formatter2.dateFormat = @"MM-dd HH:mm";
    
    if (time1 < 60) {
        result = @"刚刚更新";
    }
    else if (time1 < 3600) {
        result = [NSString stringWithFormat:@"%u分钟前更新",(unsigned)(time1 / 60)];
    }
    
    else if (time1 < 18000) {
        result = [NSString stringWithFormat:@"%u小时前更新",(unsigned)(time1 / 3600)];
    }
    
    else {
        result = [NSString stringWithFormat:@"%@更新",[formatter2 stringFromDate:dateUpdate]];
    }
    return result;
}


@end
