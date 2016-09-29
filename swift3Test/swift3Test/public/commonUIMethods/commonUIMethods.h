//
//  commonMethods.h
//  ZENGXIN
//
//  Created by 43696467 on 15/9/5.
//  Copyright (c) 2015年 panda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface commonUIMethods : NSObject


#pragma mark- 通用UI-TextField Bar

+(void)createTextFieldAndName:(NSString*) name AndPlaceholder:(NSString*) placeholder AndHeight:(int) height AndTag:(int) tag AndTag2:(int) tag2 AndView:(UIView*) superView AndFrameHeight:(int) frameHeight AndImageName:(NSString*) imageName AndButtonTag:(int) buttonTag AndImageWidth:(int) ImageWidth AndImageHeight:(int) ImageHeight AndImageViewTag:(int) imageViewTag;

+(void)createTextFieldAndName2:(NSString*) name AndPlaceholder:(NSString*) placeholder AndHeight:(int) height AndTag:(int) tag AndTag2:(int) tag2 AndView:(UIView*) superView AndFrameHeight:(int) frameHeight AndLabelName:(NSString*) labelName AndButtonTag:(int) buttonTag AndLabelWidth:(int) labelWidth;


#pragma mark- 通用UI-SelectLabel Bar

+(void)createSelectLabelAndName:(NSString*) name AndPlaceholder:(NSString*) placeholder AndHeight:(int) height AndTag:(int) tag AndTag2:(int) tag2 AndButtonTag:(int) buttonTag AndImageName:(NSString*) imageName AndView:(UIView*) superView AndFrameHeight:(int) frameHeight AndImageWidth:(int) ImageWidth AndImageHeight:(int) ImageHeight AndImageViewTag:(int) imageViewTag;

+(void)createSelectLabelAndImage:(NSString*) name AndPlaceholder:(NSString*) placeholder AndHeight:(int) height AndTag:(int) tag AndTag2:(int) tag2 AndButtonTag:(int) buttonTag AndImageName:(NSString*) imageName AndView:(UIView*) superView AndFrameHeight:(int) frameHeight AndImageWidth:(int) ImageWidth AndImageHeight:(int) ImageHeight AndImageWidth2:(int) ImageWidth2 AndImageHeight2:(int) ImageHeight2;


#pragma mark- 通用UI-AddImage Bar

+(void)createImageViewAndName:(NSString*) name AndHeight:(int) height AndTag:(int) labelTag AndImageVTag:(int) imageVTag AndImageButTag:(int) imageButTag AndImageConTag:(int) imageConTag AndPromptStr:(NSString*) promptStr AndRightImageName:(NSString*) rightImageName AndView:(UIView*) superView;


@end





