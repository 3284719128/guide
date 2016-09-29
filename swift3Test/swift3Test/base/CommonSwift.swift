//
//  CommonSwift.swift
//  swiftTest
//
//  Created by 43696467 on 2016/9/19.
//  Copyright © 2016年 team1. All rights reserved.
//

import Foundation
import UIKit

//屏幕宽度
func ScreenWidth() -> Double{
    return Double(UIScreen.main.bounds.size.width);
}

//屏幕高度
func ScreenHeight() -> Double{
    return Double(UIScreen.main.bounds.size.height);
}

//UIColor
func UIColorFromHexValue(_ value:Int) -> UIColor {
    
    let color=UIColor.init(red: CGFloat(((value & 0xFF0000) >> 16))/CGFloat(255), green: CGFloat(((value & 0xFF00) >> 8))/CGFloat(255), blue: CGFloat((value & 0xFF))/CGFloat(255), alpha: CGFloat(1));
    return color;
}

//UIColor
func UIColorFromRGB(R r:CGFloat,G g:CGFloat,B b:CGFloat) -> UIColor {
    
    let color=UIColor.init(red: r/CGFloat(255), green: g/CGFloat(255), blue: b/CGFloat(255), alpha: CGFloat(1));
    return color;
}

//得到AppDelegate
func getAppDelagate() -> AppDelegate {
    
    let delegate=UIApplication.shared.delegate as! AppDelegate;
    return delegate;
}

//得到MainTabBarController
func getMainTabBarController() -> MainTabBarController {
    
    let vc=getAppDelagate().window?.rootViewController as! MainTabBarController;
    return vc;
    
}


//得到UserDefaults
func getUserDefaults() -> UserDefaults {
    
    return UserDefaults.standard;
}


//创建横线
func createHorizontalLine(withX Xpoint:CGFloat,andY Ypoint:CGFloat,andWidth width:CGFloat) -> UIView {
    
    let lineView=UIView(frame: CGRect(x: Xpoint, y: Ypoint, width: width, height: CGFloat(LINEHEIGHT)));
    lineView.backgroundColor=UIColorFromHexValue(Int(LINECOLOR));
    return lineView;
}

//创建竖线
func createVerticalLine(withX Xpoint:CGFloat,andY Ypoint:CGFloat,andHeight height:CGFloat) -> UIView {
    
    let lineView=UIView(frame: CGRect(x: Xpoint, y: Ypoint, width: CGFloat(LINEHEIGHT), height: height));
    lineView.backgroundColor=UIColorFromHexValue(Int(LINECOLOR));
    return lineView;
}

//创建虚线
func createDottedLine(withFrame frame:CGRect) -> UIView {
    
    let border: CAShapeLayer = CAShapeLayer()
    border.strokeColor = UIColorFromHexValue(Int(LINECOLOR)).cgColor;
    border.lineDashPattern = [3,3]
    
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: frame.size.height/2))
    path.addLine(to: CGPoint(x: frame.size.width, y: frame.size.height/2))
    border.path = path.cgPath
    
    let lineView=UIView.init(frame: frame);
    lineView.layer.addSublayer(border);
    
    return lineView;
    
}


//创建UILabel
func createLabel(withFrame frame:CGRect,andAlignment alignment:NSTextAlignment,andText text:String,andTextColor textcolor:UIColor,andFontSize fontSize:CGFloat) -> UILabel{
    
    let label=UILabel.init(frame: frame);
    label.textAlignment=alignment;
    label.backgroundColor = UIColor.clear;
    label.text=text;
    label.textColor=textcolor;
    label.font=UIFont.systemFont(ofSize: fontSize);
    return label;
}

////创建UIImageView
func createImageView(withFrame frame:CGRect,andImageName imageName:String) -> UIImageView {
    
    let imageobjecr=UIImageView(frame: frame);
    imageobjecr.image=UIImage.init(named: imageName);
    return imageobjecr;
}



