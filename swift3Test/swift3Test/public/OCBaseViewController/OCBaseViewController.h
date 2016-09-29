//
//  BaseViewController.h
//  AnLi
//
//  Created by Yaoquan Li on 16/3/11.
//  Copyright © 2016年 ZengXinKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OCBaseViewController : UIViewController

@property (nonatomic,strong) NSUserDefaults * userDefaults;

@property (nonatomic,strong) UIView * navView;             //导航栏View

@property (nonatomic,strong) UIImageView * backImage;      //返回按钮图标

@property (nonatomic,strong) UIButton * backButton;        //返回按钮

@property (nonatomic,strong) UILabel * titleLabel;         //返回按钮标题

@property (nonatomic,strong) UIButton * rightButton;       //导航栏右按钮

@property (nonatomic,strong) UILabel * rightLabel;         //导航栏右标题

@property (nonatomic,strong) UIImageView * bgImgView;      //底部颜色

@property (nonatomic,strong) NSLayoutConstraint * backImageConstraint;      //左上角按钮边距

@property (nonatomic) BOOL didSetupConstraints;

- (void)headBackEvent;


@end
