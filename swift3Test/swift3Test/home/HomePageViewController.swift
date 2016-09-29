//
//  HomePageViewController.swift
//  swiftTest
//
//  Created by 43696467 on 2016/9/22.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit


struct Student {
    
    var id:String;
    init(withID ID:String) {
        id=ID;
    }
    
}

enum CompassPoint:String {
    case North="14"
    case South
}


class HomePageViewController: BaseViewController {
    
    var buttonView:UIView!;
    
    var rightLabel2:UILabel!;

    //MARK:- system method
    override func viewDidLoad() {
        super.viewDidLoad()

        self.drawView();
        
        
        let st=Student.init(withID: "13");
        print("student id:\(st.id)");
        
        let nor=CompassPoint.North;
        print("enum:\(nor)");
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getMainTabBarController().hiddenTabbarEvent(withBool: false);
        
    }
    
    //MARK:- draw view
    func drawView() {
        
        self.backButton.isHidden=true;
        self.backImage.isHidden=true;
        
        self.navigation();
        self.createButtonView();
        
    }

    func navigation() {
        
        let logoIV=createImageView(withFrame: CGRect.init(x: 15, y: 34, width: 96.5, height: 22), andImageName: "LOGO");
        self.view.addSubview(logoIV);
        
        self.rightLabel2=createLabel(withFrame: CGRect.init(x: ScreenWidth()/3*2-15, y: 20, width: ScreenWidth()/3, height: 50), andAlignment: NSTextAlignment.right, andText: "慕溪商家", andTextColor: UIColor.white, andFontSize: 15);
        self.view.addSubview(self.rightLabel2);
        
        let rightButton=createButtonWithEmpty(withFrame: CGRect.init(x: self.rightLabel2.frame.minX, y: 20, width: self.rightLabel2.frame.width, height: 50));
        self.view.addSubview(rightButton);
        rightButton.addTarget(self, action: #selector(rightButtonAction(_:)), for: UIControlEvents.touchUpInside);
        
    }
    
    func createButtonView() {
        
        self.buttonView=createBGView(withFrame: CGRect.init(x: 0, y: NavigationBarHeight, width: ScreenWidth(), height: ScreenHeight()-NavigationBarHeight-Double(TabBarHight)), andBackgroundColor: UIColor.clear);
        self.view.addSubview(self.buttonView);
        
        let width=self.buttonView.frame.width;
        let height=self.buttonView.frame.height;
        
        let line1=createHorizontalLine(withX: 0, andY: height/4*1, andWidth: width);
        self.buttonView.addSubview(line1);
        
        let line2=createHorizontalLine(withX: 0, andY: height/4*2, andWidth: width);
        self.buttonView.addSubview(line2);
        
        let line3=createHorizontalLine(withX: 0, andY: height/4*3, andWidth: width);
        self.buttonView.addSubview(line3);
        
        let verLine=createVerticalLine(withX: width/2, andY: 0, andHeight: height);
        self.buttonView.addSubview(verLine);
        
        self.createButtonViewItem(withImageName: "home_directory_odd", andTitleStr: "待开单", andRemarksStr: "等待开单...", andImageWidth: 60, andImageHeight: 61, andRow: 1, andColumn: 1, andSuperView: self.buttonView);
        self.createButtonViewItem(withImageName: "home_directory_car", andTitleStr: "待发车", andRemarksStr: "等待发车...", andImageWidth: 66, andImageHeight: 50, andRow: 1, andColumn: 2, andSuperView: self.buttonView);
        self.createButtonViewItem(withImageName: "home_directory_car2", andTitleStr: "运输中", andRemarksStr: "物流进行中...", andImageWidth: 66, andImageHeight: 50, andRow: 2, andColumn: 1, andSuperView: self.buttonView);
        self.createButtonViewItem(withImageName: "home_directory_worker", andTitleStr: "待配送", andRemarksStr: "等待配送...", andImageWidth: 67, andImageHeight: 62, andRow: 2, andColumn: 2, andSuperView: self.buttonView);
        self.createButtonViewItem(withImageName: "home_directory_sign", andTitleStr: "待签收", andRemarksStr: "物流进行中...", andImageWidth: 59, andImageHeight: 62, andRow: 3, andColumn: 1, andSuperView: self.buttonView);
        self.createButtonViewItem(withImageName: "home_directory_signed", andTitleStr: "已签收", andRemarksStr: "已完成签收!", andImageWidth: 59, andImageHeight: 62, andRow: 3, andColumn: 2, andSuperView: self.buttonView);
        
        self.createButtonViewItem(withImageName: "home_Timeout orders", andTitleStr: "查看信息", andRemarksStr: "查看信息详情", andImageWidth: 45, andImageHeight: 44, andRow: 4, andColumn: 1, andSuperView: self.buttonView);
        self.createButtonViewItem(withImageName: "home_problem shipment", andTitleStr: "提货通知", andRemarksStr: "发布提货通知", andImageWidth: 51, andImageHeight: 37, andRow: 4, andColumn: 2, andSuperView: self.buttonView);
        
        
    }
    
    func createButtonViewItem(withImageName imageName:String,andTitleStr titleStr:String,andRemarksStr remarksStr:String,andImageWidth imageWidth:Int,andImageHeight imageHeight:Int,andRow row:Int,andColumn column:Int,andSuperView superView:UIView) {
        
        let buttonWidth=superView.frame.size.width/2;
        let buttonHeight=superView.frame.size.height/4
        
        let x = column%2 ==  0 ? CGFloat(1) : CGFloat(0);
        let y=buttonHeight*(CGFloat(row)-1);
        
        
        let imageV=createImageView(withFrame: CGRect.init(x: Int(buttonWidth*x+21), y: Int(y)+(Int(buttonHeight)-imageHeight)/2, width: imageWidth, height: imageHeight), andImageName: imageName);
        superView.addSubview(imageV);
        
        let labelY=y+(buttonHeight-38)/2;
        let titleLabel=createLabel(withFrame: CGRect.init(x: buttonWidth*x+75, y: labelY, width: buttonWidth-75, height: 15), andAlignment: NSTextAlignment.left, andText: titleStr, andTextColor: UIColor.black, andFontSize: 15);
        superView.addSubview(titleLabel);
        
        
        let remarksLabel=createLabel(withFrame: CGRect.init(x: buttonWidth*x+75, y: titleLabel.frame.maxY+8, width: buttonWidth-75, height: 15), andAlignment: NSTextAlignment.left, andText: remarksStr, andTextColor: UIColorFromRGB(R: 153, G: 153, B: 153), andFontSize: 12);
        superView.addSubview(remarksLabel);
        
        let button=createButtonWithEmpty(withFrame: CGRect.init(x: buttonWidth*x, y: y, width: buttonWidth, height: buttonHeight));
        button.tag=row*10+column;
        button.addTarget(self, action: #selector(buttonAction(_:)), for: UIControlEvents.touchUpInside);
        superView.addSubview(button);
        
    }
    
    
    func buttonAction(_ sender:UIButton) {
        
        print("tag===\(sender.tag)");
        
        switch sender.tag {
        case 11:
            self.skipViewController(WithTitleStr: "待开单");
            break
        case 12:
            self.skipViewController(WithTitleStr: "待发车");
            break
        case 21:
            self.skipViewController(WithTitleStr: "运输中");
            break
        case 22:
            self.skipViewController(WithTitleStr: "待配送");
            break
        case 31:
            self.skipViewController(WithTitleStr: "待签收");
            break
        case 32:
            self.skipViewController(WithTitleStr: "已签收");
            break
        case 41:
            
            self.navigationController?.pushViewController(CheckInfoViewController(), animated: true);
            break
        case 42:
            self.navigationController?.pushViewController(DeliveryNoticeViewController(), animated: true);
            break
        default:
            
            break
        }
        
    }
    
    func skipViewController(WithTitleStr str:String) {
        
        let VC=TaskTableViewController.init(WithTitleStr: str);
        self.navigationController?.pushViewController(VC, animated: true);
        
    }
    
    //MARK:- right button action
    func rightButtonAction(_ sender:UIButton) {
        
        let VC=selectBusinessViewController.init(WithTitleStr: self.rightLabel2.text!);
        VC.callbackFunc={(name:String) -> Void in
            
            self.rightLabel2.text=name;
            
        };
        self.navigationController?.pushViewController(VC, animated: true);
    }
    
    
    //MARK:- other event
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
