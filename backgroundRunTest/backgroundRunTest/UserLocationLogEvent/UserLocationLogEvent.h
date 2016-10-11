//
//  UserLocationLogEvent.h
//  ZENGXIN
//
//  Created by 43696467 on 2016/10/9.
//  Copyright © 2016年 panda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLocationLogEvent : NSObject



+(id)sharedUserLocationLogEvent;

-(void)logEvent:(NSString*) logType andContentStr:(NSString*) contentStr andTypeNum:(int) typeNum andIsTerminate:(BOOL) isTerminate;

@end
