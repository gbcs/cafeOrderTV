//
//  Orders.swift
//  cafeOrderTV
//
//  Created by Gary Barnett on 11/7/16.
//  Copyright © 2016 Gary Barnett. All rights reserved.
//

import UIKit


enum OrderState {
    case empty
    case ordering
    case paid
    case delivered
    case cancelled
    case returned
}

class Order {
    var table:NSInteger = 0
    var position:NSInteger = 0
    var selections:[String] = []
    var total:NSDecimalNumber = 0.0
    var paid: Bool = false
    var state:OrderState = .empty
    var timePlaced:Date = Date.init(timeIntervalSinceNow: 0)
    var idStr:String = ""
    var items:Array<String> = []
    
    func changeState (updatedState:OrderState) {
        self.state = updatedState
        //NSURLConnection api call to change state
    }
    
    //init with json feed from api call to construct, then remove default vals from props
    
}

class Orders {
    var orders: [Order] = []
    var ready: Bool = true
   
    func updateOrderList () {
        self.ready = false
        //NSURLConnection loader for order data
        

        
        
        self.ready = true;
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.ordersUpdatedNotification), object: nil)
    }
    
    func closeOrder(idStr:String) {
        //Make api call
    }
}


