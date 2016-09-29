//
//  TaskTableViewController.swift
//  swift3Test
//
//  Created by 43696467 on 2016/9/27.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class TaskTableViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource{
    
    var tableView:UITableView=UITableView(frame: CGRect.init(x: 0, y: NavigationBarHeight, width: ScreenWidth(), height: ScreenHeight()-NavigationBarHeight));
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
        
        tableView.showsHorizontalScrollIndicator = false;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor.clear;
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        self.view.addSubview(tableView);
        
        
    }
    
    //MARK:- 获取网络数据
    func getNetworkData()  {
        
        let dict:[String:Any]=[
            
            "companyName" : "汇通天下物流公司",
            "createDate" : "09-27 09:47",
            "goodsDesc" : "货柜",
            "isTmail" : "2",
            "orderId" : "145",
            "orderStateName" : "已发车",
            "orderTime" : "09-27 09:47",
            "receiverAddress" : "科学大道162号",
            "receiverName" : "张三",
            "receiverTel" : "13800138010",
            "remarks" : "",
            "sellerOrderId" : "",
            "totalFee" : "521.00",
            "trackingNum" : "1410000365",
            "zxPhone" : "13800138004",
            
            ];
    
        
        BaseRequest.request(WithInCode: "10086", andParamsDict: dict) { (contentDict:[String:Any], message:String) -> Void in
            
            if let array=contentDict["items"] as? Array<Any> {
                
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
