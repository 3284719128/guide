//
//  customAlertViewEvent.h
//  WO56_Driver
//
//  Created by 43696467 on 16/3/10.
//  Copyright © 2016年 Yaoquan Li. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface customAlertViewEvent : NSObject


+(id)sharedCustomAlertViewEventWithMessageStr:(NSString*) messageStr andCancelStr:(NSString*) cancelStr andOkStr:(NSString*) OkStr andCancelBlock:(void (^)()) cancelBlock andOkBlock:(void (^)()) okBlock;


@end
