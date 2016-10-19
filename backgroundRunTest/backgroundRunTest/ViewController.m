//
//  ViewController.m
//  backgroundRunTest
//
//  Created by 43696467 on 2016/10/11.
//  Copyright © 2016年 team1. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton* button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, ([UIScreen mainScreen].bounds.size.height-40)/2, 100, 40)];
    [button setTitle:@"请求" forState:UIControlStateNormal];
    button.layer.borderWidth=0.5;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* button2=[UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-100)/2, ([UIScreen mainScreen].bounds.size.height-40)/2+50, 100, 40)];
    [button2 setTitle:@"检索" forState:UIControlStateNormal];
    button2.layer.borderWidth=0.5;
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(reverseGeoCodeSearch) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)buttonAction:(UIButton*) sender{
    
    AppDelegate* delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSDictionary* params = @{
                             @"billId":PhoneNumber,
                             @"latitude":[NSString stringWithFormat:@"%f",delegate.currentUserLocationCoordinate.latitude],
                             @"longitude":[NSString stringWithFormat:@"%f",delegate.currentUserLocationCoordinate.longitude],
                             
                             };
    
    [BaseRequest requestWithInCode:@"40064" Parameters:params Block:^(NSDictionary *contentDict, NSString *message) {
        
        if ([message isEqualToString:@"SUCESS"]) {
            
            NSLog(@"上传位置成功:%@",message);

            
        }else if (message == nil){
            NSLog(@"返回 message is nil");
        }else{
            NSLog(@"上传位置失败:%@",message);
            
        };
        
    }];

    
}

-(void)reverseGeoCodeSearch{
    
    AppDelegate* delegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    //初始化检索对象
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    
    //发起反向地理编码检索
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = delegate.currentUserLocationCoordinate;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    
    NSLog(@"address:%@%@%@%@%@",result.addressDetail.province,result.addressDetail.city,result.addressDetail.district,result.addressDetail.streetName,result.addressDetail.streetNumber);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
