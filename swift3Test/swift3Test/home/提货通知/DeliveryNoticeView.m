//
//  DeliveryNoticeView.m
//  LogisticsHousekeeper
//
//  Created by 43696467 on 16/8/8.
//  Copyright © 2016年 ZengXingTechnology. All rights reserved.
//

#import "DeliveryNoticeView.h"



@implementation DeliveryNoticeView


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        [self drawView];
    };
    
    return self;
    
}


-(void)drawView{
    
    self.contentSize=CGSizeMake(ScreenWidth, 450);
    
    int baseHeight1=0;
    int frameHeight=45;
    
    [commonUIMethods createTextFieldAndName2:@"件数" AndPlaceholder:@"请输入件数" AndHeight:baseHeight1+frameHeight*0 AndTag:101 AndTag2:1001 AndView:self AndFrameHeight:frameHeight AndLabelName:@"件" AndButtonTag:10001 AndLabelWidth:30];
    self.packagesNumField=(UITextField*)[self viewWithTag:1001];
    self.packagesNumField.keyboardType=UIKeyboardTypeNumberPad;
    
    [commonUIMethods createTextFieldAndName2:@"方数" AndPlaceholder:@"请输入方数" AndHeight:baseHeight1+frameHeight*1 AndTag:102 AndTag2:1002 AndView:self AndFrameHeight:frameHeight AndLabelName:@"方" AndButtonTag:10002 AndLabelWidth:30];
    self.squareNumField=(UITextField*)[self viewWithTag:1002];
    self.squareNumField.keyboardType=UIKeyboardTypeNumberPad;

    [commonUIMethods createTextFieldAndName2:@"重量" AndPlaceholder:@"请输入重量" AndHeight:baseHeight1+frameHeight*2 AndTag:103 AndTag2:1003 AndView:self AndFrameHeight:frameHeight AndLabelName:@"吨" AndButtonTag:10003 AndLabelWidth:30];
    self.weightField=(UITextField*)[self viewWithTag:1003];
    self.weightField.keyboardType=UIKeyboardTypeNumberPad;
    
    int baseHeight2=baseHeight1+frameHeight*3+10;
    
    [commonUIMethods createTextFieldAndName:@"提货地址" AndPlaceholder:@"请输入提货地址" AndHeight:baseHeight2+frameHeight*0 AndTag:201 AndTag2:2001 AndView:self AndFrameHeight:frameHeight AndImageName:@"" AndButtonTag:20001 AndImageWidth:19 AndImageHeight:19 AndImageViewTag:200001];
    self.addressField=(UITextField*)[self viewWithTag:2001];
    
    [commonUIMethods createTextFieldAndName:@"联系人" AndPlaceholder:@"请输入联系人" AndHeight:baseHeight2+frameHeight*1 AndTag:202 AndTag2:2002 AndView:self AndFrameHeight:frameHeight AndImageName:@"publish_ico_person" AndButtonTag:20002 AndImageWidth:20 AndImageHeight:20 AndImageViewTag:200002];
    self.manField=(UITextField*)[self viewWithTag:2002];
    self.manButton=(UIButton*)[self viewWithTag:20002];

    [commonUIMethods createTextFieldAndName:@"联系号码" AndPlaceholder:@"请输入联系号码" AndHeight:baseHeight2+frameHeight*2 AndTag:203 AndTag2:2003 AndView:self AndFrameHeight:frameHeight AndImageName:@"" AndButtonTag:20003 AndImageWidth:19 AndImageHeight:19 AndImageViewTag:200003];
    self.phoneField=(UITextField*)[self viewWithTag:2003];
    
    [self creatSelectTimeView];
    
}



-(void)creatSelectTimeView{
    
    UIView* bg=[[UIView alloc] initWithFrame:CGRectMake(0, 290, ScreenWidth, 83)];
    [bg setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:bg];
    
    CREATELabel(titleLabel, CGRectMake(15, 8, 200, 30), @"请输入预约提货时间", 15, NSTextAlignmentLeft, bg);
    
    CREATELabel(timeLabel, CGRectMake(15, 38, 200, 30), @"", 15, NSTextAlignmentLeft, bg);
    self.timeLabel=timeLabel;
    self.timeLabel.layer.borderWidth=0.5;
    self.timeLabel.layer.borderColor=UIColorFromRGB(LINECOLOR).CGColor;
    
    CREATEImageView(imageV, CGRectMake(188, 49.5, 12, 7), [UIImage imageNamed:@"drop_down_icon@2x"], bg);
    
    CREATEButtonWithEmpty(timeButton, CGRectMake(15, 38, 200, 30), bg);
    self.timeButton=timeButton;
    
    CREATELineWithScreenWidth(line, CGRectGetHeight(bg.frame), bg);
    
}


-(void)setDateValue:(NSString*) dateStr{
    
    self.timeLabel.text=[NSString stringWithFormat:@"   %@",dateStr];
    
}

-(void)setDefaultValue:(NSDictionary*) dict{
    
    self.addressField.text=[dict objectForKeyWithoutNull:@"pickupAddress"];
    self.manField.text=[dict objectForKeyWithoutNull:@"pickupMan"];
    self.phoneField.text=[dict objectForKeyWithoutNull:@"pickupTel"];
    
}






@end
