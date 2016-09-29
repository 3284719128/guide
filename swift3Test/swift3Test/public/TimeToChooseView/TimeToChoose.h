//
//  TimeToChoose.h
//  WOFurniture
//
//  Created by AIR on 16/8/5.
//  Copyright © 2016年 ZengXingTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TimeToChoose : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    UIView* viewBG;
    
    NSMutableArray* yearArray; //当前年份
    NSMutableArray* nameArray; //当前月份
    NSArray* titleArray; //上午，中午，晚上
}

@property (nonatomic,retain) UIPickerView* pickerView;

@property (nonatomic,copy) NSString* TheYear; //年
@property (nonatomic,copy) NSString* TheDateOf; //月日周
@property (nonatomic,copy) NSString* PointInTime; //上午，中午，晚上

@property (nonatomic,retain) UILabel* label;

@property (nonatomic,copy) void (^subBlock)(NSString* yyTime,NSString* date,NSString* ipFixTime);

+(id)sharedTimeToChooseWithFrame:(CGRect)frame :(NSString*) titleStr;
-(void)showWithView:(UIView*) superView andBlock:(void (^)(NSString* yyTime,NSString* date,NSString* ipFixTime)) block;


+(NSDictionary*)getCurrentDate;


@end




