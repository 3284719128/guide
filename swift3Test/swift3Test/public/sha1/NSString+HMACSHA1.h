//
//  NSString+HMACSHA1.h
//  wordview
//
//  Created by xianjunming on 14-10-28.
//  Copyright (c) 2014年 Gamabao. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSString (HMACSHA1)

-(NSData *)HMACSHA1:(NSString *)key;
- (NSString*) sha1;/*:(NSString *)signStr;*/
- (NSString *) sha1_base64:(NSString *)signStr;

- (NSString *) md5HexDigest;

@end
