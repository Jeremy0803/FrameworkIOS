//
//  ProductViewController.swift
//  FrameWork
//
//  Created by Jeremy on 5/10/17.
//  Copyright © 2017 fptshop. All rights reserved.
//

import UIKit

class ProductViewController: UITabBarController,UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ProductViewController")
        self.view.backgroundColor = UIColor.white
        self.delegate = self
        Common.MyData.tabBarHeight = self.tabBar.frame.size.height
        //self.automaticallyAdjustsScrollViewInsets = false
        let tabProduct = Tab1ViewController()
        tabProduct.edgesForExtendedLayout = []
        let tabProductBarItem = UITabBarItem(title: "Tab1", image: #imageLiteral(resourceName: "TabPhone"), selectedImage: #imageLiteral(resourceName: "TabPhone"))
        
        tabProduct.tabBarItem = tabProductBarItem
        
        // Create Tab two
        let tabSameProduct = Tab2ViewController()
        let tabSameProductBarItem = UITabBarItem(title: "Tab2", image: #imageLiteral(resourceName: "Tablet"), selectedImage: #imageLiteral(resourceName: "TabSamePrice"))
        
        tabSameProduct.tabBarItem = tabSameProductBarItem
        
        
        let tabCompare = Tab3ViewController()
        let tabCompareBarItem = UITabBarItem(title: "Tab3", image: #imageLiteral(resourceName: "Laptop"), selectedImage: #imageLiteral(resourceName: "TabCompare"))
        
        tabCompare.tabBarItem = tabCompareBarItem
        
        let tabApple = Tab4ViewController()
        let tabAppleBarItem = UITabBarItem(title: "Tab4", image: #imageLiteral(resourceName: "Apple"), selectedImage: #imageLiteral(resourceName: "TabInstallment"))
        
        tabApple.tabBarItem = tabAppleBarItem
        
        self.viewControllers = [tabProduct, tabSameProduct,tabCompare,tabApple]
        
        if let items = self.tabBar.items
        {
            for item in items
            {
                if let image = item.image
                {
                    item.image = image.withRenderingMode( .alwaysOriginal )
                    item.selectedImage = UIImage(named: "(Imagename)-a")?.withRenderingMode(.alwaysOriginal)
                }
            }
        }
        UITabBar.appearance().barTintColor = UIColor(netHex:0x47B054)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for: .selected)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
