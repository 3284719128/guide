//
//  Controls.m
//  AnLi
//
//  Created by AIR on 16/3/18.
//  Copyright © 2016年 ZengXinKeJi. All rights reserved.
//

#import "Controls.h"

@implementation Controls
+(UILabel *)LabelWithFiame:(CGRect )frame
                  WithText:(NSString *)text
             WithtextColor:(UIColor *)textcolor
                  WithFont:(UIFont *)font
{
    UILabel *label=[[UILabel alloc] initWithFrame:frame];
    label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.text=text;
    label.textColor=textcolor;
    label.font=font;
    return label;
}

+(UILabel *)LabelLeftWithFiame:(CGRect )frame
                      WithText:(NSString *)text
                 WithtextColor:(UIColor *)textcolor
                      WithFont:(UIFont *)font
{

    UILabel *label=[[UILabel alloc] initWithFrame:frame];
    label.textAlignment=NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.text=text;
    label.textColor=textcolor;
    label.font=font;
    return label;

}

+(UILabel *)LabelRightWithFiame:(CGRect )frame
                       WithText:(NSString *)text
                  WithtextColor:(UIColor *)textcolor
                       WithFont:(UIFont *)font
{
    UILabel *label=[[UILabel alloc] initWithFrame:frame];
    label.textAlignment=NSTextAlignmentRight;
    label.backgroundColor = [UIColor clearColor];
    label.text=text;
    label.textColor=textcolor;
    label.font=font;
    return label;

}


+(UIImageView *)ImageWithFrame:(CGRect )frame
                 WithimageName:(NSString *)imageName
{
    UIImageView *imageobjecr=[[UIImageView alloc] initWithFrame:frame];
    [imageobjecr setImage:[UIImage imageNamed:imageName]];
    return imageobjecr;
}


+(UIView *)ViewFieldWithFrame:(CGRect )frame
               WithColor:(UIColor *)color
{
    UIView *view=[[UIView alloc] initWithFrame:frame];
    view.backgroundColor=color;
    view.layer.cornerRadius =4;
    view.layer.masksToBounds = YES;
    [view.layer setBorderWidth:0.5];
    [view.layer setBorderColor:UIColorFromRGB(0XD6D6D6).CGColor];
    return view;
}
+(UIView *)ViewWithFrame:(CGRect )frame
               WithColor:(UIColor *)color
{
    UIView *view=[[UIView alloc] initWithFrame:frame];
    view.backgroundColor=color;
    return view;
}


+(UIButton *)ButtonWithFrame:(CGRect )frame
                   WithTitle:(NSString *)title
                    WithFont:(UIFont *)font
{
    UIButton *button=[[UIButton alloc] initWithFrame:frame];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    return button;

}

+(UIButton *)ButtonWitfFrame:(CGRect)frame WithImage:(NSString *)image{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return button;
}


+(UITextField *)TextFieldWithFrame:(CGRect )frame
                          WithFont:(UIFont *)font
                   Withplaceholder:(NSString *)placeholder
{
    UITextField *textfield=[[UITextField alloc] initWithFrame:frame];
    textfield.borderStyle = UITextBorderStyleNone;
    textfield.keyboardType = UIKeyboardTypeDefault;
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    textfield.backgroundColor=[UIColor clearColor];
    textfield.font=font;
    textfield.placeholder=placeholder;
    return textfield;
    
}




@end
