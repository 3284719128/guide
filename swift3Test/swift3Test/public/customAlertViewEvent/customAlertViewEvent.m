//
//  customAlertViewEvent.m
//  WO56_Driver
//
//  Created by 43696467 on 16/3/10.
//  Copyright © 2016年 Yaoquan Li. All rights reserved.
//

#import "customAlertViewEvent.h"

#import <UIKit/UIKit.h>

@implementation customAlertViewEvent

static customAlertViewEvent* customAlertViewE=nil;


+(id)sharedCustomAlertViewEventWithMessageStr:(NSString*) messageStr andCancelStr:(NSString*) cancelStr andOkStr:(NSString*) okStr andCancelBlock:(void (^)()) cancelBlock andOkBlock:(void (^)()) okBlock{
    
    if (customAlertViewE == nil) {
        customAlertViewE=[[customAlertViewEvent alloc] init];
    };
    
    if (customAlertViewE) {
        [customAlertViewE showAletrViewWithMessageStr:messageStr andCancelStr:cancelStr andOkStr:okStr andCancelBlock:cancelBlock andOkBlock:okBlock];
    };
    
    return customAlertViewE;
    
}


-(void)showAletrViewWithMessageStr:(NSString*) messageStr andCancelStr:(NSString*) cancelStr andOkStr:(NSString*) okStr andCancelBlock:(void (^)()) cancelBlock andOkBlock:(void (^)()) okBlock{
    
    UIAlertController* alertC=[UIAlertController alertControllerWithTitle:@"温馨提示" message:messageStr preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelStr != nil && ![cancelStr isEqualToString:@""]) {
        UIAlertAction* cancelA=[UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock != nil) {
                cancelBlock();
            };
        }];
        [alertC addAction:cancelA];
    };
    
    
    if (okStr != nil && ![okStr isEqualToString:@""]) {
        UIAlertAction* confirmA=[UIAlertAction actionWithTitle:okStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (okBlock != nil) {
                okBlock();
            };
        }];
        [alertC addAction:confirmA];
    };
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertC animated:YES completion:^{
        
    }];;
    
}


-(void)getAlertController{
    

    
}



@end
