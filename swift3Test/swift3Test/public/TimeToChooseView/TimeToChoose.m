//
//  TimeToChoose.m
//  WOFurniture
//
//  Created by AIR on 16/8/5.
//  Copyright © 2016年 ZengXingTechnology. All rights reserved.
//

#import "TimeToChoose.h"

@implementation TimeToChoose


static TimeToChoose* timeToChoose=nil;

+(id)sharedTimeToChooseWithFrame:(CGRect)frame :(NSString*) titleStr{
    
    if (timeToChoose == nil) {
        timeToChoose=[[TimeToChoose alloc] initWithFrame:frame];
        [timeToChoose drawView];
    };
    
    if (timeToChoose) {
        [timeToChoose initPropertyValue:titleStr];
    };
    
    return timeToChoose;
    
}


#pragma mark- draw view event
         
-(void)drawView{
    
    [self setBackgroundColor:alphaColor(0x000000, BulletViewAlpha)];
         
    viewBG=[[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 230)];
    viewBG.backgroundColor=[UIColor whiteColor];
    [self addSubview:viewBG];
    
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    view1.backgroundColor=UIColorFromRGB(0xf6f6f6);
    [viewBG addSubview:view1];
    
    self.label=[[UILabel alloc] initWithFrame:CGRectMake(65, 0, ScreenWidth-130, 40)];
    self.label.text=@"";
    self.label.textAlignment=NSTextAlignmentCenter;
    self.label.textColor=UIColorFromRGB(0x515151);
    self.label.font=UIFont_30;
    [view1 addSubview:self.label];
    
    UIButton *button=[Controls ButtonWithFrame:CGRectMake(5, 5, 60, 30) WithTitle:@"取消" WithFont:UIFont_28];
    [button addTarget:self action:@selector(cancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = TheRoundedAmplitude;
    button.layer.masksToBounds = YES;
    button.backgroundColor=UIColorFromRGB(0xcccccc);
    [view1 addSubview:button];
    
    
    UIButton *button1=[Controls ButtonWithFrame:CGRectMake(ScreenWidth-65, 5, 60, 30) WithTitle:@"确定" WithFont:UIFont_28];
    [button1 addTarget:self action:@selector(determineButton:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.layer.cornerRadius = TheRoundedAmplitude;
    button1.layer.masksToBounds = YES;
    button1.backgroundColor=ColorWithRGB(94, 125, 176);
    [view1 addSubview:button1];
    
    self.pickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(10, viewBG.frame.size.height-200, ScreenWidth, 200)];
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    [viewBG addSubview:self.pickerView];
    
    nameArray =[[NSMutableArray alloc] init];
    yearArray=[[NSMutableArray alloc] init];
    titleArray=[NSArray arrayWithObjects:@"上午",@"下午",@"晚上", nil];
    


}

-(void)initPropertyValue:(NSString*) titleStr{
    
    [nameArray removeAllObjects];
    [yearArray removeAllObjects];
    
    for (int i=0; i<7; i++) {
        NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:86400*i];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |
        NSCalendarUnitDay |
        NSCalendarUnitWeekday |
        NSCalendarUnitHour |
        NSCalendarUnitMinute |
        NSCalendarUnitSecond;
        comps = [calendar components:unitFlags fromDate:date];
        NSInteger week = [comps weekday];
        NSInteger year=[comps year];
        NSInteger month = [comps month];
        NSInteger day = [comps day];
        NSString *string=[NSString stringWithFormat:@"%d月%d日 %@",month,day,[arrWeek objectAtIndex:week-1]];
        [nameArray addObject:string];
        [yearArray addObject:[NSString stringWithFormat:@"%d",year]];
        
    };
    
    [self.pickerView reloadAllComponents];
    
    NSString* newTitleStr=[titleStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.label.text=newTitleStr;
    NSArray* strArray=[newTitleStr componentsSeparatedByString:@" "];
    
    for (int i=0;i<nameArray.count;i++) {
        
        NSString* str=nameArray[i];
        NSString* dateStr=[NSString stringWithFormat:@"%@ %@",strArray[0],strArray[1]];
        if ([str isEqualToString:dateStr]) {
            [self.pickerView selectRow:i inComponent:0 animated:YES];
            self.TheYear=[yearArray objectAtIndex:i];
            self.TheDateOf=[nameArray objectAtIndex:i];
            break;
        };
    };
    
    for (int i=0;i<titleArray.count;i++) {
        NSString* str=titleArray[i];
        if ([str isEqualToString:strArray[2]]) {
            [self.pickerView selectRow:i inComponent:1 animated:YES];
            self.PointInTime=[titleArray objectAtIndex:i];
            break;
        };
    };
    
}


#pragma mark- UIPickerViewDelegate event

//返回列
-(NSInteger )numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

//返回行
-(NSInteger )pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   
     if(component==0){
      return nameArray.count;
      
    }else{
    return titleArray.count;
    }
   
}
//
////行高
-(CGFloat )pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}
//
-(CGFloat )pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component ==0) {
        return ScreenWidth-100;
    }else{
        return 100;
    }
}
//
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    if (!view) {
        view=[[UIView alloc] init];
    };
    if (component==0) {
        UILabel *text=[Controls LabelWithFiame:CGRectMake(0, 0, ScreenWidth-100, 20) WithText:[nameArray objectAtIndex:row] WithtextColor:Color_333333 WithFont:UIFont_30];
        [view addSubview:text];
    }else{
        UILabel *text=[Controls LabelWithFiame:CGRectMake(0, 0, 100, 20) WithText:[titleArray objectAtIndex:row] WithtextColor:Color_333333 WithFont:UIFont_30];
        [view addSubview:text];
    };
    
    return view;
}

