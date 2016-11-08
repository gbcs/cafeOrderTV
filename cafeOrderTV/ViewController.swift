//
//  ViewController.swift
//  cafeOrderTV
//
//  Created by Gary Barnett on 11/7/16.
//  Copyright © 2016 Gary Barnett. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // collectionView.register(OrderCell.self, forCellWithReuseIdentifier: Constants.orderCollectionViewReuseIdentifier )
      
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateOrdersView), name: NSNotification.Name(rawValue: Constants.ordersUpdatedNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateOOOSign), name: NSNotification.Name(rawValue: Constants.ordersAPIOutOfOrder), object: nil)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateOrdersView () {
        //take orders, build collection view in order (menu item, special instructions, side, drink)
        //add commands so when selecting the order, a list shows, with complete first, then cancel
    }
    
    func updateOOOSign () {
        //figure
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.orderCollectionViewReuseIdentifier, for: indexPath as IndexPath) 
        
        let timeLabel:UILabel = cell.viewWithTag(1) as! UILabel
        let tableSeatLabel:UILabel = cell.viewWithTag(2) as! UILabel
        let orderTextLabel:UILabel = cell.viewWithTag(3) as! UILabel
       // let orderFocusOverlay:UILabel = cell.viewWithTag(4) as! UILabel
        
        

        
        timeLabel.text = "timel"
        tableSeatLabel.text = "tableseat"
        orderTextLabel.text = "this is order text"
        

        return cell
    }
   
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
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
    
    
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */

    
    
}

