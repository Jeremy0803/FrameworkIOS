//
//  Protocol.swift
//  FrameWork
//
//  Created by Jeremy on 4/11/17.
//  Copyright © 2017 fptshop. All rights reserved.
//

import Foundation

protocol LeftMenuViewControllerDelegate: NSObjectProtocol {

    func drawerViewController(_ viewController: LeftMenuViewController, didTapItem: ItemMenuLeft)

}
protocol HandleSearch: class {
    func pushView(_ product:Product)
}
