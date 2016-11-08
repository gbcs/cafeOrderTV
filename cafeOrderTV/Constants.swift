//
//  Constants.swift
//  cafeOrderTV
//
//  Created by Gary Barnett on 11/7/16.
//  Copyright © 2016 Gary Barnett. All rights reserved.
//

import UIKit

class Constants: NSObject {
    static var ordersUpdatedNotification = "on-orders-updated"
    static var ordersAPIOutOfOrder = "on-out-of-order"
    static var orderUpdateTimerInterval = 1
    static var orderRefreshTimerInterval = 10
    static var orderCollectionViewTagTime = 1;
    static var orderCollectionViewTagTableSeat = 2;
    static var orderCollectionViewTagOrderText = 3;
    static var orderCollectionViewReuseIdentifier = "order-collection-view-cell"
}
