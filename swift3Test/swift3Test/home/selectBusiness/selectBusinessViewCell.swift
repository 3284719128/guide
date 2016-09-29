//
//  selectBusinessViewCell.swift
//  swift3Test
//
//  Created by 43696467 on 2016/9/27.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class selectBusinessViewCell: UITableViewCell {
    
    var nameLabel:UILabel!;
    
    static let selectBusinessViewCellID="selectBusinessViewCellID";
    
    static func createCell(withTableView tableView:UITableView) -> selectBusinessViewCell {
        
        var cell=tableView.dequeueReusableCell(withIdentifier: selectBusinessViewCellID) as? selectBusinessViewCell;
        if cell == nil {
            cell=selectBusinessViewCell();
            cell?.backgroundColor=UIColor.clear;
            cell?.selectionStyle=UITableViewCellSelectionStyle.none;
            cell?.drawCellView();
        }
        
        return cell!;
        
    }
    
    //MARK:- draw view event
    func drawCellView() {
        
        self.nameLabel=createLabel(withFrame: CGRect(x: 15, y: 0, width: ScreenWidth()-15, height: 40), andAlignment: NSTextAlignment.left, andText: "", andTextColor: UIColor.black, andFontSize: 14);
        self.addSubview(self.nameLabel);
        
        let forwardIV=createImageView(withFrame: CGRect(x: ScreenWidth()-19, y: (40-12)/2, width: 7, height: 12), andImageName: "list_forward");
        self.addSubview(forwardIV);
        
        let line=createHorizontalLine(withX: 0, andY: 39.5, andWidth: CGFloat(ScreenWidth()));
        self.addSubview(line);
        
    }
    


}
