//
//  Utils.m
//  wordview
//
//  Created by xianjunming on 14-10-21.
//  Copyright (c) 2014年 Gamabao. All rights reserved.
//

#import "Utils.h"

#import "Reachability2.h"
#import "NSString+safe.h"
#import "NSString+HMACSHA1.h"
#import "SBJson4Writer.h"


@implementation Utils


#pragma mark - 获取加密request
+ (NSMutableURLRequest *)getRequestWithParameter:(NSDictionary *)dict {
    
    NSMutableDictionary * dict_1 = [[NSMutableDictionary alloc]initWithDictionary:dict];
    
    [dict_1 setObject:Version forKey:@"ver"];
    
    [dict_1 setObject:APP_ID forKey:@"appId"];
    
    NSString *URLTmp1 = [NSString getSafeWithTokenID:TOKENID dict:dict_1];
    
    /*
     *加密
     */
    
    NSMutableDictionary * dictMutable = [[NSMutableDictionary alloc]initWithDictionary:dict];
    
    SBJson4Writer* writer = [[SBJson4Writer alloc]init];
    
    NSString * json_str = [writer stringWithObject:[dict objectForKey:@"content"]];
    
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    
    NSString * time_str = [NSString stringWithFormat:@"%0.0f",time];
    
    
    NSInteger random = arc4random();
    
    NSString * random_str = [NSString stringWithFormat:@"%ld",(long)random];
    
    
    NSArray * array1 = @[TOKENID,json_str,time_str,random_str,SAFE_KEY];
    
    NSArray * sort = [array1 sortedArrayUsingSelector:@selector(compare:)];
    
    
    NSString * sort_str = [NSString stringWithFormat:@"[%@, %@, %@, %@, %@]",sort[0],sort[1],sort[2],sort[3],sort[4]];
    
    NSString * sha1 = [sort_str sha1];
    
    
    //    NSString * result = [NSString stringWithFormat:@"%@?time=%@&rd=%@&sign=%@",WebPageURL,time_str,random_str,sha1];
    
    [dictMutable setValue:time_str forKey:@"time"];
    [dictMutable setValue:random_str forKey:@"rd"];
    [dictMutable setValue:sha1 forKey:@"sign"];
    [dictMutable setObject:Version forKey:@"ver"];
    [dictMutable setObject:APP_ID forKey:@"appId"];
    
    NSData * data = [NSJSONSerialization dataWithJSONObject:dictMutable options:0 error:nil];
    
    Byte * testByte = (Byte *)[data bytes];
    NSMutableData * dataXor = [[NSMutableData alloc]init];
    for (int i = 0; i < data.length; i ++) {
        Byte byteT[1];
        byteT[0] = testByte[i] ^ 0xff;
        [dataXor appendBytes:byteT length:1];
    }
    
    NSString* encodeResult = [dataXor base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSMutableURLRequest *request =
    [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLTmp1]];
    request.timeoutInterval = 15.0;
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Contsetent-Type"];
    [request setValue:@"wo56.com" forHTTPHeaderField:@"Encrypt-Code"];
    [request setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    [request setValue:[UIDevice currentDevice].model forHTTPHeaderField:@"User-Agent"];
    [request setHTTPBody:[encodeResult dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
}


#pragma mark - 获取解密数据
+ (NSDictionary *)getResultWithData:(NSData *)data {
    NSData * decodeData = [[NSData alloc] initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    Byte * testByte = (Byte *)[decodeData bytes];
    NSMutableData * dataXor = [[NSMutableData alloc]init];
    for (int i = 0; i < decodeData.length; i ++) {
        Byte byteT[1];
        byteT[0] = testByte[i] ^ 0xff;
        [dataXor appendBytes:byteT length:1];
    }
    
    NSDictionary * result = [NSJSONSerialization JSONObjectWithData:dataXor options:NSJSONReadingMutableContainers error:nil];
    return result;
}



+(NSString*)locationServicesEnabledJudge{
    
    NSString* flag=@"已开启";
    
    CLLocationManager * location = [[CLLocationManager alloc]init];
    location.pausesLocationUpdatesAutomatically = NO;
    if(![CLLocationManager locationServicesEnabled]){
        
        flag=@"未开启";
        
    }else{
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
            
            flag=@"未开启";
            
        }else{
            
            flag=@"已开启";
        }
    };
    
    return flag;
    
}



+(NSString*)networkingStatesFromReachability{
    
//    __block NSString* isExistenceNetwork = @"有网";
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        
//        switch (status) {
//                
//            case AFNetworkReachabilityStatusNotReachable:{
//                
//                isExistenceNetwork = @"无网";
//                break;
//                
//            }
//                
//            case AFNetworkReachabilityStatusReachableViaWiFi:{
//                
//                isExistenceNetwork = @"有网";
//                break;
//                
//            }
//                
//            case AFNetworkReachabilityStatusReachableViaWWAN:{
//                
//                isExistenceNetwork = @"有网";
//                break;
//                
//            }
//                
//            default:
//                
//                isExistenceNetwork = @"无网";
//                break;
//                
//        }
//        
//    }];

    
    NSString* isExistenceNetwork = @"有网";
    
    Reachability2 *reach = [Reachability2 reachabilityWithHostName:@"https://www.baidu.com"];
    
    switch ([reach currentReachabilityStatus]) {
        case NotReachable2:
            isExistenceNetwork = @"无网";
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi2:
            isExistenceNetwork = @"有网";
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN2:
            isExistenceNetwork = @"有网";
            //NSLog(@"3G");
            break;
    }
    
    return isExistenceNetwork;
    
}


+ (NSString *)networkingStatesFromStatebar {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"wifi";
    
    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";
            break;
            
        case 5:
            stateString = @"wifi";
            break;
            
        default:
            break;
    }
    
    return stateString;
}


+(NSString*)stringFromDateWithFormat:(NSDate *)date andFormatStr:(NSString*) formatStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatStr];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}


@end
