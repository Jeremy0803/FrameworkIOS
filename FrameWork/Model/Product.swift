//
//  Product.swift
//  FrameWork
//
//  Created by Jeremy on 5/10/17.
//  Copyright © 2017 fptshop. All rights reserved.
//

import Foundation
class Product: NSObject {
    var id: Int
    var name: String
    var brandID: Int
    var brandName: String
    var typeId: Int
    var typeName: String
    var sku: String
    var price: Float
    var priceMarket: Float
    var priceBeforeTax: Float
    var iconUrl: String
    var imageUrl: String
    var promotion: String
    var includeInfo: String
    var hightlightsDes: String
    var labelName: String
    var urlLabelPicture: String
    var isRecurring: Bool
    var manSerNum: String
    var bonusScopeBoom: String
    var qlSerial: String
    
    init(id: Int, name: String, brandID: Int, brandName: String, typeId: Int, typeName: String, sku: String, price: Float, priceMarket: Float, priceBeforeTax: Float, iconUrl: String, imageUrl: String, promotion: String, includeInfo: String, hightlightsDes: String, labelName: String, urlLabelPicture: String, isRecurring: Bool, manSerNum: String, bonusScopeBoom: String,qlSerial: String) {
        self.id = id
        self.name = name
        self.brandID = brandID
        self.brandName = brandName
        self.typeId = typeId
        self.typeName = typeName
        self.sku = sku
        self.price = price
        self.priceMarket = priceMarket
        self.priceBeforeTax = priceBeforeTax
        self.iconUrl = iconUrl
        self.imageUrl = imageUrl
        self.promotion = promotion
        self.includeInfo = includeInfo
        self.hightlightsDes = hightlightsDes
        self.labelName = labelName
        self.urlLabelPicture = urlLabelPicture
        self.isRecurring = isRecurring
        self.manSerNum = manSerNum
        self.bonusScopeBoom = bonusScopeBoom
        self.qlSerial = qlSerial
    }
    
    class func getObjFromDictionary(data:NSDictionary) -> Product{
        
        var id = data["ID"] as? Int
        var name = data["Name"] as? String
        var brandID = data["BrandID"] as? Int
        var brandName = data["BrandName"] as? String
        var typeId = data["TypeID"] as? Int
        var typeName = data["TypeName"] as? String
        var sku = data["Sku"] as? String
        var price = data["Price"] as? Float
        var priceMarket = data["PriceMarket"] as? Float
        var priceBeforeTax = data["PriceBeforeTax"] as? Float
        var iconUrl = data["IconUrl"] as? String
        var imageUrl = data["ImageUrl"] as? String
        var promotion = data["Promotion"] as? String
        var includeInfo = data["IncludeInfo"] as? String
        var hightlightsDes = data["HightlightsDes"] as? String
        var labelName = data["LabelName"] as? String
        var urlLabelPicture = data["UrlLabelPicture"] as? String
        var isRecurring = data["IsRecurring"] as? Bool
        var manSerNum = data["ManSerNum"] as? String
        var bonusScopeBoom = data["BonusScopeBoom"] as? String
        var qlSerial = data["QLSerial"] as? String
        
        id = id == nil ? 0 : id
        name = name == nil ? "" : name
        brandID = brandID == nil ? 0 : brandID
        brandName = brandName == nil ? "" : brandName
        typeId = typeId == nil ? 0 : typeId
        typeName = typeName == nil ? "" : typeName
        sku = sku == nil ? "" : sku
        price = price == nil ? 0 : price
        priceMarket = priceMarket == nil ? 0 : priceMarket
        priceBeforeTax = priceBeforeTax == nil ? 0.0 : priceBeforeTax
        iconUrl = iconUrl == nil ? "" : iconUrl
        imageUrl = imageUrl == nil ? "" : imageUrl
        promotion = promotion == nil ? "" : promotion
        includeInfo = includeInfo == nil ? "" : includeInfo
        hightlightsDes = hightlightsDes == nil ? "" : hightlightsDes
        labelName = labelName == nil ? "" : labelName
        urlLabelPicture = urlLabelPicture == nil ? "" : urlLabelPicture
        isRecurring = isRecurring == nil ? false : isRecurring
        manSerNum = manSerNum == nil ? "" : manSerNum
        bonusScopeBoom = bonusScopeBoom == nil ? "" : bonusScopeBoom
        qlSerial = qlSerial == nil ? "" : qlSerial
        
        return Product(id: id!, name: name!, brandID: brandID!, brandName: brandName!, typeId: typeId!, typeName: typeName!, sku: sku!, price: price!, priceMarket: priceMarket!, priceBeforeTax: priceBeforeTax!, iconUrl: iconUrl!, imageUrl: imageUrl!, promotion: promotion!, includeInfo: includeInfo!, hightlightsDes: hightlightsDes!, labelName: labelName!, urlLabelPicture: urlLabelPicture!, isRecurring: isRecurring!, manSerNum: manSerNum!, bonusScopeBoom: bonusScopeBoom!,qlSerial:qlSerial!)
    }
    class func parseObjfromArray(array:NSArray)->[Product]{
        var list:[Product] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item as! NSDictionary))
        }
        return list
    }
    
}
