//
//  ToChooseTime.m
//  LogisticsHousekeeper
//
//  Created by AIR on 16/8/15.
//  Copyright © 2016年 ZengXingTechnology. All rights reserved.
//

#import "ToChooseTime.h"

@implementation ToChooseTime

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor=[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5];
        [self addSubview:[self TimeToChooseinterface]];
       
        
    }
    return self;
}





-(UIView *)TimeToChooseinterface{
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-230, ScreenWidth, 230)];
    view.backgroundColor=[UIColor whiteColor];
    
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    view1.backgroundColor=Color_f5f5f5;
    [view addSubview:view1];
    
    self.label=[[UILabel alloc] initWithFrame:CGRectMake(65, 0, ScreenWidth-130, 40)];
    self.label.text=@"时间选择";
    self.label.textAlignment=NSTextAlignmentCenter;
    self.label.textColor=Color_555555;
    self.label.font=UIFont_30;
    [view1 addSubview:self.label];
    
    UIButton *button=[Controls ButtonWithFrame:CGRectMake(5, 5, 60, 30) WithTitle:@"取消" WithFont:UIFont_28];
    [button addTarget:self action:@selector(cancelButton:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 3;
    button.layer.masksToBounds = YES;
    button.backgroundColor=Color_cccccc;
    [view1 addSubview:button];
    
    
    UIButton *button1=[Controls ButtonWithFrame:CGRectMake(ScreenWidth-65, 5, 60, 30) WithTitle:@"确定" WithFont:UIFont_28];
    [button1 addTarget:self action:@selector(determineButton:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button1.layer.cornerRadius = 3;
    button1.layer.masksToBounds = YES;
    button1.backgroundColor=Color_ff7e00;
    [view1 addSubview:button1];
    
    
    
    self.pickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(10, view.frame.size.height-200, ScreenWidth, 200)];
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    [view addSubview:self.pickerView];
    
    _nameArray =[[NSMutableArray alloc] init];
    _yearArray=[[NSMutableArray alloc] init];
    for (int i=90; i>=0; i--) {
        NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
        
        NSString* dateStr=  [Utils intFromDate:[Utils stringFromDate:[NSDate date]]];
        long int sumer=[dateStr longLongValue]-86400*i;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:sumer];
        
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit |
        NSMonthCalendarUnit |
        NSDayCalendarUnit |
        NSWeekdayCalendarUnit |
        NSHourCalendarUnit |
        NSMinuteCalendarUnit |
        NSSecondCalendarUnit;
        comps = [calendar components:unitFlags fromDate:date];
        NSInteger week = [comps weekday];
        NSInteger year=[comps year];
        NSInteger month = [comps month];
        NSInteger day = [comps day];
        NSString *string=[NSString stringWithFormat:@"%ld月%ld日 %@",month,day,[arrWeek objectAtIndex:week-1]];
        [_nameArray addObject:string];
        [_yearArray addObject:[NSString stringWithFormat:@"%ld",year]];
    }
    
    _titleArray=[NSArray arrayWithObjects:@"上午",@"下午",@"晚上", nil];
    
  
    [self.pickerView selectRow:_nameArray.count-1 inComponent:0 animated:NO];
    [self.pickerView reloadAllComponents];
    return view;
    
    
}


-(void)cancelButton:(UIButton *)sender
{
    [self contorLcic];
}

#pragma mark - 当点击确定
-(void)determineButton:(UIButton *)sender
{
    if (self.TheDateOf.length==0) {
        [self stringWith:_nameArray.count-1];
    }
//    if (self.PointInTime.length==0) {
//        self.PointInTime=[[NSMutableString alloc] initWithString:@"上午"];
//    }
    [self.delegate TimeToChooseDelegateButton:self.TheDateOf];
    [self contorLcic];
}

//返回列
-(NSInteger )numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//返回行
-(NSInteger )pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
//    if(component==0){
        return  _nameArray.count;
        
//    }else{
//        return  _titleArray.count;
//    }
    
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
//    if (component ==0) {
        return ScreenWidth;
//    }else{
//        return 100;
//    }
}
//
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    if (!view) {
        view=[[UIView alloc] init];
    }
//    if (component==0) {
        UILabel *text=[Controls LabelWithFiame:CGRectMake(0, 0, ScreenWidth, 20) WithText:[_nameArray objectAtIndex:row] WithtextColor:Color_333333 WithFont:UIFont_30];
        [view addSubview:text];
//    }else{
//        UILabel *text=[Controls LabelWithFiame:CGRectMake(0, 0, 100, 20) WithText:[_titleArray objectAtIndex:row] WithtextColor:Color_333333 WithFont:UIFont_30];
//        [view addSubview:text];
//    }
    
    
    return view;
}
//
//
//显示的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //    NSString *str=[_nameArray objectAtIndex:row];
//    if (component==0) {
        return [_nameArray objectAtIndex:row];
//    }else{
//        return [_titleArray objectAtIndex:row];
//    }
    
}
//字体大小颜色
-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str;
//    if (component==0) {
        str=[_nameArray objectAtIndex:row];
//    }else{
//        str=[_titleArray objectAtIndex:row];
//    }
    
    NSMutableAttributedString *AttributedString=[[NSMutableAttributedString alloc] initWithString:str];
    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:10],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, [AttributedString length])];
    
    return AttributedString;
}
//
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
//    if (component==0) {
        [self stringWith:row];
        NSLog(@"HANG%@",[_nameArray objectAtIndex:row]);
//        
//    }else{
//        self.PointInTime=[[NSMutableString alloc] initWithString:[_titleArray objectAtIndex:row]];
//        NSLog(@"HTILL%@",[_titleArray objectAtIndex:row]);
//    }
    
    
}

-(void)stringWith:(NSInteger )row
{
    self.TheDateOf=[[NSMutableString alloc] init];
    NSArray *array=[[_nameArray objectAtIndex:row] componentsSeparatedByString:@"月"];
    [self.TheDateOf appendString:[_yearArray objectAtIndex:row]];
    [self.TheDateOf appendString:@"-"];
    NSInteger sum =[[array objectAtIndex:0] intValue];
    if (sum>=10) {
        [self.TheDateOf appendFormat:@"%ld",sum];
    }else{
        [self.TheDateOf appendFormat:@"0%ld",sum];
    }
    [self.TheDateOf appendString:@"-"];
    
    NSArray *aray1=[[array objectAtIndex:1] componentsSeparatedByString:@"日"];
    NSInteger sum1=[[aray1 objectAtIndex:0] intValue];
    if (sum1>=10) {
        [self.TheDateOf appendFormat:@"%ld",sum1];
    }else{
        [self.TheDateOf appendFormat:@"%0ld",sum1];
    }
    NSLog(@"%@",self.TheDateOf);
    self.label.text=[NSString stringWithFormat:@"%@年%@",[_yearArray objectAtIndex:row],[_nameArray objectAtIndex:row]];
    
}
-(void)contorLcic

{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
