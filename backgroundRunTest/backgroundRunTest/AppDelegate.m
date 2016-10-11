//
//  AppDelegate.m
//  backgroundRunTest
//
//  Created by 43696467 on 2016/10/11.
//  Copyright © 2016年 team1. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@interface AppDelegate ()
{
    NSUserDefaults* userDefaults;
}

@end

@implementation AppDelegate


UIBackgroundTaskIdentifier BackgroundTaskId;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController=[[ViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    self.isFirstUnderAppLocationDistanceInterval=NO;
    self.isEnterBackground=NO;
    self.currentUserAddressStr=@"";
    
    _timer=[NSTimer scheduledTimerWithTimeInterval:ScheduledTimerWithTimeInterval target:self selector:@selector(backgroundRun) userInfo:nil repeats:YES];
    
    NSString * model = [[UIDevice currentDevice] model];
    NSString* contentStr=[NSString stringWithFormat:@"启动时间:%@,机型:%@",[Utils stringFromDateWithFormat:[NSDate date] andFormatStr:@"yyyy-MM-dd HH:mm:ss"],model];
    [self.userLocationLogE logEvent:@"启动时" andContentStr:contentStr andTypeNum:1 andIsTerminate:NO];
    
    userDefaults=[NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"CurrentUserLocation"]!=nil) {
        
        NSDictionary* dict=[userDefaults objectForKey:@"CurrentUserLocation"];
        NSNumber* lat=[dict objectForKey:@"lat"];
        NSNumber* lon=[dict objectForKey:@"lon"];
        CLLocationCoordinate2D coord={[lat doubleValue],[lon doubleValue]};
        _someMinutesBeforeLocationCoordinate=coord;
        
        NSLog(@"first set value some Minutes Before Location Coordinate::%f,%f",_someMinutesBeforeLocationCoordinate.latitude,_someMinutesBeforeLocationCoordinate.longitude);
    };
    
    [self getCurrentUserLocation];
    
    return YES;
}

-(UserLocationLogEvent*)userLocationLogE{
    
    if (!_userLocationLogE) {
        _userLocationLogE=[UserLocationLogEvent sharedUserLocationLogEvent];
    };
    
    return _userLocationLogE;
    
}


#pragma mark- User Location  event

-(BOOL)isFirstUseJudge{
    
    BOOL isFirstUse;
    
    NSDictionary* sysconfig=[[NSBundle mainBundle] infoDictionary];
    NSString* version =[sysconfig objectForKey:@"CFBundleVersion"];
    
    NSUserDefaults* useconfig =[NSUserDefaults standardUserDefaults];
    NSString* oldversion=[useconfig objectForKey:@"CFBundleVersion"];
    
    if ([version isEqualToString:oldversion]) {
        NSLog(@"不是第一次使用");
        
        isFirstUse=NO;
        
    }else{
        NSLog(@"是第一次使用");
        [useconfig setObject:version forKey:@"CFBundleVersion"];
        [useconfig synchronize];
        isFirstUse=YES;
        
    };
    
    return isFirstUse;
    
}


-(void)locationServicesEnabledEvent{
    CLLocationManager * location = [[CLLocationManager alloc]init];
    location.pausesLocationUpdatesAutomatically = NO;
    if(![CLLocationManager locationServicesEnabled]){
        
        NSLog(@"请开启定位");
        NSString* str=@"请开启定位:设置 > 隐私 > 位置 > 定位服务 > 运势界";
        [self locationAlertEvent:str];
        
    }else{
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
            
            NSLog(@"定位失败，请开启定位");
            NSString* str=@"定位失败，请开启定位:设置 > 隐私 > 位置 > 定位服务 > 运势界";
            [self locationAlertEvent:str];
            
        }
    }
    
    
}


-(void)locationAlertEvent:(NSString*) str{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIAlertView* locationAlert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"现在去设置", nil];
        [locationAlert show];
        
    }else {
        
        UIAlertView* locationAlert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [locationAlert show];
        
    }
    
    
}

-(void)getCurrentUserLocation{
    
    if (![self isFirstUseJudge]) {
        [self locationServicesEnabledEvent];
    };
    
    self.LocationService=[[BMKLocationService alloc] init];
    self.LocationService.delegate=self;
    self.LocationService.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
    self.LocationService.distanceFilter=10;
    self.LocationService.pausesLocationUpdatesAutomatically=NO;
    self.LocationService.allowsBackgroundLocationUpdates=YES;
    [self.LocationService startUserLocationService];
}

