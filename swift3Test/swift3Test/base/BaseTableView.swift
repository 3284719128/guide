//
//  BaseTableView.swift
//  swift3Test
//
//  Created by 43696467 on 2016/9/30.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {

    var headerCallbackFunc:(()->Void)!;
    var footerCallbackFunc:(()->Void)!;

    //MARK:- system method
    init(WithFrame frame:CGRect,andHeaderCallbackFunc headerCallbackFunc:(()->Void)!,andFooterCallbackFunc footerCallbackFunc:(()->Void)!) {
        
        super.init(frame: frame, style: UITableViewStyle.plain);
        self.headerCallbackFunc=headerCallbackFunc;
        self.footerCallbackFunc=footerCallbackFunc;
        self.addMJRefresh();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- add mjrefresh event
    func addMJRefresh() {
        
        self.mj_header=MJRefreshNormalHeader();
        self.mj_header.setRefreshingTarget(self, refreshingAction: #selector(headerRefreshing));
        
        self.mj_footer=MJRefreshAutoNormalFooter();
        self.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefreshing));
        
    }
    
    func headerRefreshing() {
        
        self.headerCallbackFunc();
    }
    
    func footerRefreshing() {
        
        self.footerCallbackFunc();
    }

}
