//
//  TaskDetailViewController.swift
//  swiftTest
//
//  Created by 43696467 on 2016/9/23.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class TaskDetailViewController: BaseViewController {
    
    var paramsDict:Dictionary<String,AnyObject>?;
    
    //MARK:- system method
    init(withParamsDict dict:Dictionary<String,AnyObject>?) {
        
        super.init(nibName: nil, bundle: nil);
        self.paramsDict=dict;
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.drawView();
    
    }
    
    //MARK:- draw view event
    func drawView() {
        
        self.titleLabel.text="订单详情";
        
        let detailV=TaskDetailView(frame:CGRect.init(x: 0, y: NavigationBarHeight, width: ScreenWidth(), height: ScreenHeight()-NavigationBarHeight));
        self.view.addSubview(detailV);
        
    }

    //MARK:- other event
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
