//
//  AnalysisViewController.swift
//  swift3Test
//
//  Created by 43696467 on 2016/9/28.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class AnalysisViewController: BaseViewController {
    
    var scrollV:UIScrollView!;
    
    var lineChart:JHLineChart!;
    
    var ring:JHRingChart!;
    
    var halfYearBut:UIButton!;
    var yearBut:UIButton!;
    

    //MARK:- system method
    override func viewDidLoad() {
        super.viewDidLoad()

        self.drawView();
        self.showLineChartView(WithXDataArray: ["4月","5月","6月","7月","8月","9月"], andValueArray: ["0","50","0","40","0","200"]);
        self.showRingChartView();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getMainTabBarController().hiddenTabbarEvent(withBool: false);
    }
    
    //MARK:- draw view event
    func drawView() {
        
        self.titleLabel.text="分析";
        self.backImage.isHidden=true;
        self.backButton.isHidden=true;
        
        self.scrollV=UIScrollView.init(frame: CGRect.init(x: 0, y: NavigationBarHeight, width: ScreenWidth(), height: ScreenHeight()-NavigationBarHeight-TabBarHight));
        self.scrollV.backgroundColor=UIColor.clear;
        self.scrollV.contentSize=CGSize.init(width: ScreenWidth(), height: 490);
        self.view.addSubview(self.scrollV);
        
        self.createLineChart();
        self.createRingChart();
        
    }
    
    //MARK:- LineChart event
    func createLineChart() {
        
        let lineChartBgV=createBGView(withFrame: CGRect.init(x: 0, y: 0, width: ScreenWidth(), height: 180), andBackgroundColor: UIColor.white);
        self.scrollV.addSubview(lineChartBgV);
        
        let lineY=lineChartBgV.frame.height-CGFloat(LINEHEIGHT);
        let line=createHorizontalLine(withX: 0, andY: lineY, andWidth: CGFloat(ScreenWidth()));
        lineChartBgV.addSubview(line);
        
        self.lineChart=JHLineChart.init(frame: CGRect.init(x: 10, y: 50, width: ScreenWidth()-20, height: ScreenWidth() / 320 * 115), andLineChartType: JHLineChartType.chartLineEveryValueForEveryX);
        self.lineChart.lineChartQuadrantType=JHLineChartQuadrantType.firstQuardrant;
        lineChartBgV.addSubview(self.lineChart);
        
        let headLabel=createLabel(withFrame: CGRect.init(x: 15, y: 0, width: 100, height: 50), andAlignment: NSTextAlignment.left, andText: "总单量趋势图", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 15);
        lineChartBgV.addSubview(headLabel);
        
        self.halfYearBut=createButtonWithTtile(withFrame: CGRect.init(x: ScreenWidth()-105, y: 10, width: 40, height: 30), andTtile: "半年", andTintColor: UIColor.white, andFontSize: 15);
        lineChartBgV.addSubview(self.halfYearBut);
        self.halfYearBut.backgroundColor=UIColorFromRGB(R: 94, G: 124, B: 175);
        self.halfYearBut.layer.borderWidth=0.5;
        self.halfYearBut.layer.borderColor=UIColorFromRGB(R: 94, G: 124, B: 175).cgColor;
        self.halfYearBut.layer.cornerRadius=CGFloat(TheRoundedAmplitude);
        self.halfYearBut.layer.masksToBounds=true;
        self.halfYearBut.tag=101;
        self.halfYearBut.addTarget(self, action: #selector(buttonAction(_:)), for: UIControlEvents.touchUpInside);
        
        
        self.yearBut=createButtonWithTtile(withFrame: CGRect.init(x: ScreenWidth()-55, y: 10, width: 40, height: 30), andTtile: "一年", andTintColor: UIColorFromRGB(R: 94, G: 124, B: 175), andFontSize: 15);
        lineChartBgV.addSubview(self.yearBut);
        self.yearBut.layer.borderWidth=0.5;
        self.yearBut.layer.borderColor=UIColorFromRGB(R: 94, G: 124, B: 175).cgColor;
        self.yearBut.layer.cornerRadius=CGFloat(TheRoundedAmplitude);
        self.yearBut.layer.masksToBounds=true;
        self.yearBut.tag=102;
        self.yearBut.addTarget(self, action: #selector(buttonAction(_:)), for: UIControlEvents.touchUpInside);
        
    }
    
    func showLineChartView(WithXDataArray xDataArray:[Any],andValueArray valueArray:[Any]) {
        
        self.lineChart.clear();
        
        self.lineChart.xLineDataArr = xDataArray;
        
        /* 数据源 */
        self.lineChart.valueArr = [valueArray];
        /* 值折线的折线颜色 默认暗黑色*/
        self.lineChart.valueLineColorArr = [UIColor.red];
        
        /* 值点的颜色 默认橘黄色*/
        self.lineChart.pointColorArr = [UIColor.red];
        
        self.lineChart.pointNumberColorArr = [UIColor.orange];

        /* X和Y轴的颜色 默认暗黑色 */
        self.lineChart.xAndYLineColor = UIColor.black;

        /* XY轴的刻度颜色 m */
        self.lineChart.xAndYNumberColor = UIColor.blue;

        /* 坐标点的虚线颜色 */
        self.lineChart.positionLineColorArr = [UIColor.clear];

        
        self.lineChart.showAnimation();
    
        
    }
    
    //MARK:- RingChart event
    func createRingChart() {
        
        let ringChartBgV=createBGView(withFrame: CGRect.init(x: 0, y: 190, width: ScreenWidth(), height: 300), andBackgroundColor: UIColor.white);
        self.scrollV.addSubview(ringChartBgV);
        
        let headLabel=createLabel(withFrame: CGRect.init(x: 15, y: 0, width: 100, height: 50), andAlignment: NSTextAlignment.left, andText: "9月份总单量", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 15);
        ringChartBgV.addSubview(headLabel);
      
        self.ring=JHRingChart.init(frame: CGRect.init(x: (ScreenWidth()-150)/2, y: 75, width: 150, height: 150));
        self.ring.colorDataArr=[UIColorFromHexValue(0x3bf392),UIColorFromHexValue(0xfde411),UIColorFromHexValue(0xfb3d3e)];
        ringChartBgV.addSubview(self.ring);
        
        let label1=createLabel(withFrame: CGRect.init(x: 15, y: 240, width: 50, height: 15), andAlignment: NSTextAlignment.left, andText: "正常单", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 12);
        ringChartBgV.addSubview(label1);
        
        let label2=createLabel(withFrame: CGRect.init(x: 15, y: 255, width: 50, height: 15), andAlignment: NSTextAlignment.left, andText: "超时单", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 12);
        ringChartBgV.addSubview(label2);
        
        
        let label3=createLabel(withFrame: CGRect.init(x: 15, y: 270, width: 50, height: 15), andAlignment: NSTextAlignment.left, andText: "问题件", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 12);
        ringChartBgV.addSubview(label3);
        
        let label1_number=createLabel(withFrame: CGRect.init(x: ScreenWidth()-150, y: 240, width: 60, height: 15), andAlignment: NSTextAlignment.right, andText: "150笔", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 12);
        ringChartBgV.addSubview(label1_number);
        
        let label2_number=createLabel(withFrame: CGRect.init(x: ScreenWidth()-150, y: 255, width: 60, height: 15), andAlignment: NSTextAlignment.right, andText: "150笔", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 12);
        ringChartBgV.addSubview(label2_number);
        
        
        let label3_number=createLabel(withFrame: CGRect.init(x: ScreenWidth()-150, y: 270, width: 60, height: 15), andAlignment: NSTextAlignment.right, andText: "200笔", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 12);
        ringChartBgV.addSubview(label3_number);
        
        let label1_percent=createLabel(withFrame: CGRect.init(x: ScreenWidth()-60, y: 240, width: 60, height: 15), andAlignment: NSTextAlignment.left, andText: "30%", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 12);
        ringChartBgV.addSubview(label1_percent);
        
        let label2_percent=createLabel(withFrame: CGRect.init(x: ScreenWidth()-60, y: 255, width: 60, height: 15), andAlignment: NSTextAlignment.left, andText: "30%", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 12);
        ringChartBgV.addSubview(label2_percent);
        
        
        let label3_percent=createLabel(withFrame: CGRect.init(x: ScreenWidth()-60, y: 270, width: 60, height: 15), andAlignment: NSTextAlignment.left, andText: "40%", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 12);
        ringChartBgV.addSubview(label3_percent);
        
        let label1_colorBlock=createLabel(withFrame: CGRect.init(x: ScreenWidth()-82, y: 241, width: 14, height: 13), andAlignment: NSTextAlignment.left, andText: "", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 12);
        label1_colorBlock.backgroundColor=UIColorFromHexValue(0x3bf392);
        ringChartBgV.addSubview(label1_colorBlock);
        
        let label2_colorBlock=createLabel(withFrame: CGRect.init(x: ScreenWidth()-82, y: 256, width: 14, height: 13), andAlignment: NSTextAlignment.left, andText: "", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 12);
        label2_colorBlock.backgroundColor=UIColorFromHexValue(0xfde411);
        ringChartBgV.addSubview(label2_colorBlock);
        
        
        let label3_colorBlock=createLabel(withFrame: CGRect.init(x: ScreenWidth()-82, y: 271, width: 14, height: 13), andAlignment: NSTextAlignment.left, andText: "", andTextColor: UIColorFromHexValue(0x333333), andFontSize: 12);
        label3_colorBlock.backgroundColor=UIColorFromHexValue(0xfb3d3e);
        ringChartBgV.addSubview(label3_colorBlock);
        
    }
    
    func showRingChartView() {
        
        self.ring.clear();
        
        self.ring.valueDataArr = ["150","150","200"];
        self.ring.showAnimation();
        
    }
    
    //MARK:- button action
    func buttonAction(_ sender:UIButton) {
        
        switch sender.tag {
        case 101:
            self.halfYearBut.backgroundColor=UIColorFromRGB(R: 94, G: 124, B: 175);
            self.halfYearBut.setTitleColor(UIColor.white, for: UIControlState.normal);
            
            self.yearBut.backgroundColor=UIColor.clear;
            self.yearBut.setTitleColor(UIColorFromRGB(R: 94, G: 124, B: 175), for: UIControlState.normal);
            break;
        case 102:
            self.halfYearBut.backgroundColor=UIColor.clear;
            self.halfYearBut.setTitleColor(UIColorFromRGB(R: 94, G: 124, B: 175), for: UIControlState.normal);
            
            self.yearBut.backgroundColor=UIColorFromRGB(R: 94, G: 124, B: 175);
            self.yearBut.setTitleColor(UIColor.white, for: UIControlState.normal);
            break;
        default:
            
            break;
        };
        
        self.getLineChartData(WithTag: sender.tag);
        
    }
    
    func getLineChartData(WithTag tag:Int) {
        
        switch tag {
        case 101:
            self.showLineChartView(WithXDataArray: ["4月","5月","6月","7月","8月","9月"], andValueArray: ["0","50","0","40","0","200"]);
            break;
        case 102:
            self.showLineChartView(WithXDataArray: ["1月","2月","3月","4月","5月","6月","7月","8月","9月"], andValueArray: ["0","40","50","0","100","10","140","0","200"]);
            break;
        default:
            
            break;
        }
        
    }

    //MARK:- other event
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
