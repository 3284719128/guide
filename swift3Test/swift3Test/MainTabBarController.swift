//
//  MainTabBarController.swift
//  swiftTest
//
//  Created by 43696467 on 2016/9/22.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var buttonView:UIView?;

    //MARK:- system method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hiddenTabBar();
        self.drawTabbarItmes();
        self.createViewControllers();
        
    }
    
    //MARK:- draw view
    func hiddenTabBar() {
        
        let subViews=self.view.subviews;
        for item in subViews {
            
            if item.isKind(of: UITabBar.self) {
                item.isHidden=true;
                break;
            };
        };
        
    }
    
    func drawTabbarItmes() {
        
        self.buttonView=createBGView(withFrame: CGRect.init(x: 0, y: ScreenHeight()-Double(TabBarHight), width: ScreenWidth(), height: Double(TabBarHight)), andBackgroundColor: UIColor.white);
        self.view.addSubview(self.buttonView!);
        
        self.createTabbarItem(withColumn: 1, andImageName: "menu_homepage_on", andLabelName: "首页", andSuperView: self.buttonView!);
        
        self.createTabbarItem(withColumn: 2, andImageName: "menu_analyze_off.png", andLabelName: "分析", andSuperView: self.buttonView!);

        self.createTabbarItem(withColumn: 3, andImageName: "menu_personage_off", andLabelName: "我的", andSuperView: self.buttonView!);
        
        
        let line=createHorizontalLine(withX: 0, andY: 0, andWidth: CGFloat(ScreenWidth()));
        self.buttonView?.addSubview(line);
        
    }
    
    func createTabbarItem(withColumn column:Double,andImageName imageName:String,andLabelName labelName:String,andSuperView superView:UIView) {
        
        let xPoint=ScreenWidth()/3*(column-1);
        let button=createButtonWithEmpty(withFrame: CGRect.init(x: xPoint, y: 0, width: ScreenWidth()/3, height: Double(TabBarHight)));
        superView.addSubview(button);
        button.tag=100+Int(column);
        button.addTarget(self, action: #selector(tabbarButtonEvent(_:)), for: UIControlEvents.touchUpInside);
        
        let imageV=createImageView(withFrame: CGRect.init(x: 0, y: 0, width: 20, height: 20), andImageName: imageName);
        imageV.center=CGPoint.init(x: button.center.x, y: button.center.y-10);
        superView.addSubview(imageV);
        imageV.tag=200+Int(column);
        
        let label=createLabel(withFrame: CGRect.init(x: 0, y: 0, width: ScreenWidth()/3, height: 20), andAlignment: NSTextAlignment.center, andText: labelName, andTextColor: UIColor.black, andFontSize: 12);
        label.center=CGPoint.init(x: button.center.x, y: button.center.y+10);
        superView.addSubview(label);
        label.tag=300+Int(column);
        if column == 1 {
            label.textColor=UIColor.orange;
        };
        
    }
    
    //MARK:- create ViewControllers event
    func createViewControllers() {
        
        let homePageVC=HomePageViewController();
        let analysisVC=AnalysisViewController();
        let personalCenterVC=PersonalCenterViewController();
        
        let navigationC1=UINavigationController.init(rootViewController: homePageVC);
        let navigationC2=UINavigationController.init(rootViewController: analysisVC);
        let navigationC3=UINavigationController.init(rootViewController: personalCenterVC);
        
        navigationC1.navigationBar.isHidden=true;
        navigationC2.navigationBar.isHidden=true;
        navigationC3.navigationBar.isHidden=true;
        
        self.viewControllers=[navigationC1,navigationC2,navigationC3];
        
        self.selectedIndex=0;
        
    }
    
    //MARK:- tabbar Button Event
    func tabbarButtonEvent(_ sender:UIButton) {
        
        self.changeTabbarItem();
        
        switch sender.tag {
        case 101:
            let image=self.buttonView?.viewWithTag(201) as! UIImageView;
            image.image=UIImage.init(named: "menu_homepage_on");
            let label=self.buttonView?.viewWithTag(301) as! UILabel;
            label.textColor=UIColor.orange;
            self.selectedIndex=0;
            break
        case 102:
            let image=self.buttonView?.viewWithTag(202) as! UIImageView;
            image.image=UIImage.init(named: "menu_analyze_on");
            let label=self.buttonView?.viewWithTag(302) as! UILabel;
            label.textColor=UIColor.orange;
            self.selectedIndex=1;
            break
        case 103:
            let image=self.buttonView?.viewWithTag(203) as! UIImageView;
            image.image=UIImage.init(named: "menu_personage_on");
            let label=self.buttonView?.viewWithTag(303) as! UILabel;
            label.textColor=UIColor.orange;
            self.selectedIndex=2;
            break
        default:
            
            break
        }
        
    }
    
    func changeTabbarItem() {

        let image1=self.buttonView?.viewWithTag(201) as! UIImageView;
        image1.image=UIImage.init(named: "menu_homepage_off");
        
        let image2=self.buttonView?.viewWithTag(202) as! UIImageView;
        image2.image=UIImage.init(named: "menu_analyze_off");
        
        let image3=self.buttonView?.viewWithTag(203) as! UIImageView;
        image3.image=UIImage.init(named: "menu_personage_off");
        
        let label1=self.buttonView?.viewWithTag(301) as! UILabel;
        label1.textColor=UIColor.black;
        
        let label2=self.buttonView?.viewWithTag(302) as! UILabel;
        label2.textColor=UIColor.black;
        
        let label3=self.buttonView?.viewWithTag(303) as! UILabel;
        label3.textColor=UIColor.black;
        
    }

    //MARK:- hidden Tabbar Event
    func hiddenTabbarEvent(withBool bool:Bool) {
        
        self.buttonView?.isHidden=bool;
    }
    
    
    //MARK:- other event
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
