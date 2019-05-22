//
//  MainViewController.swift
//  FrameWork
//
//  Created by Jeremy on 4/7/17.
//  Copyright © 2017 fptshop. All rights reserved.
//

import UIKit
import Foundation
import KYDrawerController
import MIBadgeButton_Swift
import PopupDialog

class MainViewController: UIViewController,LeftMenuViewControllerDelegate,UISearchBarDelegate,HandleSearch{
    var searchController: UISearchController!
    
    var indexView: Int = 0
    var barSearchRight : UIBarButtonItem!
    var productViewController: ProductViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Main")
        self.title = "Framework"
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x47B054)
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        Common.MyData.heightNav = (self.navigationController?.navigationBar.frame.size.height)!
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        btLeftIcon.setImage(UIImage(named: "Menu"), for: UIControlState.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(MainViewController.actionOpenMenuLeft), for: UIControlEvents.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
        
        //search
        let productSearchTable = SearchViewController()
        productSearchTable.handleSearchDelegate = self
        self.searchController = UISearchController(searchResultsController: productSearchTable)
        self.searchController.searchResultsUpdater = productSearchTable
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = "What product you want to search?"
        definesPresentationContext = true
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.isActive = false
        self.searchController.searchBar.backgroundColor = UIColor.clear
        self.searchController.searchBar.becomeFirstResponder()
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.frame.size.width = self.view.frame.size.width

        let btSearchIcon = UIButton.init(type: .custom)
        btSearchIcon.setImage(UIImage(named: "Search-50"), for: UIControlState.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.addTarget(self, action: #selector(MainViewController.actionSearch), for: UIControlEvents.touchUpInside)
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barSearchRight = UIBarButtonItem(customView: btSearchIcon)
        
        self.navigationItem.rightBarButtonItems = [barSearchRight]
        

        
        productViewController = ProductViewController()
        self.add(asChildViewController: productViewController)
        indexView = 3
        
    
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationItem.setRightBarButtonItems([barSearchRight], animated: true)
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationItem.titleView = nil
        }, completion: { finished in
            
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search")
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name("searchAction"), object: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // action open menu left
    func actionOpenMenuLeft() {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    func drawerViewController(_ viewController: LeftMenuViewController, didTapItem: ItemMenuLeft) {
        switch didTapItem.id {
//        case 1:
//           bonusScope(item: didTapItem)
//            break
//        case 2:
//            listOrder(item: didTapItem)
//            break
//        case 3:
//            bonusScope(item: didTapItem)
//            break
//        case 4:
//            oldProduct(item: didTapItem)
//            break
//        case 6:
//            fFriend()
//            break
//        case 7:
//            popupLogout()
//            break
//        case 8:
//            mService()
//            break
//        case 9:
//            payoo()
//            break
        default:
            break
        }
        
    }
    func actionSearch(){
        //code here
        self.searchController.searchBar.alpha = 0
        navigationItem.titleView =  self.searchController.searchBar
        navigationItem.setRightBarButtonItems(nil, animated: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.searchController.searchBar.alpha = 1
        }, completion: { finished in
            self.searchController.searchBar.becomeFirstResponder()
        })

    }
    func pushView(_ product: Product) {
        //code here
    }
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
        
    }

}
