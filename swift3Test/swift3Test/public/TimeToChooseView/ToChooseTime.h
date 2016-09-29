//
//  ToChooseTime.h
//  LogisticsHousekeeper
//
//  Created by AIR on 16/8/15.
//  Copyright © 2016年 ZengXingTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TimeToChooseDelegate <NSObject>

//当点击确定时
-(void)TimeToChooseDelegateButton:(NSString *)TypeButton;

@end

@interface ToChooseTime : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSMutableArray *_nameArray;     //当前月份
    NSMutableArray *_yearArray;     //当前年份
    NSArray *_titleArray;
}

@property(strong,nonatomic)UIPickerView *pickerView;
- (id)initWithFrame:(CGRect)frame;
@property(nonatomic,weak)id <TimeToChooseDelegate>delegate;

@property(nonatomic,strong)NSMutableString *TheDateOf;           //年月日
@property(nonatomic,strong)NSMutableString *PointInTime;         //上午，中午，晚上

@property(nonatomic,retain)UILabel *label;


@end
