//
//  ItemMenuLeft.swift
//  FrameWork
//
//  Created by Jeremy on 4/11/17.
//  Copyright © 2017 fptshop. All rights reserved.
//

import Foundation
class ItemMenuLeft: NSObject {
    let id:Int
    let title:String
    let image:String

    init(
        id:Int,
        title:String,
        image:String) {
        self.id = id
        self.title = title
        self.image = image
    }
}
