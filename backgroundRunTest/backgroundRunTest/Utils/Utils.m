//
//  Utils.m
//  wordview
//
//  Created by xianjunming on 14-10-21.
//  Copyright (c) 2014年 Gamabao. All rights reserved.
//

#import "Utils.h"

#import "Reachability2.h"


@implementation Utils


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
