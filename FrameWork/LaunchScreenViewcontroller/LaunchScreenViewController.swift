//
//  LaunchScreenViewController.swift
//  FrameWork
//
//  Created by Jeremy on 4/7/17.
//  Copyright © 2017 fptshop. All rights reserved.
//

import UIKit
import KeychainSwift
import Toaster
import NVActivityIndicatorView
import KYDrawerController
import ChameleonFramework

class LaunchScreenViewController: UIViewController {
    var window:UIWindow?
    var gradientPlayer:CAGradientLayer!
    var loadingView:NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LaunchScreenViewcontroller")
        creategradientPlayent()

        //logo image
        var logo:UIImageView
        logo = UIImageView(frame: CGRect(x: self.view.frame.size.width / 2 - self.view.frame.size.width*7/20 , y: self.view.frame.size.height / 2 - self.view.frame.size.width*7/20, width: self.view.frame.size.width*7/10, height: self.view.frame.size.width*7/10))
        logo.contentMode = .scaleAspectFit
        logo.image = UIImage(named:"logo")
        self.view.addSubview(logo)

        //label version
        let version = Common.versionApp()
        let sizeVer:CGSize = version.size(attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: Common.Size(s:14))])
        let lblversion = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - sizeVer.height - Common.Size(s:15), width: UIScreen.main.bounds.size.width, height: sizeVer.height))
        lblversion.textAlignment = .center
        lblversion.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lblversion.textColor = UIColor.black
        lblversion.text = "Version \(version)"
        self.view.addSubview(lblversion)

        //indicator
        let frameLoading = CGRect(x: UIScreen.main.bounds.size.width/2 - Common.Size(s: 15), y:logo.frame.origin.y + Common.Size(s: 50) + logo.frame.size.height, width: Common.Size(s: 30), height: Common.Size(s: 30))
        loadingView = NVActivityIndicatorView(frame: frameLoading,
                                              type: .ballClipRotate,
                                              color: UIColor.black)
        self.view.addSubview(loadingView)
        loadingView.startAnimating()
        //checkLogin()

    }

    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
         checkLogin()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func checkLogin(){
        if(Common.isConnectedToNetwork()){
            let keychain = KeychainSwift()
            if let _ = keychain.get("UserName") {
                if let _ = keychain.get("Password"){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.main()
                    })

                }else{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.login()
                    })
                }
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.login()
                })

            }
        }else{
            loadingView.stopAnimating()
            Toast(text: "Vui lòng kiểm tra lại kết nối mạng!").show()
        }
    }

    func login(){
        // Initialize the window
        window = UIWindow.init(frame: UIScreen.main.bounds)

        // Set Background Color of window
        window?.backgroundColor = UIColor.white

        // Allocate memory for an instance of the 'MainViewController' class
        let loginViewController = LoginViewController()

        // Set the root view controller of the app's window
        window!.rootViewController = loginViewController

        // Make the window visible
        window!.makeKeyAndVisible()
    }
    func main(){
                // Initialize the window
                window = UIWindow.init(frame: UIScreen.main.bounds)
        
                // Set Background Color of window
                window?.backgroundColor = UIColor.white
        
                // Allocate memory for an instance of the 'MainViewController' class
                let mainViewController = MainViewController()
        
                // Set the root view controller of the app's window
                window!.rootViewController = mainViewController
        
                // Make the window visible
                window!.makeKeyAndVisible()
//
//        let mainViewController   = MainViewController()
//        let leftMenuViewController = LeftMenuViewController()
//        let drawerController     = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
//        drawerController.mainViewController = UINavigationController(
//            rootViewController: mainViewController
//        )
//        leftMenuViewController.delegate = mainViewController
//        drawerController.drawerViewController = leftMenuViewController
//
//        drawerController.drawerWidth = UIScreen.main.bounds.size.width * 80 / 100
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = drawerController
//        window?.makeKeyAndVisible()
    }
    func creategradientPlayent(){
        gradientPlayer = CAGradientLayer()
        gradientPlayer.frame = self.view.bounds
        gradientPlayer.colors = [UIColor(netHex: 0x05661F).cgColor,	UIColor(netHex: 0xFFFFFF).cgColor]
        gradientPlayer.startPoint = CGPoint(x:0.0,y:1.0)
        gradientPlayer.endPoint = CGPoint(x:1.0,y: 0.0)
        self.view.layer.addSublayer(gradientPlayer)
    }

}
