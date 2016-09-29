//
//  BaseViewController.swift
//  swift3Test
//
//  Created by 43696467 on 2016/9/27.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var navView:UIView!;
    
    var backImage:UIImageView!;
    var backButton:UIButton!;
    
    var titleLabel:UILabel!;
    
    var rightButton:UIButton!;
    var rightLabel:UILabel!;

    //MARK:- sysytem method
    override func viewDidLoad() {
        super.viewDidLoad()

        self.drawSuperView();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getMainTabBarController().hiddenTabbarEvent(withBool: true);
        
    }
    
    //MARK:- draw view event
    func drawSuperView() {
        
        self.view.backgroundColor=UIColorFromHexValue(Int(MainColor));
        
        self.navView=createBGView(withFrame: CGRect.init(x: 0, y: 0, width: ScreenWidth(), height: NavigationBarHeight), andBackgroundColor: UIColorFromHexValue(Int(NavigationBarColor)));
        self.view.addSubview(self.navView);
        
        self.backImage=createImageView(withFrame: CGRect.init(x: 15, y: 34, width: 12, height: 22), andImageName: "header_return");
        self.view.addSubview(self.backImage);
        
        self.backButton=createButtonWithEmpty(withFrame: CGRect.init(x: 0, y: 20, width: 100, height: 50));
        self.view.addSubview(self.backButton);
        self.backButton.addTarget(self, action: #selector(backButtonAction(_:)), for: UIControlEvents.touchUpInside);
        
        self.titleLabel=createLabel(withFrame: CGRect.init(x: 100, y: 20, width: ScreenWidth()-200, height: 50), andAlignment: NSTextAlignment.center, andText: "", andTextColor: UIColor.white, andFontSize: 15);
        self.view.addSubview(self.titleLabel);
        
        self.rightLabel=createLabel(withFrame: CGRect.init(x: ScreenWidth()-100, y: 20, width: 85, height: 50), andAlignment: NSTextAlignment.right, andText: "", andTextColor: UIColor.white, andFontSize: 15);
        self.view.addSubview(self.rightLabel);
        
        self.rightButton=createButtonWithEmpty(withFrame: CGRect.init(x: ScreenWidth()-100, y: 20, width: 100, height: 50));
        self.view.addSubview(self.rightButton);

        
    }
    
    //MARK:- back button action
    func backButtonAction(_ sender:UIButton) {
        
        self.navigationController!.popViewController(animated: true);
    }


    //MARK:- other event
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
