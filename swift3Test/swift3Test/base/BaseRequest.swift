//
//  BaseRequest.swift
//  swift3Test
//
//  Created by 43696467 on 2016/9/27.
//  Copyright © 2016年 team1. All rights reserved.
//

import UIKit

class BaseRequest: NSObject {
    
    static func request(WithInCode inCode:String,andParamsDict paramsDict:[String:Any],andCallbackFunc callbackFunc:(_ contentDict:[String:Any],_ message:String)->(Void)) {
        
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
        
        let array=[dict,dict,dict];
        
        let content=[
            
            "items":array,
        ];

        callbackFunc(content,"success");
        
    }


}
