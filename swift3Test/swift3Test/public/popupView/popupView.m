//
//  popupView.m
//  ZENGXIN
//
//  Created by 43696467 on 15/5/19.
//  Copyright (c) 2015年 panda. All rights reserved.
//

#import "popupView.h"


@implementation popupView


- (id)initWithButtonArray:(NSMutableArray*) Array block:(void (^)(NSInteger num)) block{
    
    self=[super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {
        _subBlock=block;
        [self drawView:Array];
    };
    return self;
}

-(void)drawView:(NSMutableArray*) Array{
    
    
    double width=self.bounds.size.width;
    double height=self.bounds.size.height;
    
    UIView* bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0.5;
    [self addSubview:bgView];

    NSInteger count=[Array count];
    
    bgView2=[[UIView alloc] initWithFrame:CGRectMake(width/2-135, height/2-(count*50+40)/2, 270, count*50+40)];
    bgView2.backgroundColor=[UIColor whiteColor];
    [self addSubview:bgView2];
    
    CREATELabel(titleLabel, CGRectMake(10, 0, 140, 40), @"请选择一个号码", 15, NSTextAlignmentLeft, bgView2);
    titleLabel.font=[UIFont boldSystemFontOfSize:15];
    
    for (int i = 0; i < Array.count; i ++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(10,40+i*50+5,250,40)];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [button setTitle:[Array objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [button setTag:(200 + i)];
        [button addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth=0.5;
        [bgView2 addSubview:button];
        
    }
    
    [self _bounce0Animation];
    
}

-(void)buttonEvent:(UIButton*) button{
    
    [self dismissAlertViewWithAnimated];
    NSLog(@"buttonEvent:%ld",(long)button.tag);
    _subBlock(button.tag-200);
}

-(void)_bounce0Animation{
    bgView2.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/1.5f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(_bounce1AnimationDidStop)];
    bgView2.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    [UIView commitAnimations];
}

-(void)_bounce1AnimationDidStop{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(_bounce2AnimationDidStop)];
    bgView2.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    [UIView commitAnimations];
}
-(void)_bounce2AnimationDidStop{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(_bounceDidStop)];
    bgView2.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}

-(void)_bounceDidStop{
    
}

-(void)dismissAlertViewWithAnimated{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(_dismissAlertView)];
    self.alpha = 0;
    [UIView commitAnimations];
    
}
-(void)_dismissAlertView{
    [self removeFromSuperview];
}


@end
