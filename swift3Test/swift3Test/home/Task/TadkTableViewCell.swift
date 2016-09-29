//
//  TadkTableViewCell.swift
//  swift3Test
//
//  Created by 43696467 on 2016/9/27.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class TadkTableViewCell: UITableViewCell {
    
    
    var company:UILabel?;
    var status:UILabel?;
    var waybillNum:UILabel?;
    var orderNum:UILabel?;
    var money:UILabel?;
    
    var forwardIV:UIImageView?;
    
    var extractImage:UIImageView?;
    var extractPlace:UILabel?;
    var extractLink:UILabel?;
    var extractPhoneBtn:UIButton?;
    var extractPhone:String="";
    
    var tianmaoImage:UIImageView?;
    
    var describe:UILabel?;
    
    var time:UILabel?;
    var timeoutLabel:UILabel?;
    var btn1:UIButton?;
    var zxPhone:String="";
    
    static var TadkTableViewCellID = "TadkTableViewCellID";
    
    //MARK:- system method
    static func createCell(withTableView tableView:UITableView) -> TadkTableViewCell {
        
        var cell:TadkTableViewCell?=tableView.dequeueReusableCell(withIdentifier: TadkTableViewCellID) as? TadkTableViewCell;
        if cell == nil {
            cell=TadkTableViewCell();
            cell?.backgroundColor=UIColor.clear;
            cell?.selectionStyle=UITableViewCellSelectionStyle.none;
            cell?.drawCellView();
        }
        
        return cell!;
        
    }
    
    //MARK:- draw view event
    func drawCellView() {
        
        let bg=createBGView(withFrame: CGRect.init(x: 10, y: 10, width: ScreenWidth()-20, height: 227), andBackgroundColor: UIColor.white);
        bg.layer.cornerRadius=CGFloat(TheRoundedAmplitude);
        bg.layer.masksToBounds=true;
        self.addSubview(bg);
        
        let width=bg.frame.size.width;
        
        self.company=createLabel(withFrame: CGRect(x: 10, y: 16, width: 150, height: 14), andAlignment: NSTextAlignment.left, andText: "联运汇物流公司", andTextColor: UIColor.black, andFontSize: 14);
        bg.addSubview(self.company!);
        
        self.status=createLabel(withFrame: CGRect(x: width-90, y: 16, width: 60, height: 14), andAlignment: NSTextAlignment.right, andText: "正常签收", andTextColor: UIColor.black, andFontSize: 14);
        bg.addSubview(self.status!);
        
        
        self.waybillNum=createLabel(withFrame: CGRect(x: 10, y: self.company!.frame.maxY+10, width: 200, height: 10), andAlignment: NSTextAlignment.left, andText: "运单号:DS123456789", andTextColor: UIColor.black, andFontSize: 11);
        bg.addSubview(self.waybillNum!);
        
        
        self.orderNum=createLabel(withFrame: CGRect(x: 10, y: self.waybillNum!.frame.maxY+5, width: 200, height: 10), andAlignment: NSTextAlignment.left, andText: "订单号:DS123456789", andTextColor: UIColor.black, andFontSize: 11);
        bg.addSubview(self.orderNum!);
        
        
        self.money=createLabel(withFrame: CGRect(x: width-110, y: self.status!.frame.maxY+8, width: 80, height: 14), andAlignment: NSTextAlignment.right, andText: "￥265.00", andTextColor: UIColor.black, andFontSize: 14);
        bg.addSubview(self.money!);
        
        
        self.forwardIV=createImageView(withFrame: CGRect(x: width-19, y: (58-12)/2, width: 7, height: 12), andImageName: "list_forward");
        bg.addSubview(self.forwardIV!);
        
        let line1=createHorizontalLine(withX: 5, andY: 72, andWidth: CGFloat(ScreenWidth()-30));
        bg.addSubview(line1);
        
        
        self.extractImage=createImageView(withFrame: CGRect(x: 9, y: 16+72, width: 19, height: 19), andImageName: "list_give");
        bg.addSubview(self.extractImage!);
        
        self.extractPlace=createLabel(withFrame: CGRect(x: self.extractImage!.frame.maxX+6, y: 85, width: 200, height: 12), andAlignment: NSTextAlignment.left, andText: "广州市白云区新市镇齐富路189号", andTextColor: UIColor.black, andFontSize: 13);
        bg.addSubview(self.extractPlace!);
        
        self.extractLink=createLabel(withFrame: CGRect(x: self.extractImage!.frame.maxX+6, y: self.extractPlace!.frame.maxY+6, width: 150, height: 12), andAlignment: NSTextAlignment.left, andText: "张三 13669694587", andTextColor: UIColorFromHexValue(0x999999), andFontSize: 11);
        bg.addSubview(self.extractLink!);
        
        
        self.extractPhoneBtn=createButtonWithImage(withFrame: CGRect(x: width-37, y: 77, width: 40, height: 40), andImage: UIImage.init(named: "list_phone")!);
        self.extractPhoneBtn?.imageEdgeInsets=UIEdgeInsets.init(top: 7.5, left: 0, bottom: 7.5, right: 15);
        bg.addSubview(self.extractPhoneBtn!);
        self.extractPhoneBtn?.addTarget(self, action: #selector(phoneButEvent(_:)), for: UIControlEvents.touchUpInside);
        
        let line2=createDottedLine(withFrame: CGRect.init(x: 5, y: 112, width: ScreenWidth()-30, height: 20));
        bg.addSubview(line2);
        
        self.tianmaoImage=createImageView(withFrame: CGRect(x: width/2, y: 90, width: 98.5, height: 65.5), andImageName: "list_seal");
        self.tianmaoImage?.isHidden=true;
        bg.addSubview(self.tianmaoImage!);
        
        
        self.describe=createLabel(withFrame: CGRect(x: 10, y: 127, width: width-20, height: 40), andAlignment: NSTextAlignment.left, andText: "物品:路易拉菲实木床欧式床*2,路易拉菲实木床欧式床头柜*2,梳妆台*2", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 14);
        bg.addSubview(self.describe!);
        
        
        let line3=createHorizontalLine(withX: 5, andY: 180, andWidth: CGFloat(ScreenWidth()-30));
        bg.addSubview(line3);
        
        
        self.time=createLabel(withFrame: CGRect(x: 10, y: 180, width: width/2-20, height: 50), andAlignment: NSTextAlignment.left, andText: "下单时间:", andTextColor: UIColorFromHexValue(0x999999), andFontSize: 13);
        self.time?.adjustsFontSizeToFitWidth=true;
        bg.addSubview(self.time!);
        
        
        self.timeoutLabel=createLabel(withFrame: CGRect(x: width/2-10, y: 180, width: width/2-80+10, height: 50), andAlignment: NSTextAlignment.left, andText: "超时:8h", andTextColor: UIColorFromHexValue(0xd64242), andFontSize: 13);
        self.timeoutLabel?.isHidden=true;
        bg.addSubview(self.timeoutLabel!);
        
        
        self.btn1=createButtonWithTtile(withFrame: CGRect(x: width-80, y: 190, width: 75, height: 27), andTtile: "提醒发车", andTintColor: UIColor.white, andFontSize: 14);
        self.btn1?.backgroundColor=UIColorFromRGB(R: 94, G: 125, B: 176);
        self.btn1?.layer.cornerRadius=CGFloat(TheRoundedAmplitude);
        self.btn1?.layer.masksToBounds=true;
        bg.addSubview(self.btn1!);
        self.btn1?.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControlEvents.touchUpInside);
        
        
        let line4=createHorizontalLine(withX: 0, andY: bg.frame.size.height-CGFloat(LINEHEIGHT), andWidth: width);
        bg.addSubview(line4);
        
    }
    
    //MARK:- set cell value event
    func setCellValue(withDict dict:Dictionary<String,AnyObject>?) {
        
        self.company?.text=dict?["companyName"] as? String;
        self.status?.text=dict?["orderStateName"] as? String;
        
        self.waybillNum?.text=String.init(format: "运单号:%@", dict?["trackingNum"] as! String);
        self.orderNum?.text=String.init(format: "订单号:%@", dict?["sellerOrderId"] as! String);
        
        self.money?.text=dict?["totalFee"] as? String;
        
        self.extractPlace?.text=dict?["receiverAddress"] as? String;
        self.extractLink?.text=String.init(format: "%@ %@", dict?["receiverName"] as! String,dict?["receiverTel"] as! String);
        
        self.extractPhone=dict?["receiverTel"] as! String;
        
        let isTmail=dict?["isTmail"];
        if isTmail != nil && isTmail!.isEqual(to: "1") {
            self.tianmaoImage?.isHidden=false;
        }else{
            self.tianmaoImage?.isHidden=true;
        };
        
        self.describe?.text=String.init(format: "物品:%@", dict?["goodsDesc"] as! String);
        
        self.time?.text=String.init(format: "开单时间:%@", dict?["createDate"] as! String);
        
        self.zxPhone=dict?["zxPhone"] as! String;
        
        let timeOut=dict?["timeOutNum"];
        if timeOut != nil {
            self.timeoutLabel?.text=String.init(format: "超时:%@", dict?["timeOutNum"] as! String);
        };
        
    }
    
    //MARK:- button event
    func phoneButEvent(_ sender:UIButton) {
        print("phone Button event");
    }
    
    func buttonEvent(_ sender:UIButton) {
        print("button event");
    }
    
    
}

