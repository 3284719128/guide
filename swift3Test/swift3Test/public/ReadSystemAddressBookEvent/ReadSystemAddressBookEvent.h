//
//  ReadSystemAddressBookEvent.h
//  LogisticsHousekeeper
//
//  Created by 43696467 on 16/8/8.
//  Copyright © 2016年 ZengXingTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadSystemAddressBookEvent : NSObject


@property (nonatomic,weak) UIViewController* targetVC;

@property (nonatomic,copy) void (^subBlock)(NSString* name,NSString* phone);


+(id)sharedReadSystemAddressBookEvent;

-(void)ReadSystemAddressBook:(UIViewController*) VC andSubBlock:(void (^)(NSString* name,NSString* phone)) block;


@end
