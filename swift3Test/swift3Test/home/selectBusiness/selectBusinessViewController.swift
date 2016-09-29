//
//  selectBusinessViewController.swift
//  swift3Test
//
//  Created by 43696467 on 2016/9/27.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class selectBusinessViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    var businessLabel:UILabel!;
    
    var tableView:UITableView!;
    var itemsArray=[Any]();
    
    var titleStr:String="";
    
    var callbackFunc:((_ name:String)->Void)?;


    //MARK:- system method
    init(WithTitleStr str:String) {
        super.init(nibName: nil, bundle: nil);
        self.titleStr=str;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.drawView();
        self.createTableView();
        self.getNetworkData();
        
    }
    
    //MARK:- draw view event
    func drawView() {
        
        self.titleLabel.text="选择商家";
        
        let label1=createLabel(withFrame: CGRect.init(x: 15, y: NavigationBarHeight, width: ScreenWidth(), height: 40), andAlignment: NSTextAlignment.left, andText: "当前商家", andTextColor: UIColor.black, andFontSize: 15);
        self.view.addSubview(label1);
        
        self.businessLabel=createLabel(withFrame: CGRect.init(x: 0, y: Double(label1.frame.maxY), width: ScreenWidth(), height: 50), andAlignment: NSTextAlignment.center, andText: self.titleStr, andTextColor: UIColor.black, andFontSize: 15);
        self.view.addSubview(self.businessLabel);
        self.businessLabel.backgroundColor=UIColor.white;
        
        let label2=createLabel(withFrame: CGRect.init(x: 15, y: Double(self.businessLabel.frame.maxY), width: ScreenWidth(), height: 40), andAlignment: NSTextAlignment.left, andText: "商家列表", andTextColor: UIColor.black, andFontSize: 15);
        self.view.addSubview(label2);
        
    }
    
    func createTableView() {
        
        tableView=UITableView.init(frame: CGRect.init(x: 0, y: Double(self.businessLabel.frame.maxY)+40, width: ScreenWidth(), height: ScreenHeight()-(Double(self.businessLabel.frame.maxY)+40)));
        tableView.showsHorizontalScrollIndicator = false;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor.white;
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
        self.view.addSubview(tableView);
        
    }
    
    //MARK:- UITableViewDelegate
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.itemsArray.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell=selectBusinessViewCell.createCell(withTableView: tableView);
        cell.nameLabel.text=self.itemsArray[indexPath.row] as? String;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40;
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let str=self.itemsArray[indexPath.row] as? String;
        self.businessLabel.text=str;
        
    }
    
    
    //MARK:- getData event
    func getNetworkData() {
        
        let array=["慕溪商家","汇运公司","通天下公司","天河公司","申天公司","北方公司","势力公司","握公司","绿城公司","大界公司"];
        self.itemsArray=array;
        self.tableView.reloadData();
        
    }
    
    //MARK:- override super method
    override func backButtonAction(_ sender:UIButton?) {
        
        self.callbackFunc!(self.businessLabel.text!);
        self.navigationController!.popViewController(animated: true);
    }

    //MARK:- other event
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