//按钮带Image
func createButtonWithImage(withFrame frame:CGRect,andImage btnImage:UIImage) -> UIButton {
    
    let btnObject = UIButton(type: UIButtonType.custom);
    btnObject.frame=frame;
    btnObject.setImage(btnImage, for: UIControlState.normal);
    return btnObject;
    
}

//按钮带Title
func createButtonWithTtile(withFrame frame:CGRect,andTtile btnTitle:String,andTintColor tintColor:UIColor,andFontSize fontSize:CGFloat) -> UIButton {
    
    let btnObject = UIButton(type: UIButtonType.system);
    btnObject.frame=frame;
    btnObject.setTitle(btnTitle, for: UIControlState.normal);
    btnObject.setTitleColor(tintColor, for: UIControlState.normal);
    btnObject.titleLabel?.font=UIFont.systemFont(ofSize: fontSize);
    return btnObject;
    
}

//空按钮
func createButtonWithEmpty(withFrame frame:CGRect) -> UIButton {
    
    let btnObject = UIButton(type: UIButtonType.system);
    btnObject.frame=frame;
    return btnObject;
    
}

//创建背景View
func createBGView(withFrame frame:CGRect,andBackgroundColor backgroundColor:UIColor) -> UIView {
    
    let bgView=UIView(frame: frame);
    bgView.backgroundColor=backgroundColor;
    return bgView;
    
}


//创建TextField
func createTextField(withFrame frame:CGRect,andPlaceholder placeholder:String,andFontSize fontSize:CGFloat,andIsShowBorder isShowBorder:Bool) -> UITextField {
    
    let textField=UITextField.init(frame: frame);
    textField.placeholder=placeholder;
    textField.font=UIFont.systemFont(ofSize: fontSize);
    textField.clearButtonMode=UITextFieldViewMode.whileEditing;
    if isShowBorder {
        textField.layer.borderWidth=0.5;
        textField.layer.borderColor=UIColorFromHexValue(Int(LINECOLOR)).cgColor;
        textField.layer.cornerRadius=CGFloat(TheRoundedAmplitude);
        textField.layer.masksToBounds=true;
    };
    
    return textField;

}


//得到苹果机型
func getCurrentMode() -> String {
    
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8 , value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    switch identifier {
    case "iPod5,1":                                 return "iPod Touch 5"
    case "iPod7,1":                                 return "iPod Touch 6"
    case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
    case "iPhone4,1":                               return "iPhone 4s"
    case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
    case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
    case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
    case "iPhone7,2":                               return "iPhone 6"
    case "iPhone7,1":                               return "iPhone 6 Plus"
    case "iPhone8,1":                               return "iPhone 6s"
    case "iPhone8,2":                               return "iPhone 6s Plus"
    case "iPhone8,4":                               return "iPhone SE"
    case "iPhone9,1":                               return "iPhone 7"
    case "iPhone9,2":                               return "iPhone 7 Plus"
    case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
    case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
    case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
    case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
    case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
    case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
    case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
    case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
    case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
    case "iPad6,7", "iPad6,8":                      return "iPad Pro"
    case "AppleTV5,3":                              return "Apple TV"
    case "i386", "x86_64":                          return "Simulator"
    default:                                        return identifier
    }
    
}

//根据屏幕大小返回值
func selectValueWithScreenSize(fromA a:Double,andB b:Double,andC c:Double,andD d:Double) -> Double {
    
    var SV=b;
    let systemSize=UIScreen.main.currentMode!.size;
    if systemSize.equalTo(CGSize.init(width: 640, height: 960)) {
        SV=a;
    }else if systemSize.equalTo(CGSize.init(width: 640, height: 1136)) {
        SV=b;
    }else if systemSize.equalTo(CGSize.init(width: 750, height: 1334)) {
        SV=c;
    }else if systemSize.equalTo(CGSize.init(width: 1242, height: 2208)) {
        SV=d;
    };
    
    return SV;
}




