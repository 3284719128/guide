//
//  BaseRequest.m
//  AnLi
//
//  Created by Yaoquan Li on 16/3/14.
//  Copyright © 2016年 ZengXinKeJi. All rights reserved.
//

#import "BaseRequest.h"

#import "AFNetworking.h"
#import "SBJson4Writer.h"


@implementation BaseRequest


#pragma mark- 连接Note.js服务器,其他人勿用.

+ (void)requestWithInCode2:(NSString *)InCode Parameters:(NSDictionary *)parameters Block:(void (^)(NSDictionary* contentDict,NSString* message))block{
    
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 30.0;
    AFURLSessionManager* Manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:config];
    Manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableURLRequest* request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.138:8081/intf"]];
    request.HTTPMethod=@"POST";
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Contsetent-Type"];
    [request setValue:@"wo56.com" forHTTPHeaderField:@"Encrypt-Code"];
    //    [request setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
    //    [request setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    [request setValue:[UIDevice currentDevice].model forHTTPHeaderField:@"User-Agent"];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    
    [dict setObject:(InCode?InCode:@"") forKey:@"inCode"];
    [dict setObject:[Utils networkingStatesFromStatebar] forKey:@"netType"];
    [dict setObject:@"" forKey:@"appId"];
    [dict setObject:@"" forKey:@"ver"];
    [dict setObject:@""  forKey:@"tokenId"];
    if (parameters) {
        [dict setObject:parameters forKey:@"content"];
    }
    else {
        NSDictionary * dict_temp = [[NSDictionary alloc]init];
        [dict setObject:dict_temp forKey:@"content"];
    };
    SBJson4Writer * writer = [[SBJson4Writer alloc]init];
    NSString* json_str = [writer stringWithObject:dict];
    
    NSData* paramsData=[json_str dataUsingEncoding:NSUTF8StringEncoding];
    
    request.HTTPBody=paramsData;
    
    NSURLSessionDataTask * dataTask = [Manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if ([responseObject length] > 0) {
            
            NSDictionary* dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            int resultCode = [[dict objectForKey:@"status"] intValue];
            switch (resultCode) {
                case 200:
                {
                    NSDictionary* resultDict=[dict objectForKey:@"content"];
                    block(resultDict,@"SUCESS");
                }
                    break;
                case 500:
                {
                    NSString* message=[dict objectForKey:@"message"];
                    block(nil,message);
                }
                    break;
                    
                default:
                {
                    block(nil,@"其它错误");
                }
                    break;
            };
            
        }else {
            block(nil,@"data is nil");
            return;
        }
    }];
    
    [dataTask resume];
    
}



@end
