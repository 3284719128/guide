//
//  DeliveryNoticeViewController.m
//  LogisticsHousekeeper
//
//  Created by 43696467 on 16/8/8.
//  Copyright © 2016年 ZengXingTechnology. All rights reserved.
//

#import "DeliveryNoticeViewController.h"

#import "DeliveryNoticeView.h"

#import "ReadSystemAddressBookEvent.h"
#import "TimeToChoose.h"

#import "JHLineChart.h"


@interface DeliveryNoticeViewController ()
{
    DeliveryNoticeView* deliveryNoticeV;
}


@property (nonatomic,copy) NSString* yyTime;
@property (nonatomic,copy) NSString* ipFixTime;


@end

@implementation DeliveryNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawView];
    
//    [self showFirstQuardrant];
    
}


- (void)showFirstQuardrant{
    /*        创建表对象         */
    JHLineChart *lineChart = [[JHLineChart alloc] initWithFrame:CGRectMake(10, 100, ScreenWidth-20, 300) andLineChartType:JHChartLineValueNotForEveryX];
    /* X轴的刻度值 可以传入NSString或NSNumber类型  并且数据结构随折线图类型变化而变化 详情看文档或其他象限X轴数据源示例*/
    lineChart.xLineDataArr = @[@"0",@"1",@"2",@3,@4,@5,@6,@7];
    /* 折线图的不同类型  按照象限划分 不同象限对应不同X轴刻度数据源和不同的值数据源 */
    lineChart.lineChartQuadrantType = JHLineChartQuadrantTypeFirstQuardrant;
    /* 数据源 */
    lineChart.valueArr = @[@[@"1",@"12",@"1",@6,@4,@9,@6,@7],@[@"3",@"1",@"2",@16,@2,@3,@5,@10]];
    /* 值折线的折线颜色 默认暗黑色*/
    lineChart.valueLineColorArr =@[ [UIColor purpleColor], [UIColor brownColor]];
    /* 值点的颜色 默认橘黄色*/
    lineChart.pointColorArr = @[[UIColor orangeColor],[UIColor yellowColor]];
    /* X和Y轴的颜色 默认暗黑色 */
    lineChart.xAndYLineColor = [UIColor blackColor];
    /* XY轴的刻度颜色 m */
    lineChart.xAndYNumberColor = [UIColor blueColor];
    /* 坐标点的虚线颜色 */
    lineChart.positionLineColorArr = @[[UIColor blueColor],[UIColor greenColor]];
//    /*        设置是否填充内容 默认为否         */
//    lineChart.contentFill = YES;
//    /*        设置为曲线路径         */
//    lineChart.pathCurve = YES;
//    
//    /*        设置填充颜色数组         */
//    lineChart.contentFillColorArr = @[[UIColor colorWithRed:0.500 green:0.000 blue:0.500 alpha:0.468],[UIColor colorWithRed:0.500 green:0.214 blue:0.098 alpha:0.468]];
    [self.view addSubview:lineChart];
    /*        开始动画         */
    [lineChart showAnimation];
}



#pragma mark- draw view event

