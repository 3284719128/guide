//
//  commonMethods.m
//  ZENGXIN
//
//  Created by 43696467 on 15/9/5.
//  Copyright (c) 2015年 panda. All rights reserved.
//

#import "commonUIMethods.h"

@implementation commonUIMethods


#pragma mark- 通用UI-TextField Bar

+(void)createTextFieldAndName:(NSString*) name AndPlaceholder:(NSString*) placeholder AndHeight:(int) height AndTag:(int) tag AndTag2:(int) tag2 AndView:(UIView*) superView AndFrameHeight:(int) frameHeight AndImageName:(NSString*) imageName AndButtonTag:(int) buttonTag AndImageWidth:(int) ImageWidth AndImageHeight:(int) ImageHeight AndImageViewTag:(int) imageViewTag{
    
    UILabel* Bg=[[UILabel alloc] initWithFrame:CGRectMake(0, height, ScreenWidth, frameHeight)];
    Bg.backgroundColor=[UIColor whiteColor];
    [superView addSubview:Bg];
    
    CREATELabel(label, CGRectMake(12, height, 70, frameHeight), name, 15, NSTextAlignmentRight, superView);
    //label.layer.borderWidth=0.5;
    [label setTag:tag];
    
    CREATE_TEXTINPUT_ADD_SUPERVIEW(textField, CGRectMake(90, height, ScreenWidth-90-ImageWidth, frameHeight), 15, superView);
    [textField setTag:tag2];
    [textField setPlaceholder:placeholder];
    
    if (![imageName isEqualToString:@""]) {
        UIImage* image=[UIImage imageNamed:imageName];
        CREATEImageView(imageobject, CGRectMake(ScreenWidth-23-ImageWidth/2,height+(frameHeight-ImageHeight)/2, ImageWidth, ImageHeight), image, superView);
        [imageobject setTag:imageViewTag];
        
        CREATEButtonWithEmpty(selectBut, CGRectMake(ScreenWidth-23-frameHeight/2,height, frameHeight, frameHeight), superView);

        //selectBut.layer.borderWidth=0.5;
        [selectBut setTag:buttonTag];
    };
    
    CREATELineWithScreenWidth(line, height+Bg.bounds.size.height-LINEHEIGHT, superView);
    
}

+(void)createTextFieldAndName2:(NSString*) name AndPlaceholder:(NSString*) placeholder AndHeight:(int) height AndTag:(int) tag AndTag2:(int) tag2 AndView:(UIView*) superView AndFrameHeight:(int) frameHeight AndLabelName:(NSString*) labelName AndButtonTag:(int) buttonTag AndLabelWidth:(int) labelWidth{
    
    UILabel* Bg=[[UILabel alloc] initWithFrame:CGRectMake(0, height, ScreenWidth, frameHeight)];
    Bg.backgroundColor=[UIColor whiteColor];
    [superView addSubview:Bg];
    
    CREATELabel(label, CGRectMake(12, height, 70, frameHeight), name, 15, NSTextAlignmentRight, superView);
    //label.layer.borderWidth=0.5;
    [label setTag:tag];
    
    CREATE_TEXTINPUT_ADD_SUPERVIEW(textField, CGRectMake(90, height, ScreenWidth-90-labelWidth, frameHeight), 15, superView);
    [textField setTag:tag2];
    [textField setPlaceholder:placeholder];
    
    if (![labelName isEqualToString:@""]) {
        
        CREATELabel(label2, CGRectMake(ScreenWidth-labelWidth, height, labelWidth, frameHeight), labelName, 15, NSTextAlignmentLeft, superView);
        label2.textColor=UIColorFromRGB(0xbdbdbd);
        
        CREATEButtonWithEmpty(selectBut, CGRectMake(ScreenWidth-23-frameHeight/2,height, frameHeight, frameHeight), superView);
//        selectBut.layer.borderWidth=0.5;
        [selectBut setTag:buttonTag];
    };
    
    CREATELineWithScreenWidth(line, height+Bg.bounds.size.height-LINEHEIGHT, superView);
    
}



#pragma mark- 通用UI-SelectLabel Bar

+(void)createSelectLabelAndName:(NSString*) name AndPlaceholder:(NSString*) placeholder AndHeight:(int) height AndTag:(int) tag AndTag2:(int) tag2 AndButtonTag:(int) buttonTag AndImageName:(NSString*) imageName AndView:(UIView*) superView AndFrameHeight:(int) frameHeight AndImageWidth:(int) ImageWidth AndImageHeight:(int) ImageHeight AndImageViewTag:(int) imageViewTag{
    
    UILabel* Bg=[[UILabel alloc] initWithFrame:CGRectMake(0, height, ScreenWidth, frameHeight)];
    Bg.backgroundColor=[UIColor whiteColor];
    [superView addSubview:Bg];
    
    CREATELabel(label, CGRectMake(12, height, 70, frameHeight), name, 15, NSTextAlignmentRight, superView);
    //label.layer.borderWidth=0.5;
    [label setTag:tag];
    
    CREATELabel(label2, CGRectMake(90, height, ScreenWidth-90-30, frameHeight), placeholder, 15, NSTextAlignmentLeft, superView);
    [label2 setTextColor:UIColorFromRGB(0xBDBDBD)];
    //label2.layer.borderWidth=0.5;
    [label2 setTag:tag2];
    
    CREATEButtonWithEmpty(selectBut, CGRectMake(90, height, ScreenWidth-90, frameHeight), superView);
    //selectBut.layer.borderWidth=0.5;
    [selectBut setTag:buttonTag];
    
    UIImage* image=[UIImage imageNamed:imageName];
    
    CREATEImageView(imageobject, CGRectMake(ScreenWidth-23-ImageWidth/2,height+(frameHeight-ImageHeight)/2, ImageWidth, ImageHeight), image, superView);//@"form_arrow_down.png"
    [imageobject setTag:imageViewTag];
    
    CREATELineWithScreenWidth(line, height+Bg.bounds.size.height-LINEHEIGHT, superView);
    
}


