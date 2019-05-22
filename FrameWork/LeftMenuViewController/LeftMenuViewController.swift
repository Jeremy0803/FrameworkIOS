//
//  LeftMenuViewController.swift
//  FrameWork
//
//  Created by Jeremy on 4/11/17.
//  Copyright © 2017 fptshop. All rights reserved.
//

import UIKit
import Foundation
import KYDrawerController

class LeftMenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    weak var delegate: LeftMenuViewControllerDelegate?

    var tableView: UITableView  =   UITableView()
    var itemsMenu: NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(netHex:0x282828)

        let user = User.loadDataUser()
        //profile
        let screenWidth: CGFloat = self.view.frame.size.width * 80/100
        let headerProfile = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: Common.Size(s:44) + UIApplication.shared.statusBarFrame.height))
        headerProfile.backgroundColor = UIColor(netHex:0x282828)
        self.view.addSubview(headerProfile)
        
        let imageAvatar = UIImageView(frame: CGRect(x: Common.Size(s:5), y: UIApplication.shared.statusBarFrame.height, width: Common.Size(s:40), height: Common.Size(s:40)))
        imageAvatar.image = UIImage(named: "avatar")
        imageAvatar.layer.borderWidth = 1
        imageAvatar.layer.masksToBounds = false
        imageAvatar.layer.borderColor = UIColor.white.cgColor
        imageAvatar.layer.cornerRadius = imageAvatar.frame.height/2
        imageAvatar.clipsToBounds = true
        headerProfile.addSubview(imageAvatar)
        
        //user code
        let userCodeString = "\(user.UserName)"
        let lbUserCode = UILabel(frame: CGRect(x: imageAvatar.frame.origin.x + imageAvatar.frame.size.width + Common.Size(s:10), y: UIApplication.shared.statusBarFrame.height, width: screenWidth - (imageAvatar.frame.origin.x + imageAvatar.frame.size.width + Common.Size(s:5)), height: Common.Size(s:14)))
        lbUserCode.textAlignment = .left
        lbUserCode.textColor = UIColor(netHex:0xFFFFFF)
        lbUserCode.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbUserCode.text = userCodeString
        headerProfile.addSubview(lbUserCode)
        
        //username
        let userNameString = "\(user.EmployeeName)"
        let lbUserName = UILabel(frame: CGRect(x: lbUserCode.frame.origin.x , y: lbUserCode.frame.origin.y + lbUserCode.frame.size.height + Common.Size(s:5), width: screenWidth - (imageAvatar.frame.origin.x + imageAvatar.frame.size.width + Common.Size(s:5)), height: Common.Size(s:16)))
        lbUserName.textAlignment = .left
        lbUserName.textColor = UIColor(netHex:0xFFFFFF)
        lbUserName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbUserName.text = userNameString
        headerProfile.addSubview(lbUserName)
        
        //shopname
        let shopNameString = "\(user.ShopName)"
        let lbShopName = UILabel(frame: CGRect(x: lbUserName.frame.origin.x , y: lbUserName.frame.origin.y + lbUserName.frame.size.height + Common.Size(s:5), width: screenWidth - (imageAvatar.frame.origin.x + imageAvatar.frame.size.width + Common.Size(s:5)), height: Common.Size(s:12)))
        lbShopName.textAlignment = .left
        lbShopName.textColor = UIColor(netHex:0xFFFFFF)
        lbShopName.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbShopName.text = shopNameString
        headerProfile.addSubview(lbShopName)
        headerProfile.frame.size.height = lbShopName.frame.size.height + lbShopName.frame.origin.y + Common.Size(s:5)
        imageAvatar.frame.origin.y =  ((UIApplication.shared.statusBarFrame.height + headerProfile.frame.size.height)/2 - imageAvatar.frame.size.height/2)
        
        //menu
        let headerMenu = UIView(frame: CGRect(x: 0, y: headerProfile.frame.origin.y + headerProfile.frame.size.height, width: screenWidth, height: Common.Size(s:30)))
        headerMenu.backgroundColor = UIColor(netHex:0xffffff).withAlphaComponent(0.1)
        self.view.addSubview(headerMenu)
        
        let lbMenuName = UILabel(frame: CGRect(x: Common.Size(s:5), y: 0, width: headerMenu.frame.size.width, height: headerMenu.frame.size.height))
        lbMenuName.textAlignment = .left
        lbMenuName.textColor = UIColor(netHex:0xFFFFFF)
        lbMenuName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbMenuName.text = "CHỨC NĂNG"
        headerMenu.addSubview(lbMenuName)
        
        //Copyright
        let copyrightString = "mPOS v\( Common.versionApp())\r\nCopyright © 2017 FPT Retail J.S.C\r\nSmart Retail Project"
        
        let sizeCopyright: CGFloat = copyrightString.height(withConstrainedWidth: UIScreen.main.bounds.size.width * 8 / 10, font: UIFont.systemFont(ofSize: Common.Size(s:14)))
        let lbCopyright = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - sizeCopyright - Common.Size(s:11), width: screenWidth, height: sizeCopyright))
        lbCopyright.textAlignment = .center
        lbCopyright.textColor = UIColor.white
        lbCopyright.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbCopyright.text = copyrightString
        lbCopyright.numberOfLines = 3;
        self.view.addSubview(lbCopyright)
        
        //menu item
        itemsMenu = NSMutableArray()
        let item1: ItemMenuLeft = ItemMenuLeft(id: 1,title: "Trang chủ",image: "Home-50")
        let item2: ItemMenuLeft = ItemMenuLeft(id: 2,title: "Danh sách đơn hàng",image: "To Do-50")
        let item3: ItemMenuLeft = ItemMenuLeft(id: 3,title: "Sản phẩm điểm cao",image: "Money Bag-50")
        let item4: ItemMenuLeft = ItemMenuLeft(id: 4,title: "Máy đổi trả",image: "Replace-50")
        let item8: ItemMenuLeft = ItemMenuLeft(id: 8,title: "mService",image: "US Dollar-50")
        let item9: ItemMenuLeft = ItemMenuLeft(id: 9,title: "Payoo",image: "Initiate Money Transfer-50")
        let item6: ItemMenuLeft = ItemMenuLeft(id: 6,title: "F.Friend",image: "Meeting-50")
        let item7: ItemMenuLeft = ItemMenuLeft(id: 7,title: "Đăng xuất",image: "Logout Rounded Left-50")
        itemsMenu.add(item1)
        itemsMenu.add(item2)
        itemsMenu.add(item3)
        itemsMenu.add(item4)
        itemsMenu.add(item8)
        itemsMenu.add(item9)
        itemsMenu.add(item6)
        itemsMenu.add(item7)
        
        tableView.frame = CGRect(x: 0, y: headerMenu.frame.origin.y + headerMenu.frame.size.height, width: screenWidth, height: lbCopyright.frame.origin.y - (headerMenu.frame.origin.y + headerMenu.frame.size.height))
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ItemMenuLeftTableViewCell.self, forCellReuseIdentifier: "ItemMenuLeftTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(netHex:0x282828)
        self.view.addSubview(tableView)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemsMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemMenuLeftTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "ItemMenuLeftTableViewCell")
        let item:ItemMenuLeft = itemsMenu.object(at: indexPath.row) as! ItemMenuLeft
        cell.title.text = item.title
        cell.iconImage.image = UIImage(named: "\(item.image)")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item:ItemMenuLeft = itemsMenu.object(at: indexPath.row) as! ItemMenuLeft
        if let drawerController = parent as? KYDrawerController {
            drawerController.setDrawerState(.closed, animated: true)
        }
        delegate?.drawerViewController(self, didTapItem: item)
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath)
        cell!.contentView.backgroundColor = .red
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell  = tableView.cellForRow(at: indexPath)
        cell!.contentView.backgroundColor = .clear
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:44);
    }


}
class ItemMenuLeftTableViewCell: UITableViewCell {

    var title: UILabel!
    var iconImage:UIImageView!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        iconImage = UIImageView(frame: CGRect(x: Common.Size(s:10), y:  Common.Size(s:44)/2 -  (Common.Size(s:44) * 2/3)/2, width: Common.Size(s:44)/2, height:  Common.Size(s:44) * 2/3))
        
        iconImage.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(iconImage)
        self.backgroundColor = UIColor(netHex:0x282828)
        title = UILabel()
        title.frame = CGRect(x:iconImage.frame.origin.x + iconImage.frame.size.width + Common.Size(s:10),y: Common.Size(s:44)/2 - iconImage.frame.size.height/2 ,width: bounds.width * 80 / 100,height: iconImage.frame.size.height)
        title.textColor = UIColor.white
        title.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        contentView.addSubview(title)

    }
    
}

