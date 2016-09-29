//
//  BaseViewController.m
//  AnLi
//
//  Created by Yaoquan Li on 16/3/11.
//  Copyright © 2016年 ZengXinKeJi. All rights reserved.
//

#import "OCBaseViewController.h"

#import "swift3Test-Swift.h"

@interface OCBaseViewController ()



@end

@implementation OCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.view.backgroundColor = UIColorFromRGB(MainColor);
    
    self.bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:self.bgImgView];
//    self.bgImgView.image = [UIImage imageNamed:@"bg"];
    
    //导航栏
    self.navView = [UIView newAutoLayoutView];
    self.navView.backgroundColor = UIColorFromRGB(0xd64242);
    [self.view addSubview:self.navView];
    
    
    
    self.backImage = [UIImageView newAutoLayoutView];
    self.backImage.image = [UIImage imageNamed:@"header_return"];
    [self.view addSubview:self.backImage];
    
    self.backButton = [UIButton newAutoLayoutView];
    [self.backButton addTarget:self action:@selector(headBackEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    self.titleLabel = [UILabel newAutoLayoutView];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:self.titleLabel];
    
    self.rightLabel = [UILabel newAutoLayoutView];
    self.rightLabel.font = [UIFont systemFontOfSize:15];
    self.rightLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.rightLabel];
    
    self.rightButton = [UIButton newAutoLayoutView];
    self.rightButton.hidden = YES;
    [self.view addSubview:self.rightButton];
    
    
    [self.navView autoSetDimensionsToSize:CGSizeMake(ScreenWidth, NavigationBarHeight)];
    [self.navView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view];
    [self.navView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view];
    
    [self.backImage autoSetDimensionsToSize:CGSizeMake(12, 22)];
    [self.backImage autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:34];
    self.backImageConstraint = [self.backImage autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:15.0];
    
    [self.backButton autoSetDimensionsToSize:CGSizeMake(100, 50)];
    [self.backButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.view withOffset:20.0];
    [self.backButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.view withOffset:0.0];
    
//    [self.titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.backImage withOffset:10.0];
    [self.titleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
    [self.titleLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.backButton];
    
    [self.rightLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.view withOffset:-15.0];
    [self.rightLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.backButton];
    
    [self.rightButton autoSetDimension:ALDimensionHeight toSize:50.0];
    [self.rightButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.rightLabel];
    [self.rightButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.rightLabel];
    [self.rightButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.backButton];
    

}

-(void)viewWillAppear:(BOOL)animated{
    
    MainTabBarController* vc=(MainTabBarController*)GetAppDelagate.window.rootViewController;
    [vc hiddenTabbarEventWithBool:YES];
    
}


- (void)headBackEvent {
    popViewController;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
