//
//  PersonalCenterView.swift
//  swift3Test
//
//  Created by 43696467 on 2016/9/28.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class PersonalCenterView: UIScrollView {
    
    var exitBut:UIButton!;

    //MARK:- system method
    override init(frame: CGRect) {
        
        super.init(frame: frame);
        self.drawView();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- draw view event
    func drawView() {
        
        self.contentSize=CGSize.init(width: ScreenWidth(), height: 435);
        
        self.drawDetailBar(withTitleStr: "头像", andContentStr: "", andYPoint: 0, andFrameHeight: 65, andSuperView: self,andImageName: "friend_3");
        self.drawDetailBar(withTitleStr: "呢称", andContentStr: "张某", andYPoint: 65, andFrameHeight: 50, andSuperView: self,andImageName: "");
        self.drawDetailBar(withTitleStr: "手机号码", andContentStr: "18112345678", andYPoint: 115, andFrameHeight: 50, andSuperView: self,andImageName: "");

        self.drawDetailBar(withTitleStr: "车型", andContentStr: "半挂车", andYPoint: 175, andFrameHeight: 50, andSuperView: self,andImageName: "");

        self.drawDetailBar(withTitleStr: "版本", andContentStr: "V1.0.0", andYPoint: 235, andFrameHeight: 50, andSuperView: self,andImageName: "");
        
        self.exitBut=createButtonWithTtile(withFrame: CGRect.init(x: 0, y: 295, width: ScreenWidth(), height: 50), andTtile: "退出登录", andTintColor: UIColorFromHexValue(0x5d7bb1), andFontSize: 15);
        self.exitBut.backgroundColor=UIColor.white;
        self.addSubview(self.exitBut);
        self.exitBut.addTarget(self, action: #selector(exitButtonAction(_:)), for: UIControlEvents.touchUpInside);
        
        self.drawFooterView();
        
    }
    
    func drawDetailBar(withTitleStr titleStr:String,andContentStr contentStr:String,andYPoint yPoint:Double,andFrameHeight frameHeight:Double,andSuperView superView:UIView,andImageName imageName:String) {
        
        let bgV=createBGView(withFrame: CGRect.init(x: 0, y: yPoint, width: ScreenWidth(), height: frameHeight), andBackgroundColor: UIColor.white);
        superView.addSubview(bgV)
        
        let titleLabel=createLabel(withFrame: CGRect.init(x: 0, y: 0, width: 80, height: frameHeight), andAlignment: NSTextAlignment.right, andText: titleStr, andTextColor: UIColor.black, andFontSize: 15);
        bgV.addSubview(titleLabel);
        
        if !imageName.isEmpty {
            
            let imageVY=(frameHeight-45)/2;
            let imageV=createImageView(withFrame: CGRect.init(x: ScreenWidth()-45-19-12, y: imageVY, width: 45, height: 45), andImageName: imageName);
            bgV.addSubview(imageV);
            
        }else{
            
            let contentLabel=createLabel(withFrame: CGRect.init(x: 90, y: 0, width: ScreenWidth()-90-19-12, height: frameHeight), andAlignment: NSTextAlignment.right, andText: contentStr, andTextColor: UIColor.black, andFontSize: 15);
            bgV.addSubview(contentLabel);
            
        };

        let forwardIV=createImageView(withFrame: CGRect(x: ScreenWidth()-19, y: (frameHeight-12)/2, width: 7, height: 12), andImageName: "list_forward");
        bgV.addSubview(forwardIV);
        
        let lineY=frameHeight-LINEHEIGHT;
        let line=createHorizontalLine(withX: 0, andY: CGFloat(lineY), andWidth: CGFloat(ScreenWidth()));
        bgV.addSubview(line);

        
    }
    
    
    func drawFooterView() {
        
        let serviceBut=createButtonWithEmpty(withFrame: CGRect.init(x: (ScreenWidth()-150)/2, y: 365, width: 150, height: 30));
        serviceBut.backgroundColor=UIColor.white;
        serviceBut.layer.cornerRadius=15;
        serviceBut.layer.masksToBounds=true;
        self.addSubview(serviceBut);
        
        
        let imageV=createImageView(withFrame: CGRect.init(x: 5, y: 5, width: 20, height: 20), andImageName: "phone");
        serviceBut.addSubview(imageV);
        
        let label=createLabel(withFrame: CGRect.init(x: 30, y: 0, width: serviceBut.frame.width-30, height: serviceBut.frame.height), andAlignment: NSTextAlignment.center, andText: "400-830-5900", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 15);
        serviceBut.addSubview(label);
        
        
        let timeLabel=createLabel(withFrame: CGRect.init(x: (ScreenWidth()-200)/2, y: Double(serviceBut.frame.maxY), width: 200, height: 20), andAlignment: NSTextAlignment.center, andText: "服务时间9:00-24:00", andTextColor: UIColorFromHexValue(0x555555), andFontSize: 11);
        self.addSubview(timeLabel);
        
        
    }
    
    
    func exitButtonAction(_ sender:UIButton) {
        
        customAlertViewEvent.sharedCustomAlertViewEvent(withMessageStr: "服务器繁忙!", andCancelStr: "", andOkStr: "确定", andCancel: nil, andOkBlock: nil);
        
    }
    

}
