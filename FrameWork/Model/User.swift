//
//  User.swift
//  FrameWork
//
//  Created by Jeremy on 4/11/17.
//  Copyright © 2017 fptshop. All rights reserved.
//

import Foundation
import KeychainSwift
class User: NSObject {

    let AvatarImageLink: String
    let CashAccount: String
    let CompanyCode: String
    let CompanyCodeB1: String
    let CompanyName: String
    let EmployeeName: String
    let Id: String
    let JobTitle: String
    let ShopCode: String
    let ShopName: String
    let UserName: String

    init(avatarImageLink: String, cashAccount: String, companyCode: String, companyCodeB1: String,
         companyName: String, employeeName: String, iD: String, jobTitle: String, shopCode: String, shopName: String, userName: String){

        self.AvatarImageLink = avatarImageLink
        self.CashAccount = cashAccount
        self.CompanyCode = companyCode
        self.CompanyCodeB1 = companyCodeB1
        self.CompanyName = companyName
        self.EmployeeName = employeeName
        self.Id = iD
        self.JobTitle = jobTitle
        self.ShopCode = shopCode
        self.ShopName = shopCode
        self.UserName = userName

    }
    class func getUserFromNSDictionary(_ data: NSDictionary) -> User {


        var avatarImageLink = data["AvatarImageLink"] as? String
        var cashAccount = data["CashAccount"] as? String
        var companyCode = data["CompanyCode"] as? String
        var companyCodeB1 = data["CompanyCodeB1"] as? String
        var companyName = data["CompanyName"] as? String
        var employeeName = data["EmployeeName"] as? String
        var id = data["Id"] as? String
        var jobTitle = data["JobTitle"] as? String
        var shopCode = data["ShopCode"] as? String
        var shopName = data["ShopName"] as? String
        var userName = data["UserName"] as? String

        avatarImageLink = avatarImageLink == nil ? "" : avatarImageLink
        cashAccount = cashAccount == nil ? "" : cashAccount
        companyCode = companyCode == nil ? "" : companyCode
        companyCodeB1 = companyCodeB1 == nil ? "" : companyCodeB1
        companyName = companyName == nil ? "" : companyName
        employeeName = employeeName == nil ? "" : employeeName
        id = id == nil ? "" : id
        jobTitle = jobTitle == nil ? "" : jobTitle
        shopCode = shopCode == nil ? "" : shopCode
        shopName = shopName == nil ? "" : shopName
        userName = userName == nil ? "" : userName
        // cache User
        return User(avatarImageLink: avatarImageLink!, cashAccount: cashAccount!, companyCode: companyCode!, companyCodeB1: companyCodeB1!, companyName: companyName!, employeeName: employeeName!,iD: id!, jobTitle: jobTitle!, shopCode: shopCode!,shopName: shopName!,userName: userName!)
    }
    class func getUserFromNSArray(_ array: NSArray) -> [User]{
        var list: [User] = []
        for item in array{
            list.append(self.getUserFromNSDictionary(item as! NSDictionary))
        }
        return list
    }
    class func save(user:User, password:String){
        let keychain = KeychainSwift()
        keychain.set(user.AvatarImageLink, forKey: "AvatarImageLink")
        keychain.set(user.CashAccount, forKey: "CashAccount")
        keychain.set(user.CompanyCode, forKey: "CompanyCode")
        keychain.set(user.CompanyCodeB1, forKey: "CompanyCodeB1")
        keychain.set(user.CompanyName, forKey: "CompanyName")
        keychain.set(user.EmployeeName, forKey: "EmployeeName")
        keychain.set(user.Id, forKey: "Id")
        keychain.set(user.JobTitle, forKey: "JobTitle")
        keychain.set(user.ShopCode, forKey: "ShopCode")
        keychain.set(user.ShopName, forKey: "ShopName")
        keychain.set(user.UserName, forKey: "UserName")


    }

    class func loadDataUser()-> User {
        let keychain = KeychainSwift()
        let avatarImage = keychain.get("AvatarImageLink")
        let cashAccount =  keychain.get("CashAccount")
        let companyCode = keychain.get("CompanyCode")
        let companyCodeB1 = keychain.get("CompanyCodeB1")
        let companyName = keychain.get("CompanyName")
        let employeeName = keychain.get("EmployeeName")
        let id = keychain.get("Id")
        let jobTitle = keychain.get("JobTitle")
        let shopCode = keychain.get("ShopCode")
        let shopName = keychain.get("ShopName")
        let userName = keychain.get("UserName")
        return User(avatarImageLink: avatarImage!, cashAccount: cashAccount!, companyCode: companyCode!, companyCodeB1: companyCodeB1!, companyName: companyName!, employeeName: employeeName!,iD: id!, jobTitle: jobTitle!, shopCode: shopCode!,shopName: shopName!,userName: userName!)
    }

    class func delete(){
        let keychain = KeychainSwift()
        keychain.clear()
    }


}
