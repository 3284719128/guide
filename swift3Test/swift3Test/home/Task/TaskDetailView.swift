//
//  TaskDetailView.swift
//  swiftTest
//
//  Created by 43696467 on 2016/9/23.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class TaskDetailView: UIScrollView {
    
    var bgV1:UIView!;
    var bgV2:UIView!;
    var bgV3:UIView!;
    var bgV4:UIView!;
    
    var company:UILabel!;
    var status:UILabel!;
    var waybillNum:UILabel!;
    var orderNum:UILabel!;
    var money:UILabel!;

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
        
        self.bgView1();
        self.bgView2();
        self.bgView3();
        self.bgView4();
        
        self.contentSize=CGSize.init(width: ScreenWidth(), height: Double(self.bgV4.frame.maxY)+70)
        
    }
    
    func bgView1() {
        
        self.bgV1=createBGView(withFrame: CGRect.init(x: 0, y: 10, width: ScreenWidth(), height: 160), andBackgroundColor: UIColor.white);
        self.addSubview(self.bgV1);
        
        self.company=createLabel(withFrame: CGRect.init(x: 15, y: 15, width: 200, height: 15), andAlignment: NSTextAlignment.left, andText: "货通天下物流公司", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 15);
        self.bgV1.addSubview(self.company);
        
        self.status=createLabel(withFrame: CGRect(x: ScreenWidth()-110, y: 15, width: 100, height: 15), andAlignment: NSTextAlignment.right, andText: "正常签收", andTextColor: UIColorFromRGB(R: 94, G: 125, B: 176), andFontSize: 15);
        self.bgV1.addSubview(self.status);
        
        
        self.waybillNum=createLabel(withFrame: CGRect(x: 15, y: self.company!.frame.maxY+5, width: 200, height: 10), andAlignment: NSTextAlignment.left, andText: "运单号:DS123456789", andTextColor: UIColorFromHexValue(0x999999), andFontSize: 11);
        self.bgV1.addSubview(self.waybillNum);
        
        
        self.orderNum=createLabel(withFrame: CGRect(x: 15, y: self.waybillNum!.frame.maxY+3, width: 200, height: 10), andAlignment: NSTextAlignment.left, andText: "订单号:DS123456789", andTextColor: UIColorFromHexValue(0x999999), andFontSize: 11);
        self.bgV1.addSubview(self.orderNum);
        
        
        self.money=createLabel(withFrame: CGRect(x: CGFloat(ScreenWidth())-115, y: self.status!.frame.maxY+8, width: 97, height: 15), andAlignment: NSTextAlignment.right, andText: "￥265.00", andTextColor: UIColor.red, andFontSize: 13);
        self.bgV1.addSubview(self.money);
        
        
        let line=createDottedLine(withFrame: CGRect.init(x: 15, y: 60, width: ScreenWidth()-30, height: 10));
        self.bgV1.addSubview(line);
        
        
        let nameLabel=createLabel(withFrame: CGRect.init(x: 15, y: 80, width: 100, height: 20), andAlignment: NSTextAlignment.left, andText: "物流跟踪", andTextColor: UIColor.black, andFontSize: 15);
        self.bgV1.addSubview(nameLabel);
        
        
        let line2=createHorizontalLine(withX: 0, andY: self.bgV1.frame.height-CGFloat(LINEHEIGHT), andWidth: CGFloat(ScreenWidth()));
        self.bgV1.addSubview(line2);
        
    }
    
    func bgView2() {
        
        self.bgV2=createBGView(withFrame: CGRect.init(x: 0, y: Double(self.bgV1.frame.maxY)+10, width: ScreenWidth(), height: 100), andBackgroundColor: UIColor.white);
        self.addSubview(self.bgV2);
        
        let deliveryInfo=createLabel(withFrame: CGRect.init(x: 15, y: 0, width: 80, height: 40), andAlignment: NSTextAlignment.left, andText: "配送信息", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 15);
        self.bgV2.addSubview(deliveryInfo);
        
        let line=createDottedLine(withFrame: CGRect.init(x: 15, y: 35, width: ScreenWidth()-30, height: 10));
        self.bgV2.addSubview(line);
        
        let imageV=createImageView(withFrame: CGRect.init(x: 16.5, y: 59, width: 19, height: 19), andImageName: "list_give")
        self.bgV2.addSubview(imageV);
        
        let extractPlace=createLabel(withFrame: CGRect.init(x: 42, y: 55, width: 200, height: 12), andAlignment: NSTextAlignment.left, andText: "广州萝岗区科学大道路162号", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 13);
        self.bgV2.addSubview(extractPlace);
        
        let extractLink=createLabel(withFrame: CGRect.init(x: 42, y: Double(extractPlace.frame.maxY)+7.5, width: 200, height: 10), andAlignment: NSTextAlignment.left, andText: "张本 18612345678", andTextColor: UIColorFromHexValue(0x999999), andFontSize: 11);
        self.bgV2.addSubview(extractLink);
        
        let extractPhoneBtn=createButtonWithImage(withFrame: CGRect(x: ScreenWidth()-45, y: 45, width: 40, height: 40), andImage: UIImage.init(named: "list_phone")!);
        extractPhoneBtn.imageEdgeInsets=UIEdgeInsets.init(top: 7.5, left: 0, bottom: 7.5, right: 15);
        self.bgV2.addSubview(extractPhoneBtn);
        
        let tianmaoImage=createImageView(withFrame: CGRect(x: ScreenWidth()/2, y: 10, width: 98.5, height: 65.5), andImageName: "list_seal");
        self.bgV2.addSubview(tianmaoImage);
        
        
        let line2=createHorizontalLine(withX: 0, andY: self.bgV2.frame.height-CGFloat(LINEHEIGHT), andWidth: CGFloat(ScreenWidth()));
        self.bgV2.addSubview(line2);
        
        
    }
    
    func bgView3() {
        
        self.bgV3=createBGView(withFrame: CGRect.init(x: 0, y: Double(self.bgV2.frame.maxY)+10, width: ScreenWidth(), height: 185), andBackgroundColor: UIColor.white);
        self.addSubview(self.bgV3);
        
        let goodInfo=createLabel(withFrame: CGRect.init(x: 15, y: 0, width: 80, height: 40), andAlignment: NSTextAlignment.left, andText: "货物信息", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 15);
        self.bgV3.addSubview(goodInfo);
        
        let line=createDottedLine(withFrame: CGRect.init(x: 15, y: 35, width: ScreenWidth()-30, height: 10));
        self.bgV3.addSubview(line);
        
        let goodLabel=createLabel(withFrame: CGRect.init(x: 0, y: 44, width: ScreenWidth()/3, height: 35), andAlignment: NSTextAlignment.center, andText: "货品", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 15);
        self.bgV3.addSubview(goodLabel);
        
        let typeLabel=createLabel(withFrame: CGRect.init(x: ScreenWidth()/3, y: 44, width: ScreenWidth()/3, height: 35), andAlignment: NSTextAlignment.center, andText: "包装", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 15);
        self.bgV3.addSubview(typeLabel);
        
        let goodNum=createLabel(withFrame: CGRect.init(x: ScreenWidth()/3*2, y: 44, width: ScreenWidth()/3, height: 35), andAlignment: NSTextAlignment.center, andText: "包装/安装件数", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 15);
        self.bgV3.addSubview(goodNum);
        
        
        let line2=createHorizontalLine(withX: 0, andY: self.bgV3.frame.height-CGFloat(LINEHEIGHT), andWidth: CGFloat(ScreenWidth()));
        self.bgV3.addSubview(line2);
        
    }
    
    func bgView4() {
        
        self.bgV4=createBGView(withFrame: CGRect.init(x: 0, y: Double(self.bgV3.frame.maxY)+10, width: ScreenWidth(), height: 105), andBackgroundColor: UIColor.white);
        self.addSubview(self.bgV4);
        
        let remark=createLabel(withFrame: CGRect.init(x: 15, y: 0, width: 50, height: 40), andAlignment: NSTextAlignment.left, andText: "备注", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 15);
        self.bgV4.addSubview(remark);
        
        let line=createDottedLine(withFrame: CGRect.init(x: 15, y: 35, width: ScreenWidth()-30, height: 10));
        self.bgV4.addSubview(line);
        
        let remarkLabel=createLabel(withFrame: CGRect.init(x: 15, y: 41, width: ScreenWidth()-30, height: 60), andAlignment: NSTextAlignment.left, andText: "这是一个备注,显示一点什么的", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 12);
        self.bgV4.addSubview(remarkLabel);
        
        
        let line2=createHorizontalLine(withX: 0, andY: self.bgV4.frame.height-CGFloat(LINEHEIGHT), andWidth: CGFloat(ScreenWidth()));
        self.bgV4.addSubview(line2);
        
    }

}