+(void)createSelectLabelAndImage:(NSString*) name AndPlaceholder:(NSString*) placeholder AndHeight:(int) height AndTag:(int) tag AndTag2:(int) tag2 AndButtonTag:(int) buttonTag AndImageName:(NSString*) imageName AndView:(UIView*) superView AndFrameHeight:(int) frameHeight AndImageWidth:(int) ImageWidth AndImageHeight:(int) ImageHeight AndImageWidth2:(int) ImageWidth2 AndImageHeight2:(int) ImageHeight2{
    
    UILabel* Bg=[[UILabel alloc] initWithFrame:CGRectMake(0, height, ScreenWidth, frameHeight)];
    Bg.backgroundColor=[UIColor whiteColor];
    [superView addSubview:Bg];
    
    UIImage* image=[UIImage imageNamed:name];
    CREATEImageView(imageobject, CGRectMake(12,height+(frameHeight-ImageHeight)/2, ImageWidth, ImageHeight), image, superView);
    
    CREATELabel(label2, CGRectMake(50, height, ScreenWidth-50-30, frameHeight), placeholder, 15, NSTextAlignmentLeft, superView);
    [label2 setTextColor:UIColorFromRGB(0xBDBDBD)];
    label2.numberOfLines=0;
    [label2 setTag:tag2];
    //label2.layer.borderWidth=0.5;
    
    CREATEButtonWithEmpty(selectBut, CGRectMake(50, height, ScreenWidth-50, frameHeight), superView);
    //selectBut.layer.borderWidth=0.5;
    [selectBut setTag:buttonTag];
    
    UIImage* image2=[UIImage imageNamed:imageName];
    CREATEImageView(imageobject2, CGRectMake(ScreenWidth-23-ImageWidth2/2,height+(frameHeight-ImageHeight2)/2, ImageWidth2, ImageHeight2), image2, superView);//@"form_arrow_down.png"
    
    CREATELineWithScreenWidth(line, height+Bg.bounds.size.height-LINEHEIGHT, superView);
    
}


#pragma mark- 通用UI-AddImage Bar

+(void)createImageViewAndName:(NSString*) name AndHeight:(int) height AndTag:(int) labelTag AndImageVTag:(int) imageVTag AndImageButTag:(int) imageButTag AndImageConTag:(int) imageConTag AndPromptStr:(NSString*) promptStr AndRightImageName:(NSString*) rightImageName AndView:(UIView*) superView{
    
    UILabel* Bg=[[UILabel alloc] initWithFrame:CGRectMake(0, height, ScreenWidth, 70)];
    Bg.backgroundColor=[UIColor whiteColor];
    [superView addSubview:Bg];
    
    CREATELabel(label, CGRectMake(12, height+15, 70, 40), name, 15, NSTextAlignmentRight, superView);
    [label setTag:labelTag];
    
    CREATEImageView(imageV, CGRectMake(90, height+10, 50, 50), nil, superView);
    [imageV setTag:imageVTag];
    
    CREATEButtonWithImage(imageBut, CGRectMake(90, height+10, 50, 50), [UIImage imageNamed:@"default_img_addpic.png"], superView);
    [imageBut setTag:imageButTag];
    
    CREATELabel(promptLabel, CGRectMake(ScreenWidth-111,height+28.5,80, 13), promptStr, 12, NSTextAlignmentCenter, superView);
    promptLabel.textColor = UIColorFromRGB(0X888888);
    
    CREATEImageView(rightImageV, CGRectMake(ScreenWidth-23-15/2,height+27.5,15,15), [UIImage imageNamed:rightImageName], superView);//@"list_item_arrow.png"
    
    UIControl* imageCon = [[UIControl alloc]initWithFrame:CGRectMake(FrameWidth(imageBut)+5,height+10,ScreenWidth-(FrameWidth(imageBut)+5), 50)];
    imageCon.backgroundColor = [UIColor clearColor];
    //    imageCon.layer.borderWidth=0.5;
    [superView addSubview:imageCon];
    [imageCon setTag:imageConTag];
    
    CREATELineWithScreenWidth(line, height+Bg.bounds.size.height-LINEHEIGHT, superView);
    
}


@end
