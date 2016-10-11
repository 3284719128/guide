//
//  ViewController.m
//  backgroundRunTest
//
//  Created by 43696467 on 2016/10/11.
//  Copyright © 2016年 team1. All rights reserved.
//

#import "ViewController.h"

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
    
}

-(void)buttonAction:(UIButton*) sender{
    
    NSDictionary* params = @{
                             @"billId":@"18112345678",
                             @"latitude":@"23.0",
                             @"longitude":@"113.0",
                             
                             };
    
    [BaseRequest requestWithInCode2:@"310002" Parameters:params Block:^(NSDictionary *contentDict, NSString *message) {
        
        if ([message isEqualToString:@"SUCESS"]) {
            
            NSLog(@"上传位置成功:%@",message);

            
        }else if (message == nil){
            NSLog(@"返回 message is nil");
        }else{
            NSLog(@"上传位置失败:%@",message);
            
        };
        
    }];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end