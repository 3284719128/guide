//
//  popupView.h
//  ZENGXIN
//
//  Created by 43696467 on 15/5/19.
//  Copyright (c) 2015年 panda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface popupView : UIView
{
    UIView* bgView2;
}

@property (nonatomic,copy) void (^subBlock)(NSInteger num);


- (id)initWithButtonArray:(NSMutableArray*) Array block:(void (^)(NSInteger num)) block;
-(void)dismissAlertViewWithAnimated;

@end