-(void)drawView{
    
    self.titleLabel.text=@"提货通知";
    
    deliveryNoticeV=[[DeliveryNoticeView alloc] initWithFrame:CGRectMake(0, NavigationBarHeight, ScreenWidth, ScreenHeight-NavigationBarHeight-50)];
    [self.view addSubview:deliveryNoticeV];
    [deliveryNoticeV.manButton addTarget:self action:@selector(selectLinkmanButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [deliveryNoticeV.timeButton addTarget:self action:@selector(selectTimeButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary* resultDict=[TimeToChoose getCurrentDate];
    [deliveryNoticeV setDateValue:[resultDict objectForKeyWithoutNull:@"showStr"]];
    self.yyTime=[resultDict objectForKeyWithoutNull:@"yyTime"];
    self.ipFixTime=[resultDict objectForKeyWithoutNull:@"ipFixTime"];
    
    CREATEButtonWithTtile(deliveryNoticeButton, CGRectMake(15, ScreenHeight-50, ScreenWidth-30, 40), @"通知提货", 18, [UIColor whiteColor], self.view);
    [deliveryNoticeButton addTarget:self action:@selector(deliveryNoticeButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [deliveryNoticeButton setBackgroundColor:ColorWithRGB(94, 125, 176)];
    deliveryNoticeButton.layer.cornerRadius=TheRoundedAmplitude;
    deliveryNoticeButton.layer.masksToBounds=YES;
    
}



#pragma mark- DeliveryNoticeView sub button action event

-(void)selectLinkmanButtonEvent:(UIButton*) sender{
    
    ReadSystemAddressBookEvent* readSystemAddressBookE=[ReadSystemAddressBookEvent sharedReadSystemAddressBookEvent];
    [readSystemAddressBookE ReadSystemAddressBook:self andSubBlock:^(NSString *name, NSString *phone) {
        
        deliveryNoticeV.manField.text=name;
        deliveryNoticeV.phoneField.text=phone;
    }];
    
}


-(void)selectTimeButtonEvent:(UIButton*) sender{
    
    TimeToChoose* timeto=[TimeToChoose sharedTimeToChooseWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) :deliveryNoticeV.timeLabel.text];
    [timeto showWithView:self.view andBlock:^(NSString* yyTime,NSString* date,NSString* ipFixTime){
        
        deliveryNoticeV.timeLabel.text=[NSString stringWithFormat:@"   %@ %@",date,ipFixTime];
        self.yyTime=yyTime;
        self.ipFixTime=ipFixTime;
        
    }];
    
}


#pragma mark- deliveryNotice Button Event

-(void)deliveryNoticeButtonEvent:(UIButton*) sender{
    
    if ([self paramsJudge]) {
        [self uploadNetworkData];
    };
    
}

-(void)uploadNetworkData{
    
    NSDictionary* dict=[self getParams];
    
    NSLog(@"paramsDict:%@",dict);
    
    popViewController;
    
}


-(NSDictionary*)getParams{
    
    NSString* periodType=@"3";
    if ([self.ipFixTime isEqualToString:@"上午"]) {
        periodType=@"1";
    }else if ([self.ipFixTime isEqualToString:@"下午"]){
        periodType=@"2";
    };
    
    NSDictionary* Params=@{
                           
                           @"gcount" : deliveryNoticeV.packagesNumField.text,
                           @"stere" : deliveryNoticeV.squareNumField.text,
                           @"weight" : deliveryNoticeV.weightField.text,
                           
                           @"pickupAddress" : deliveryNoticeV.addressField.text,
                           @"pickupMan" : deliveryNoticeV.manField.text,
                           @"pickupTel" : deliveryNoticeV.phoneField.text,
                           
                           @"pickupDate" : self.yyTime,
                           @"periodType" : periodType,
                           
                           @"tenantId" : @"",
                           
                           };
    
    return Params;
    
}

-(BOOL)paramsJudge{
    
    if ([deliveryNoticeV.packagesNumField.text isEqualToString:@""]) {
        
        AlertShowWithMessage(@"请输入件数!", @"", @"确定", nil, nil);
        return NO;
    };
    
    if ([deliveryNoticeV.squareNumField.text isEqualToString:@""]) {
        
        AlertShowWithMessage(@"请输入方数!", @"", @"确定", nil, nil);
        return NO;
    };
    
    if ([deliveryNoticeV.weightField.text isEqualToString:@""]) {
        
        AlertShowWithMessage(@"请输入重量!", @"", @"确定", nil, nil);
        return NO;
    };
    
    if ([deliveryNoticeV.addressField.text isEqualToString:@""]) {
        
        AlertShowWithMessage(@"请输入提货地址!", @"", @"确定", nil, nil);
        return NO;
    };
    
    if ([deliveryNoticeV.manField.text isEqualToString:@""]) {
        
        AlertShowWithMessage(@"请输入联系人!", @"", @"确定", nil, nil);
        return NO;
    };
    
    if ([deliveryNoticeV.phoneField.text isEqualToString:@""]) {
        
        AlertShowWithMessage(@"请输入联系号码!", @"", @"确定", nil, nil);
        return NO;
    };
    
    if ([deliveryNoticeV.timeLabel.text isEqualToString:@""]) {
        
        AlertShowWithMessage(@"请输入预约提货时间!", @"", @"确定", nil, nil);
        return NO;
    };
    
    return YES;
}


#pragma mark- other event

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
