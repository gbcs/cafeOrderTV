//
//  OrderManager.swift
//  cafeOrderTV
//
//  Created by Gary Barnett on 11/7/16.
//  Copyright © 2016 Gary Barnett. All rights reserved.
//

import UIKit

class OrderManager {
    var orderParameters : [String]
    var orders:Orders
    var timeLeftUntilNextEvent:Int = 0
    var timer:Timer! = nil;
    
    static let sharedInstance : OrderManager = {
        let instance = OrderManager(parameters: [
            
            
            ])
        return instance
    }()

    init( parameters : [String]) {
        orderParameters = parameters
        orders = Orders.init()
    }
    
    func start () {
        if (self.timer == nil) {
            self.timeLeftUntilNextEvent  = Constants.orderRefreshTimerInterval ;
            self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(Constants.orderUpdateTimerInterval), repeats: true, block: { (eventTimer) in
                if (self.orders.ready == true) {
                    self.timeLeftUntilNextEvent -= Constants.orderUpdateTimerInterval;
                    if (self.timeLeftUntilNextEvent < 0) {
                        self.timeLeftUntilNextEvent = Constants.orderRefreshTimerInterval;
                        self.orders.updateOrderList()
                    }
                }
            })
        }
    }
    
    func stop () {
        self.timer = nil;
        self.timeLeftUntilNextEvent = Constants.orderRefreshTimerInterval;
    }

    var listOrders:Array<Order> {
        return self.orders.orders
    }
    
    func closeOrder (orderNumber:String) {
        self.orders.closeOrder(idStr: orderNumber)
    }
}

