//
//  NSDictionary+ChangeNull.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-19.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "NSDictionary+ChangeNull.h"

@implementation NSDictionary (ChangeNull)
//API请求结果消息
#define RESPONSE_MESSAGE (([contentDict[@"message"]isEqualToString:@"SUCESS"])&&(![[contentDict objectForKeyWithoutNull:@"content"] isEqualToString:@""]))
 
-(id)objectForKeyWithoutNull:(id)aKey
{
    
    id result = [self objectForKey:aKey];
    if (!result||[result isEqual:[NSNull null]]) {
        result = @"";
        return result;
    }
    if (!result||[result isKindOfClass:[NSNull class]]) {
        result = @"";
        return result;
    }
    if ([result isEqual:@"null"]) {
        result=@"";
        return result;
    }
    if ([result isKindOfClass:[NSNumber class]]) {
        return [result stringValue];
    }
    
    if ([result isKindOfClass:[NSDictionary class]]||[result isKindOfClass:[NSArray class]]) {
        return result;
    }
    
    return result;
}
@end