//显示的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0) {
        return [nameArray objectAtIndex:row];
    }else{
        return [titleArray objectAtIndex:row];
    };
    
}
//字体大小颜色
-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str;
    if (component==0) {
        str=[nameArray objectAtIndex:row];
    }else{
        str=[titleArray objectAtIndex:row];
    };
   
    NSMutableAttributedString *AttributedString=[[NSMutableAttributedString alloc] initWithString:str];
    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, [AttributedString length])];
    
    return AttributedString;
}
//
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.TheYear=[yearArray objectAtIndex:row];
        self.TheDateOf=[nameArray objectAtIndex:row];
    }else{
        self.PointInTime=[titleArray objectAtIndex:row];
    };
    
    self.label.text=[NSString stringWithFormat:@"%@ %@",self.TheDateOf,self.PointInTime];

}

#pragma mark - 按钮事件

-(void)cancelButton:(UIButton *)sender
{
    [self dismissView];
}


-(void)determineButton:(UIButton *)sender
{
    NSString* yyTime=[self getString];
    if (self.subBlock) {
        self.subBlock(yyTime,self.TheDateOf,self.PointInTime);
    };
    [self dismissView];
}


-(NSString*)getString{
    
    NSMutableString* str=[[NSMutableString alloc] init];
    NSArray *array=[self.TheDateOf componentsSeparatedByString:@"月"];
    [str appendString:self.TheYear];
    [str appendString:@"-"];
    NSInteger sum =[[array objectAtIndex:0] intValue];
    if (sum>=10) {
        [str appendFormat:@"%d",sum];
    }else{
        [str appendFormat:@"0%d",sum];
    };
    [str appendString:@"-"];
    
    NSArray *aray1=[[array objectAtIndex:1] componentsSeparatedByString:@"日"];
    NSInteger sum1=[[aray1 objectAtIndex:0] intValue];
    if (sum1>=10) {
        [str appendFormat:@"%d",sum1];
    }else{
        [str appendFormat:@"0%d",sum1];
    };
    
    return str;
    
}


#pragma mark- show and dismiss event


-(void)showWithView:(UIView*) superView andBlock:(void (^)(NSString* yyTime,NSString* date,NSString* ipFixTime)) block{
    
    self.subBlock=block;
    [superView addSubview:self];
    self.alpha=0;
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha=1;
        [viewBG setFrame:CGRectMake(0, ScreenHeight-230, ScreenWidth, 230)];
        
    } completion:^(BOOL finished) {

    }];
    
}


-(void)dismissView{

    [UIView animateWithDuration:0.3 animations:^{
        
        [viewBG setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 230)];
        self.alpha=0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


+(NSDictionary*)getCurrentDate{
    
    NSArray * arrWeek=[NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:[NSDate date]];
    NSInteger week = [comps weekday];
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour=[comps hour];
    
    NSString* hourSrt=@"晚上";
    if (hour >= 6 && hour <= 12) {
        hourSrt=@"上午";
    }else if (hour > 12 && hour <= 18){
        hourSrt=@"下午";
    };
    
    NSString* showStr=[NSString stringWithFormat:@"%ld月%ld日 %@ %@",month,day,[arrWeek objectAtIndex:week-1],hourSrt];
    
    NSMutableString* yyTime=[[NSMutableString alloc] init];
    [yyTime appendString:[NSString stringWithFormat:@"%ld",year]];
    [yyTime appendString:@"-"];
    if (month>=10) {
        [yyTime appendFormat:@"%ld",month];
    }else{
        [yyTime appendFormat:@"0%ld",month];
    };
    [yyTime appendString:@"-"];
    
    if (day>=10) {
        [yyTime appendFormat:@"%ld",day];
    }else{
        [yyTime appendFormat:@"0%ld",day];
    };
    
    NSDictionary* dict=@{
                         
                         @"showStr":showStr,
                         @"yyTime":yyTime,
                         @"ipFixTime":hourSrt,
                         
                         };
    
    return dict;
    
}


@end
