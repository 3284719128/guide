//
//  Common.h
//  locationDemo
//
//  Created by 43696467 on 15/1/22.
//  Copyright (c) 2015年 team1. All rights reserved.
//

#ifndef locationDemo_Common_h
#define locationDemo_Common_h


//#define WebPageURL      @"http://192.168.1.250:90/intf"        //测试环境
//#define WebPageURL      @"http://lyh.wo56.com/intf"       //生产环境
//#define WebPageURL  @"http://www.wo56.com/intf"
//#define WebPageURL  @"http://192.168.1.138:8080/wlpt/intf"
#define WebPageURL  @"http://zhwl.wo56.com/intf"

#define PhoneNumber @"13450214868"
#define TOKENID @"jrqxsDQL81KeMtL1TTE11aUn045sH6eY"
#define APP_ID  @"APP"
#define Version @"1.0.5"
#define SAFE_KEY  @"tHwaddPVPkOkaCYxYquGX2JaULAqQ5av"

#define UID @"15017821401013"

//应用程序主色调 配置 
#define MAIN_COLOR UIColorFromRGB(0xFFFFFF)

#define mainColor 0xFFFFFF


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ColorWithRGB(r,g,b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

#define alphaColor(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define FrameHeight(viewObject) viewObject.frame.origin.y+viewObject.frame.size.height
#define FrameWidth(viewObject) viewObject.frame.origin.x+viewObject.frame.size.width

#define NoMessage       1
#define WebDisConnect   2

#define LINECOLOR 0xE2E2E2
#define LINEHEIGHT 0.5

#define IntervalUserLocationUpdate 30.0
#define IntervalCurrentMapCentreLocationUpdate 30

#define IntervalUpdateUserLocationWhenGetNotification 180

#define CountRequest 10
#define DefaultTotalNum 100

#define DefaultLatitude 23.1698443916343
#define DefaultLongitude 113.45798909711601
#define DefaultCityName @"广州市"
#define DefaultAddress @"广东省-广州市-萝岗区-科学大道162号创意大厦B3栋"

#define RefreshTableFooterViewHEIGHT 80


#define MapViewRegionDidChange @"MapViewRegionDidChange"
#define MapViewOnClickedMapBlank @"MapViewOnClickedMapBlank"
#define UpdateUserLocationNotification @"UpdateBMKUserLocation"
#define whenDidReceiveRemoteNotification @"whenDidReceiveRemoteNotification"
#define inFrontDidReceiveRemoteNotification @"inFrontDidReceiveRemoteNotification"
#define didSelectAnnotationViewWhenPoi @"didSelectAnnotationView"
#define didSelectAnnotationViewWhenPoi2 @"didSelectAnnotationView2"
#define EvaluationFirstViewNotification @"EvaluationFirstViewNotification"
#define savePublishGoodsDataToUserDefaultsNotification @"savePublishGoodsDataToUserDefaultsNotification"
#define saveAddCarDataToUserDefaultsNotification @"saveAddCarDataToUserDefaultsNotification"
#define setRedDotHiddenNotification @"setRedDotHiddenNotification"
#define CloseLenovoPullDownListViewNotification @"CloseLenovoPullDownListViewNotification"
#define RefreshNewsListTableHeaderNotification @"RefreshNewsListTableHeaderNotification"

#define GetNewsDataNotification @"GetNewsDataNotification"

#define NotificationKeyword @"keyword"

#define TableFooterRefreshHintStringWhenNotMoreData @"没有更多的数据了!"

#define NavigationBarHeight 70.0

#define CloseKeyWindow [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

#define ScheduledTimerWithTimeInterval 10

#define BulletViewAlpha 0.5

#define EnterFrontWithFewSeconds 3

#define largestCubicNum 200  //最大车辆方数

#define kTransitionDuration 0.3f


//UIlabel线条通用线条
#define CREATELineWithScreenWidth(object,wak,superView)\
UIView* object=[[UILabel alloc] initWithFrame:CGRectMake(0, wak, ScreenWidth, LINEHEIGHT)];\
[object setBackgroundColor:UIColorFromRGB(LINECOLOR)];\
[superView addSubview:object];

//导航栏加收键盘事件
#define CREATENavBarWithCloseKeyWindow(_navBarView,CloseKeyWindowSelector) UIControl *cont=[[UIControl alloc] init];\
cont.frame=_navBarView.bounds;\
[cont addTarget:self action:CloseKeyWindowSelector forControlEvents:UIControlEventTouchUpInside];\
[_navBarView addSubview:cont];\
[_navBarView sendSubviewToBack:cont];

//按钮带Title
#define CREATEButtonWithTtile(btnObject,btnFrame,btnTitle,fontSize,tintColor,addSuperView)\
UIButton *btnObject = [UIButton buttonWithType:UIButtonTypeSystem];\
[btnObject setFrame:btnFrame];\
[btnObject setTitle:btnTitle forState:UIControlStateNormal];\
[btnObject setTitleColor:tintColor forState:UIControlStateNormal];\
[btnObject.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];\
[addSuperView addSubview:btnObject];

//按钮带Image
#define CREATEButtonWithImage(btnObject,btnFrame,btnImage,addSuperView)\
UIButton *btnObject = [UIButton buttonWithType:UIButtonTypeCustom];\
[btnObject setFrame:btnFrame];\
[btnObject setImage:btnImage forState:UIControlStateNormal];\
[addSuperView addSubview:btnObject];

//空按钮
#define CREATEButtonWithEmpty(btnObject,btnFrame,addSuperView)\
UIButton *btnObject = [UIButton buttonWithType:UIButtonTypeSystem];\
[btnObject setFrame:btnFrame];\
[addSuperView addSubview:btnObject];

//UIImageView
#define CREATEImageView(imageViewObject,viewFrame,UIImage,addSuperView)\
UIImageView* imageViewObject=[[UIImageView alloc] initWithImage:UIImage];\
[imageViewObject setFrame:viewFrame];\
[addSuperView addSubview:imageViewObject];

//UILabel
#define CREATELabel(LabelObject,LabelFrame,Text,fontSize,textAlignments,addSuperView)\
UILabel* LabelObject=[[UILabel alloc] initWithFrame:LabelFrame];\
LabelObject.text=Text;\
LabelObject.font=[UIFont systemFontOfSize:fontSize];\
LabelObject.textAlignment=textAlignments;\
[addSuperView addSubview:LabelObject];


//通用横线条
#define CREATE_WLINE_VIEW_ADD_SUPERVIEW(x,y,w,color,superView)\
{UIView *lineView = [UIView new];\
[lineView setFrame:CGRectMake(x, y, w, LINEHEIGHT)];\
[lineView setBackgroundColor:color];\
[superView addSubview:lineView];}


//@"http://121.199.65.29/intf" @"http://itunes.apple.com/lookup?id=你程序的appId"
#define APP_URL @"http://itunes.apple.com/lookup?id=967898228"

#define RETURNUID (myInfomation != nil?GETAPPDELEGATE.myUserInfomation.uid:@"")

#define popToRootViewController [self.navigationController popToRootViewControllerAnimated:YES];

#define popViewController [self.navigationController popViewControllerAnimated:YES];

#define pushController(Controller) [self.navigationController pushViewController:Controller animated:YES];


#define GetUserDefaults ((NSUserDefaults *)[NSUserDefaults standardUserDefaults])

#define GetAppDelagate  ((AppDelegate *)[[UIApplication sharedApplication]delegate])


#endif





