//
//  Controls.h
//  AnLi
//
//  Created by AIR on 16/3/18.
//  Copyright © 2016年 ZengXinKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Controls : NSObject
/*
        注释:控件组合 如果需要扩展创建一个相应控件 
        如UIlabel *label=[Controls LabelWithFiame..]
        
 */

#pragma -mark UIlabel创建者中心

//文字居中
+(UILabel *)LabelWithFiame:(CGRect )frame
                  WithText:(NSString *)text
             WithtextColor:(UIColor *)textcolor
                  WithFont:(UIFont *)font;

//文字左对齐
+(UILabel *)LabelLeftWithFiame:(CGRect )frame
                  WithText:(NSString *)text
             WithtextColor:(UIColor *)textcolor
                  WithFont:(UIFont *)font;

//文字右对齐
+(UILabel *)LabelRightWithFiame:(CGRect )frame
                      WithText:(NSString *)text
                 WithtextColor:(UIColor *)textcolor
                      WithFont:(UIFont *)font;



#pragma makr - UImageView 创建者中心
//imageview创建可传图
+(UIImageView *)ImageWithFrame:(CGRect )frame
                 WithimageName:(NSString *)imageName;





//创建一个颜色值View  用于界面颜色或底部view
+(UIView *)ViewWithFrame:(CGRect )frame
               WithColor:(UIColor *)color;

//用于创建textfield底部
+(UIView *)ViewFieldWithFrame:(CGRect )frame
                    WithColor:(UIColor *)color;


#pragma mark - UIbutton创建者中心

//创建一个button
+(UIButton *)ButtonWithFrame:(CGRect )frame
                   WithTitle:(NSString *)title
                    WithFont:(UIFont *)font;

//创建一个图片Button
+(UIButton *)ButtonWitfFrame:(CGRect)frame WithImage:(NSString *)image;


#pragma mark - UItextField创建者中心
+(UITextField *)TextFieldWithFrame:(CGRect )frame
                          WithFont:(UIFont *)font
                   Withplaceholder:(NSString *)placeholder;


@end
