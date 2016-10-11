//
//  UserLocationLogEvent.m
//  ZENGXIN
//
//  Created by 43696467 on 2016/10/9.
//  Copyright © 2016年 panda. All rights reserved.
//

#import "UserLocationLogEvent.h"

#import "AppDelegate.h"

@implementation UserLocationLogEvent

static UserLocationLogEvent* userLocationLogE=nil;



+(id)sharedUserLocationLogEvent{
    
    if (userLocationLogE==nil) {
        userLocationLogE=[[UserLocationLogEvent alloc] init];
    };
    
    return userLocationLogE;
    
}


-(void)logEvent:(NSString*) logType andContentStr:(NSString*) contentStr andTypeNum:(int) typeNum andIsTerminate:(BOOL) isTerminate{
    
    //1 服务状态 2 百度位置更新 3 请求 4 批量上传
    [self writeToFile:logType andContentStr:contentStr andTypeNum:typeNum];

}


-(void)writeToFile:(NSString*) logType andContentStr:(NSString*) contentStr andTypeNum:(int) typeNum{
    
    NSString* userDocument=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [userDocument stringByAppendingPathComponent:@"UserLocationLog"];
    NSString* oldStr=[NSString stringWithContentsOfFile:path];
    if (oldStr == nil) {
        oldStr=@"";
    };
    
    NSString* dateStr=[Utils stringFromDateWithFormat:[NSDate date] andFormatStr:@"yyyy-MM-dd HH:mm:ss"];//yyyyMMddHHmmss
    NSString* str=[NSString stringWithFormat:@"%@\n%d、动作:%@,记录时间:%@,内容:%@",oldStr,typeNum,logType,dateStr,contentStr];
    NSLog(@"path=========%@",path);
    [str writeToFile:path atomically:YES];
    
}



@end