-(void)AppLocationDistanceIntervalJudge{
    
    NSLog(@"someMinutesBeforeLocation::%f,%f",_someMinutesBeforeLocationCoordinate.latitude,_someMinutesBeforeLocationCoordinate.longitude);
    NSLog(@"CurrentUserLocationCoordinate::%f,%f",_currentUserLocationCoordinate.latitude,_currentUserLocationCoordinate.longitude);
    
    BMKMapPoint point1 = BMKMapPointForCoordinate(_someMinutesBeforeLocationCoordinate);
    BMKMapPoint point2 = BMKMapPointForCoordinate(_currentUserLocationCoordinate);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    NSLog(@"some Minutes Before Distanct:%f",distance);
    
    //    [self uploadCurrentUserLocation];
    
    if (distance >= 0) {
        [self uploadCurrentUserLocation];
        _isFirstUnderAppLocationDistanceInterval=YES;
        NSLog(@"大于 AppLocationDistanceInterval");
    }else{
        if (_isFirstUnderAppLocationDistanceInterval) {
            [self uploadCurrentUserLocation];
            NSLog(@"第一次小于 AppLocationDistanceInterval");
        }
        _isFirstUnderAppLocationDistanceInterval=NO;
        NSLog(@"少于 AppLocationDistanceInterval");
    };
    
    
}

int uploadCurrentLocationNumber=0;
-(void)uploadCurrentUserLocation{
        
    uploadCurrentLocationNumber++;
    
    NSString* latStr=[NSString stringWithFormat:@"%f",_currentUserLocationCoordinate.latitude];
    NSString* lonStr=[NSString stringWithFormat:@"%f",_currentUserLocationCoordinate.longitude];
    NSDictionary* params = @{
                                 @"billId":PhoneNumber,
                                 @"latitude":latStr,
                                 @"longitude":lonStr,
                                     
                             };
    
    NSInteger randomNum = arc4random();
    NSString* contentStr=[NSString stringWithFormat:@"上传时间:%@,坐标(纬度:%@,经度:%@),网络状态:%@,%@,GPS状态:%@,序列:%ld",[Utils stringFromDateWithFormat:[NSDate date] andFormatStr:@"yyyy-MM-dd HH:mm:ss"],latStr,lonStr,[Utils networkingStatesFromStatebar],[Utils networkingStatesFromReachability],[Utils locationServicesEnabledJudge],(long)randomNum];
    [self.userLocationLogE logEvent:@"开始上传" andContentStr:contentStr andTypeNum:3 andIsTerminate:NO];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        [BaseRequest requestWithInCode:@"40064" Parameters:params Block:^(NSDictionary *contentDict, NSString *message) {
            
            if ([message isEqualToString:@"SUCESS"]) {
                
                NSLog(@"上传位置成功:%@",message);
                uploadCurrentLocationNumber=0;
                _someMinutesBeforeLocationCoordinate=_currentUserLocationCoordinate;
                
            }else if (message == nil){
                NSLog(@"返回 message is nil");
            }else{
                NSLog(@"上传位置失败:%@",message);
                if (uploadCurrentLocationNumber <= 3) {
                    
                    [self uploadCurrentUserLocation];
                }else{
                    
                    uploadCurrentLocationNumber=0;
                    
                };
                
                
            };
            
            NSString* contentStr=[NSString stringWithFormat:@"响应时间:%@,响应状态:%@,序列:%ld",[Utils stringFromDateWithFormat:[NSDate date] andFormatStr:@"yyyy-MM-dd HH:mm:ss"],message,randomNum];
            [self.userLocationLogE logEvent:@"上传响应" andContentStr:contentStr andTypeNum:3 andIsTerminate:NO];
            
        }];
        
    });
    
}

-(void)BMKMetersBetweenMapPoints:(CLLocationCoordinate2D) lastUserLocationCoord :(CLLocationCoordinate2D) CurrentUserLocationCoord{
    BMKMapPoint point1 = BMKMapPointForCoordinate(lastUserLocationCoord);
    BMKMapPoint point2 = BMKMapPointForCoordinate(CurrentUserLocationCoord);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);
    NSLog(@"distanct:%f",distance);
    
    
    if (distance >= 30 || [self.currentUserAddressStr isEqualToString:@""]) {
        
        [self reverseGeoCodeSearch];
        
    }
}


#pragma mark- ReverseGeoCode

