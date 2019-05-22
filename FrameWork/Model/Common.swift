//
//  Common.swift
//  mPOS
//
//  Created by MinhDH on 3/6/17.
//  Copyright © 2017 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
class Common{
    class func Size(s: CGFloat) -> CGFloat {
        let rs : CGFloat = UIScreen.main.bounds.size.width / ( 320 / s )
        return rs
    }
    class func save(_ key: String, data: Data) {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    
    class func load(_ key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]
        
        var dataTypeRef :AnyObject?
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            return (dataTypeRef as! Data)
        } else {
            return nil
        }
    }
    class func convertCurrency(value:Int)->String{
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        return "\(fmt.string(for: value)!)đ"
    }
    class func convertCurrencyFloat(value:Float)->String{
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        return "\(fmt.string(for: value)!)đ"
    }
    
    struct CommonValue{
        static var UUID: String!
    }
    class func loadUUID(){
        if let udid = Common.load("UDID-Keychain"){
            //get udid from keychain
            CommonValue.UUID = Common.NSDATAtoString(udid)
            print("UUIDString: \(CommonValue.UUID)")
        }else{
            //save udid to keychain
            let deviceInfo = UIDevice.current
            CommonValue.UUID = deviceInfo.identifierForVendor?.uuidString
            Common.save("UDID-Keychain", data: Common.stringToNSDATA((deviceInfo.identifierForVendor?.uuidString)!))
            print("UUIDString: \(CommonValue.UUID)")
        }
    }
    class func NSDATAtoString(_ data: Data)->String
    {
        let returned_string : String = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
        return returned_string
    }
    class func stringToNSDATA(_ string : String)->Data
    {
        let _Data = (string as NSString).data(using: String.Encoding.utf8.rawValue)
        return _Data!
        
    }
    class func encryptPassword(password: String)->String {
        return ASMHelper.encryptPassword(password)!
    }
    
    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired

         return isReachable && !needsConnection
         */

        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }

    class func versionApp() ->String{
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return "\(version)"
        }else{
            return "Version Error"
        }
    }
    struct MyData {
        static var sku: String = ""
//        static var product: ProductBySku?
        static var tabBarHeight:CGFloat = 0.0
//        static var carts:[Cart] = []
//        static var customer:Customer?
//        static var shopInfo:ShopInfo?
//        static var itemsPromotion: [ProductPromotions] = []
        
        static var phone: String = ""
        static var name: String = ""
        static var address: String = ""
        static var email: String = ""
        static var note: String = ""
        
        static var heightNav:CGFloat = 0.0
        
        
//        static var cartsTemp:[Cart] = []
//        static var itemsPromotionTemp: [ProductPromotions] = []
        static var phoneTemp: String = ""
        static var nameTemp: String = ""
        static var addressTemp: String = ""
        static var emailTemp: String = ""
        static var noteTemp: String = ""
        static var docTypeTemp: String = ""
        static var payTypeTemp: String = ""
    }
}
class UnderlinedLabel: UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.characters.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = hexString.substring(from: start)
            
            if hexColor.characters.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
extension String {
    var hexColor: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
extension String {
    /// Encode a String to Base64
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    /// Decode a String from Base64. Returns nil if unsuccessful.
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}
extension Date {
    init?(jsonDate: String) {
        
        let pattern = "\\\\?/Date\\((\\d+)(([+-]\\d{2})(\\d{2}))?\\)\\\\?/"
        let regex = try! NSRegularExpression(pattern: pattern)
        guard let match = regex.firstMatch(in: jsonDate, range: NSRange(location: 0, length: jsonDate.utf16.count)) else {
            return nil
        }
        
        // Extract milliseconds:
        let dateString = (jsonDate as NSString).substring(with: match.rangeAt(1))
        // Convert to UNIX timestamp in seconds:
        let timeStamp = Double(dateString)! / 1000.0
        // Create Date from timestamp:
        self.init(timeIntervalSince1970: timeStamp)
    }
}
protocol Dateable {
    func userFriendlyFullDate() -> String
    func userFriendlyHours() -> String
}
extension Date {
    var  formatter: DateFormatter { return DateFormatter() }
    
    /** Return a user friendly hour */
    func userFriendlyFullDate() -> String {
        // Customize a date formatter
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return formatter.string(from: self)
    }
    
    /** Return a user friendly hour */
    func userFriendlyHours() -> String {
        // Customize a date formatter
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return formatter.string(from: self)
    }
    
    // You can add many cases you need like string to date formatter
    
}
