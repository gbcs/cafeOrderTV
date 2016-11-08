//
//  ViewController.swift
//  cafeOrderTV
//
//  Created by Gary Barnett on 11/7/16.
//  Copyright © 2016 Gary Barnett. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var orderList:Array<Order>!
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orderList = OrderManager.sharedInstance.listOrders
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateOrdersView), name: NSNotification.Name(rawValue: Constants.ordersUpdatedNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateOOOSign), name: NSNotification.Name(rawValue: Constants.ordersAPIOutOfOrder), object: nil)
       

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func updateOrdersView () {
        self.orderList = OrderManager.sharedInstance.listOrders
        self.collectionView.reloadData()
    }
    
    func updateOOOSign () {
        //figure
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func timeFromDate (date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        let dateString = formatter.string(from: date)
        
        return dateString;
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.orderCollectionViewReuseIdentifier, for: indexPath as IndexPath) 
        
        let timeLabel:UILabel = cell.viewWithTag(Constants.orderCollectionViewTagTime) as! UILabel
        let tableSeatLabel:UILabel = cell.viewWithTag(Constants.orderCollectionViewTagTableSeat) as! UILabel
        let orderItemsLabel:UILabel = cell.viewWithTag(Constants.orderCollectionViewTagOrderItemList) as! UILabel
        let orderNumberLabel:UILabel = cell.viewWithTag(Constants.orderCollectionViewTagOrderNumber) as! UILabel
        
        let order:Order = orderList[indexPath.item]
        
        timeLabel.text = self.timeFromDate(date: order.timePlaced)
        tableSeatLabel.text =  "\(order.table)"
        orderNumberLabel.text = order.idStr

   
        orderItemsLabel.text = "this is order items list"
        
        
        return cell
    }
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.orderCollectionViewReuseIdentifier, for: indexPath as IndexPath)
        let orderNumberLabel:UILabel = cell.viewWithTag(4) as! UILabel
    
        let controller:UIAlertController = UIAlertController.init(title: "Close Order", message: "Is this order complete?", preferredStyle: .actionSheet)
    
        controller.addAction(UIAlertAction.init(title: "Close Order", style: .default, handler: { (action) in
            OrderManager.sharedInstance.closeOrder(orderNumber: orderNumberLabel.text!)
        }));
        
        controller.addAction(UIAlertAction.init(title: "Keep Order Open", style: .cancel, handler: { (action) in
            
        }));
        
        self.present(controller, animated: true) {
            
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
     }
 
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didUpdateFocusIn context: UICollectionViewFocusUpdateContext,
                        with coordinator: UIFocusAnimationCoordinator) {
        
        if let previousIndexPath = context.previouslyFocusedIndexPath,
            let cell = collectionView.cellForItem(at: previousIndexPath) {
            cell.contentView.layer.borderWidth = 0.0
            cell.contentView.layer.shadowRadius = 0.0
            cell.contentView.layer.shadowOpacity = 0
        }
        
        if let indexPath = context.nextFocusedIndexPath,
            let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.layer.borderWidth = 4.0
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.shadowColor = UIColor.black.cgColor
            cell.contentView.layer.shadowRadius = 4.0
            cell.contentView.layer.shadowOpacity = 0.9
            cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
            collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
        }
    }
    
}

