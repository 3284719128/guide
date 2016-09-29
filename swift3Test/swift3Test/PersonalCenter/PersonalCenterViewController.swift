//
//  PersonalCenterViewController.swift
//  swift3Test
//
//  Created by 43696467 on 2016/9/28.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class PersonalCenterViewController: BaseViewController {

    //MARK:- system method
    override func viewDidLoad() {
        super.viewDidLoad()

        self.drawView();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getMainTabBarController().hiddenTabbarEvent(withBool: false);
    }
    
    //MARK:- draw view event
    func drawView() {
        
        self.titleLabel.text="个人中心";
        self.backImage.isHidden=true;
        self.backButton.isHidden=true;
        
        let personalCenterV=PersonalCenterView.init(frame: CGRect.init(x: 0, y: NavigationBarHeight, width: ScreenWidth(), height: ScreenHeight()-NavigationBarHeight-TabBarHight));
        self.view.addSubview(personalCenterV);
        
    }

    //MARK:- other event
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
