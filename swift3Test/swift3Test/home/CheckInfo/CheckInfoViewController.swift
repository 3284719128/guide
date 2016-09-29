//
//  CheckInfoViewController.swift
//  swift3Test
//
//  Created by 43696467 on 2016/9/27.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class CheckInfoViewController: BaseViewController {
    
    var orderNumLabel:UILabel!;
    var weightNumLabel:UILabel!;
    
    var volumeNumLabel:UILabel!;
    var countNumLabel:UILabel!;

    var freightCountLabel:UILabel!;
    var installCostsCountLabel:UILabel!;

    override func viewDidLoad() {
        super.viewDidLoad()

        self.drawView();
        self.getNetworkData();
        
    }
    
    //MARK:- draw view event
    func drawView() {
        
        self.titleLabel.text="信息详情";
        
        self.orderNumLabel=self.drawDetailBar(withTitleStr: "总单量:", andContentStr: "0单", andRow: 1, andSuperView: self.view);
        self.weightNumLabel=self.drawDetailBar(withTitleStr: "总重量:", andContentStr: "0吨", andRow: 2, andSuperView: self.view);
        
        self.volumeNumLabel=self.drawDetailBar(withTitleStr: "总方数:", andContentStr: "0方", andRow: 3, andSuperView: self.view);
        self.countNumLabel=self.drawDetailBar(withTitleStr: "总件数:", andContentStr: "0件", andRow: 4, andSuperView: self.view);
        
        self.freightCountLabel=self.drawDetailBar(withTitleStr: "总运费:", andContentStr: "￥0", andRow: 5, andSuperView: self.view);
        self.installCostsCountLabel=self.drawDetailBar(withTitleStr: "总配安费:", andContentStr: "￥0", andRow: 6, andSuperView: self.view);
        
        
    }
    
    func drawDetailBar(withTitleStr titleStr:String,andContentStr contentStr:String,andRow row:Int,andSuperView superView:UIView) ->UILabel {
    
        
        var yPoint=Double((row-1)*50)+NavigationBarHeight+10;
        
        switch row {
        case 3:
            yPoint += 10;
            break;
        case 4:
            yPoint += 10;
            break;
        case 5:
            yPoint += 20;
            break;
        case 6:
            yPoint += 20;
            break;
        default:
            
            break;
        };
        
        let bgV=createBGView(withFrame: CGRect.init(x: 0, y: yPoint, width: ScreenWidth(), height: 50), andBackgroundColor: UIColor.white);
        superView.addSubview(bgV)
        
        let titleLabel=createLabel(withFrame: CGRect.init(x: 0, y: 0, width: 80, height: 50), andAlignment: NSTextAlignment.right, andText: titleStr, andTextColor: UIColor.black, andFontSize: 15);
        bgV.addSubview(titleLabel);
        
        let contentLabel=createLabel(withFrame: CGRect.init(x: 90, y: 0, width: ScreenWidth()-90, height: 50), andAlignment: NSTextAlignment.left, andText: contentStr, andTextColor: UIColor.black, andFontSize: 15);
        bgV.addSubview(contentLabel);
        
        let line=createHorizontalLine(withX: 0, andY: 49.5, andWidth: CGFloat(ScreenWidth()));
        bgV.addSubview(line);
        
        return contentLabel;
        
    }
    
    //MARK:- 获取网络数据
    func getNetworkData()  {
        
        let dict:[String:Any]=[
            
            "receiverTel" : "13800138010",
        
            ];
        
        
        BaseRequest.request(WithInCode: "10086", andParamsDict: dict) { (contentDict:[String:Any], message:String) -> (Void) in
            
            if let array=contentDict["items"] as? Array<Any> {
                
                let dict=array[0] as! Dictionary<String,AnyObject>;
                
                self.orderNumLabel.text="95单";
                self.weightNumLabel.text="100吨";
                
                self.volumeNumLabel.text="1000方";
                self.countNumLabel.text="1000件";
                
                self.freightCountLabel.text="￥6000.00";
                self.installCostsCountLabel.text="￥1000.00";
                
                print("dict:\(dict)");
                print("message:\(message)");
                
            };
            
        };
        
    }


    //MARK:- other event
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