-(void)reverseGeoCodeSearch{
    
//    if (_searcher == nil) {
//        _searcher=[[BMKGeoCodeSearch alloc] init];
//    };
//    
//    _searcher.delegate=self;
//    BMKReverseGeoCodeOption* option=[[BMKReverseGeoCodeOption alloc] init];
//    option.reverseGeoPoint=_currentUserLocationCoordinate;
//    BOOL flag=[_searcher reverseGeoCode:option];
//    if(flag){
//        NSLog(@"反geo检索发送成功");
//    }else{
//        NSLog(@"反geo检索发送失败");
//    }
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    NSLog(@"%@%@%@%@%@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber);
    
    self.currentUserAddressStr=[NSString stringWithFormat:@"%@-%@-%@-%@%@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber];
    [userDefaults setObject:self.currentUserAddressStr forKey:@"currentUserAddressStr"];
    [userDefaults synchronize];
    
}


#pragma mark- background Run event

int backgroundRunNumber=0;

-(void)backgroundRun{
    
    backgroundRunNumber++;
    
    if (_isEnterBackground) {
        
//        NSTimeInterval interval=[[UIApplication sharedApplication] backgroundTimeRemaining];
        NSLog(@"-----后台执行任务--[%d]-----",backgroundRunNumber);
        
        int num=170/ScheduledTimerWithTimeInterval;
        if(backgroundRunNumber % num == 0 ){
            
            NSLog(@"-----backgroundRunNumber1 == %d-----",num);
            if (_LocationService == nil) {
                NSLog(@"getCurrentUserLocation");
                [self getCurrentUserLocation];
            }
            UIApplication* app = [UIApplication sharedApplication];
            BackgroundTaskId = [app beginBackgroundTaskWithExpirationHandler:^{
                [app endBackgroundTask: BackgroundTaskId];
            }];
        }
        
    }else{
       
        NSLog(@"-----前台执行任务--[%d]-------",backgroundRunNumber);
    };

    
    int num2=120/ScheduledTimerWithTimeInterval;
    if (backgroundRunNumber % num2 == 0 ) {
        
        NSLog(@"-----backgroundRunNumber2 == %d-----",num2);
        [self AppLocationDistanceIntervalJudge];
    };
    
}


-(void)DidEnterBackgroundEvent{
    
    NSLog(@"--*******--进入后台了----*****---");
    UIApplication* app = [UIApplication sharedApplication];
    BackgroundTaskId = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask: BackgroundTaskId];
    }];
    
}


#pragma mark- BMKLocationServiceDelegate

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    
    CLLocationCoordinate2D lastUserLocationCoordinate={0,0};
    
    NSLog(@"didLocation:%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    if ([userDefaults objectForKey:@"CurrentUserLocation"]!=nil) {
        NSDictionary* dict=[userDefaults objectForKey:@"CurrentUserLocation"];
        NSNumber* lat=[dict objectForKey:@"lat"];
        NSNumber* lon=[dict objectForKey:@"lon"];
        CLLocationCoordinate2D coord={[lat doubleValue],[lon doubleValue]};
        lastUserLocationCoordinate=coord;
    };
    
    _currentUserLocationCoordinate=userLocation.location.coordinate;
    
    double lat=_currentUserLocationCoordinate.latitude;
    double lon=_currentUserLocationCoordinate.longitude;
    NSNumber *lag2=[NSNumber numberWithDouble:lat];
    NSNumber *lon2=[NSNumber numberWithDouble:lon];
    NSDictionary* CurrentUserLocationDict=@{@"lat":lag2,@"lon":lon2,};
    [userDefaults setObject:CurrentUserLocationDict forKey:@"CurrentUserLocation"];
    [userDefaults synchronize];
    
    [self BMKMetersBetweenMapPoints:lastUserLocationCoordinate :_currentUserLocationCoordinate];

    [self AppLocationDistanceIntervalJudge];
    
    NSString* contentStr=[NSString stringWithFormat:@"更新时间:%@,坐标(纬度:%@,经度:%@)",[Utils stringFromDateWithFormat:[NSDate date] andFormatStr:@"yyyy-MM-dd HH:mm:ss"],lag2,lon2];
    [self.userLocationLogE logEvent:@"百度位置更新" andContentStr:contentStr andTypeNum:2 andIsTerminate:NO];
}


#pragma mark- UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    
}


#pragma mark- other event

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

    self.isEnterBackground=YES;
    [self DidEnterBackgroundEvent];
    
    NSString* contentStr=[NSString stringWithFormat:@"进入时间:%@",[Utils stringFromDateWithFormat:[NSDate date] andFormatStr:@"yyyy-MM-dd HH:mm:ss"]];
    [self.userLocationLogE logEvent:@"进入后台" andContentStr:contentStr andTypeNum:1 andIsTerminate:NO];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    self.isEnterBackground=NO;
    NSLog(@"--*******--进入前台了----*****---");
    
    NSString* contentStr=[NSString stringWithFormat:@"进入时间:%@",[Utils stringFromDateWithFormat:[NSDate date] andFormatStr:@"yyyy-MM-dd HH:mm:ss"]];
    [self.userLocationLogE logEvent:@"进入前台" andContentStr:contentStr andTypeNum:1 andIsTerminate:NO];
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {

    NSString* contentStr=[NSString stringWithFormat:@"关闭时间:%@",[Utils stringFromDateWithFormat:[NSDate date] andFormatStr:@"yyyy-MM-dd HH:mm:ss"]];
    [self.userLocationLogE logEvent:@"杀死进程" andContentStr:contentStr andTypeNum:1 andIsTerminate:YES];
    
}


@end
