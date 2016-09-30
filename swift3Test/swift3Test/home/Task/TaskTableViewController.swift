//
//  TaskTableViewController.swift
//  swift3Test
//
//  Created by 43696467 on 2016/9/27.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class TaskTableViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource{
    
    var tableView:BaseTableView!;
    var itemsArray:[Any]=[Any]();
    
    var titleStr: String!="";
    
    
    //MARK:- system method
    init(WithTitleStr str:String) {
        super.init(nibName: nil, bundle: nil);
        self.titleStr=str;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.drawView();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getMainTabBarController().hiddenTabbarEvent(withBool: true);
        self.getNetworkData();
    }
    
    
    //MARK:- draw view event
    func drawView()  {
        
        self.titleLabel.text=self.titleStr;
        
        self.tableView=BaseTableView.init(WithFrame: CGRect.init(x: 0, y: NavigationBarHeight, width: ScreenWidth(), height: ScreenHeight()-NavigationBarHeight), andHeaderCallbackFunc: {
             self.getNetworkData();
            }, andFooterCallbackFunc: {
             self.getNetworkData();
        })
        self.tableView.showsHorizontalScrollIndicator = false;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = UIColor.clear;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        self.view.addSubview(self.tableView);
        
    }

    
    //MARK:- 获取网络数据
    func getNetworkData()  {
        
        let dict:[String:Any]=[
            
            "receiverTel" : "13800138010",

            ];
    
        
        BaseRequest.request(WithInCode: "10086", andParamsDict: dict) { (contentDict:[String:Any], message:String) -> Void in
            
            if let array=contentDict["items"] as? Array<Any> {
                
                self.tableView.mj_header.endRefreshing();
                self.tableView.mj_footer.endRefreshing();
                
                self.itemsArray=array;
                self.tableView .reloadData();
                print("message:\(message)");
                
            };
    
        };

    }
    
    //MARK:- UITableViewDelegate
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.itemsArray.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell=TadkTableViewCell.createCell(withTableView: tableView);
        let dict:Dictionary<String,AnyObject>?=self.itemsArray[indexPath.row] as? Dictionary<String,AnyObject>;
        cell.setCellValue(withDict: dict);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 237;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict:Dictionary<String,AnyObject>?=self.itemsArray[indexPath.row] as? Dictionary<String,AnyObject>;
        let VC=TaskDetailViewController.init(withParamsDict: dict);
        self.navigationController?.pushViewController(VC, animated: true);
        
    }
    
    //MARK:- other event
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //FIXME:有bug
    //TODO:下次继续
    
}
