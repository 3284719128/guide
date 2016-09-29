//
//  DeliveryNoticeView.h
//  LogisticsHousekeeper
//
//  Created by 43696467 on 16/8/8.
//  Copyright © 2016年 ZengXingTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeliveryNoticeView : UIScrollView


@property (nonatomic,retain) UITextField* packagesNumField;
@property (nonatomic,retain) UITextField* squareNumField;
@property (nonatomic,retain) UITextField* weightField;

@property (nonatomic,retain) UITextField* addressField;

@property (nonatomic,retain) UITextField* manField;
@property (nonatomic,retain) UIButton* manButton;

@property (nonatomic,retain) UITextField* phoneField;

@property (nonatomic,retain) UILabel* timeLabel;
@property (nonatomic,retain) UIButton* timeButton;


-(void)setDateValue:(NSString*) dateStr;
-(void)setDefaultValue:(NSDictionary*) dict;



@end
