//
//  AppDelegate.h
//  backgroundRunTest
//
//  Created by 43696467 on 2016/10/11.
//  Copyright © 2016年 team1. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserLocationLogEvent.h"

#define ScheduledTimerWithTimeInterval 10

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) BMKLocationService* LocationService;
@property (nonatomic,strong) BMKGeoCodeSearch* searcher;

@property (nonatomic) CLLocationCoordinate2D someMinutesBeforeLocationCoordinate;
@property (nonatomic) CLLocationCoordinate2D currentUserLocationCoordinate;

@property (nonatomic,copy) NSString* currentUserAddressStr;

@property (nonatomic,assign) BOOL isFirstUnderAppLocationDistanceInterval;
@property (nonatomic,assign) BOOL isEnterBackground;


@property (nonatomic, strong) NSTimer* timer;

@property (nonatomic,strong) UserLocationLogEvent* userLocationLogE;


@end

