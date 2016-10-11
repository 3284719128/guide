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

typedef NS_ENUM (NSInteger,SIAlertViewBackgroundStyle){
    SUCCESS     =     200,
    SUCCESS403  =     403,
    SUCCESS500  =     500,
    SUCCESS501  =     501,
    SUCCESS505  =     505
};


@implementation BaseRequest


+ (void)requestWithInCode:(NSString *)InCode Parameters:(NSDictionary *)parameters Block:(void (^)(NSDictionary* contentDict,NSString* message))block {
    
    
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    config.timeoutIntervalForRequest = 10.0;
    
    AFURLSessionManager* Manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:config];
    
    Manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    
    [dict setObject:(InCode?InCode:@"") forKey:@"inCode"];
    
    [dict setObject:[Utils networkingStatesFromStatebar] forKey:@"netType"];
    
    [dict setObject:@"T_100000" forKey:@"appId"];
    
    [dict setObject:Version forKey:@"ver"];
    
    //    UserInfomation * myUserInfomation = [UserInfomation sharedInstance];
    
    
    [dict setObject:UID forKey:@"uId"];
    
    
    [dict setObject:TOKENID forKey:@"tokenId"];
    
    if (parameters) {
        [dict setObject:parameters forKey:@"content"];
    }
    else {
        NSDictionary * dict_temp = [[NSDictionary alloc]init];
        [dict setObject:dict_temp forKey:@"content"];
    }
    
    NSURLSessionDataTask * dataTask = [Manager dataTaskWithRequest:[Utils getRequestWithParameter:dict] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        // 成功后的处理
        if ([responseObject length] > 0) {
            
            NSDictionary * responseDic = [Utils getResultWithData:responseObject];
            SIAlertViewBackgroundStyle resultCode;
            resultCode = [[responseDic objectForKey:@"status"] intValue];
            
            switch (resultCode) {
                case SUCCESS:
                    NSLog(@"成功返回数据");
                {
                    NSString* str=@"SUCESS";
                    NSDictionary *data=[responseDic objectForKey:@"content"];
                    block(data,str);
                }
                    break;
                case SUCCESS403:
                    NSLog(@"未认证或token过期");
                {
                    //                    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotification_Response_403 object:nil];
                    //                    block(nil,nil);
                }
                    
                    break;
                case SUCCESS500:
                    NSLog(@"服务器内部错误，运行时异常:%@",[responseDic objectForKey:@"message"]);
                {
                    NSString* str=@"网络不给力，请稍后加载";
                    block(nil,str);
                }
                    break;
                case SUCCESS501:
                    NSLog(@"服务器不支持请求错误，业务级错误提示:%@",[responseDic objectForKey:@"message"]);
                {
                    NSString* str=[responseDic objectForKey:@"message"];
                    block(nil,str);
                }
                    break;
                case SUCCESS505:
                    NSLog(@"服务器拒绝请求，数字签名不正确");
                {
                    //                    [[NSNotificationCenter defaultCenter] postNotificationName:NSNotification_Response_403 object:nil];
                    NSString* str=@"服务器拒绝请求，数字签名不正确";
                    block(nil,str);
                }
                    break;
                    
                default:
                    NSLog(@"其它错误");
                {
                    NSString* str=[responseDic objectForKey:@"message"];
                    block(nil,str);
                }
                    
                    break;
            }
            
            
        }
        else {
            NSString* str=@"网络不给力，请稍后加载";
            block(nil,str);
        }
    }];
    
    
    [dataTask resume];
}



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
