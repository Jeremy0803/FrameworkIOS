//
//  ServiceAPI.swift
//  FrameWork
//
//  Created by Jeremy on 4/11/17.
//  Copyright © 2017 fptshop. All rights reserved.
//

import Foundation
import Alamofire
class APIService{
    static let headers: HTTPHeaders = [
        "Authorization": "\(Constant.AUTHORIZATION)",
        "Accept": "application/json"
    ]
    class func login(username:String,password: String,handler: @escaping LoginHandler) {

        let action = "/Authentication.svc/login"

        let url = "\(Constant.SERVER)\(action)"

        let pwd = Common.encryptPassword(password: password)

        let parameters: [String: String] = [
            "username" : "\(username)",
            "password" : "\(pwd)",
        ]
        var user:User? = nil
        
        Alamofire.request(url,method: .post, parameters: parameters,encoding: JSONEncoding(options: [])).responseJSON{ response in
            switch response.result {
            case .success:
                if let json = response.result.value {

                    let results = json as! NSDictionary
                    print(results)

                    if let loginResult = results.object(forKey: "WCF_LoginResult") as? NSDictionary {
                        user = User.getUserFromNSDictionary(loginResult)
                        handler(user,"")
                    } else {
                        handler(user,"Login failed!")
                    }

                }else{
                    handler(user,"Login failed!!")
                }
            case .failure:
                handler(user,"Login failed!!")
            }
        }
    }
    //api search
    class func searchProduct(keyword:String,skip: Int,top : Int,handler: @escaping SearchProductHandler) {
        
        let action = "SearchProduct"
        
        let url = "\(Constant.API)/\(action)/?key=\(Constant.KEY)&keyword=\(keyword)&skip=\(skip)&top=\(top)"
        var products:[Product] = []
        
        Alamofire.request(url,headers:headers).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value {
                    let results = json as! NSDictionary
                    if let list = results.object(forKey: "list") as? NSArray {
                        products = Product.parseObjfromArray(array: list)
                        handler(products,"")
                    } else {
                        handler(products,"Load API Error!")
                    }
                    
                }else{
                    handler(products,"Load API Error!")
                }
            case .failure(let error):
                handler(products,"Load API Error! \(error)")
            }
            
        }
    }
    class func getListBonusScope(typeId:Int,skip:Int,top: Int,handler: @escaping GetListBonusScopeHandler) {
        
        let action = "GetListBonusScope"
        
        let url = "\(Constant.API)/\(action)/?key=\(Constant.KEY)&typeId=\(typeId)&skip=\(skip)&top=\(top)"
        print(url)
        var products:[Product] = []
        Alamofire.request(url,headers:headers).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.result.value {
                    let results = json as! NSDictionary
                    let error = results.object(forKey: "error")! as! Bool
                    if(error == false){
                        if let list = results.object(forKey: "list") as? NSArray {
                            products = Product.parseObjfromArray(array: list)
                            handler(products,"")
                        } else {
                            handler(products,"Load API Error!")
                        }
                    }else{
                        handler(products,"Load API Error!")
                    }
                }else{
                    handler(products,"Load API Error!")
                }
            case .failure(let error):
                handler(products,"Load API Error! \(error)")
            }
            
        }
    }

}
