//
//  LoginViewController.swift
//  FrameWork
//
//  Created by Jeremy on 4/7/17.
//  Copyright © 2017 fptshop. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import IQKeyboardManagerSwift
import ChameleonFramework
import KYDrawerController

class LoginViewController: UIViewController,UITextFieldDelegate {
    var window:UIWindow?
    var gradientPlayer:CAGradientLayer!
    var scrollview:UIScrollView!
    var txtPassword:UITextField!
    var txtUsername:UITextField!
    var lbNotify:UILabel!
    var loadingView:NVActivityIndicatorView!


    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login")
        print(UIColor.flatYellow.hexValue())
       // self.view.backgroundColor = UIColor.flatWhite
        ///set up Scrollview
        scrollview = UIScrollView(frame:UIScreen.main.bounds)
        scrollview.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scrollview.backgroundColor = UIColor(gradientStyle: UIGradientStyle.topToBottom, withFrame: UIScreen.main.bounds, andColors: [UIColor.flatYellow,UIColor.flatSand])
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollview)
        //set IQ hidden/show keyboard
         IQKeyboardManager.sharedManager().enable = true

        // Do any additional setup after loading the view.

        ///set up lblCopyright
        let copyrightString = "Copyright © 2017 FPT Retail J.S.C\r\nSmart Retail Project\r\nMobile Team"
        let copysize:CGSize = copyrightString.size(attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: Common.Size(s: 14))])
        let lblCopyright = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - copysize.height - Common.Size(s: 15), width: UIScreen.main.bounds.size.width, height: copysize.height))
        lblCopyright.textAlignment = .center
        lblCopyright.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        lblCopyright.text = copyrightString
       lblCopyright.textColor = UIColor.white
        lblCopyright.numberOfLines = 3
        scrollview.addSubview(lblCopyright)

        ///forgot password label
        let forgotString = "Forgot password"
        let forgotSize:CGSize = forgotString.size(attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: Common.Size(s: 14))])
        let lblforgot = UILabel(frame: CGRect(x: 0, y: lblCopyright.frame.origin.y - forgotSize.height * 3 - Common.Size(s: 15), width: UIScreen.main.bounds.size.width, height: forgotSize.height * 3))
        lblforgot.text = forgotString
        lblforgot.textAlignment = .center
        lblforgot.textColor = UIColor.white
        lblforgot.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let underlineAttributedString = NSAttributedString(string: forgotString, attributes: underlineAttribute)
        lblforgot.attributedText = underlineAttributedString
        scrollview.addSubview(lblforgot)
        ///action forgot password
        let actionForgotPass = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.actionForgotPass))
        lblforgot.isUserInteractionEnabled = true
        lblforgot.addGestureRecognizer(actionForgotPass)
        
        ///input password
        txtPassword = UITextField(frame: CGRect(x: Common.Size(s: 20), y: UIScreen.main.bounds.size.height / 2 - Common.Size(s: 40)/2, width: UIScreen.main.bounds.size.width - Common.Size(s: 20) * 2, height: Common.Size(s: 40)))
        txtPassword.placeholder = "password"
        txtPassword.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        txtPassword.borderStyle = UITextBorderStyle.roundedRect
        txtPassword.autocorrectionType = UITextAutocorrectionType.no
        txtPassword.keyboardType = UIKeyboardType.default
        txtPassword.returnKeyType = UIReturnKeyType.done
        txtPassword.clearButtonMode = UITextFieldViewMode.whileEditing;
        txtPassword.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        txtPassword.delegate = self
        txtPassword.isSecureTextEntry = true
        txtPassword.leftViewMode = UITextFieldViewMode.always
        scrollview.addSubview(txtPassword)
        
        
        let imgPass = UIImageView(frame: CGRect(x: txtPassword.frame.size.height / 4, y: txtPassword.frame.size.height / 4, width: txtPassword.frame.size.height / 2, height: txtPassword.frame.size.height / 2))
        imgPass.image = UIImage(named: "Lock-50")
        imgPass.contentMode = UIViewContentMode.scaleAspectFit

        let leftViewPass = UIView()
        leftViewPass.addSubview(imgPass)
        leftViewPass.frame = CGRect(x: 0, y: 0, width: txtPassword.frame.size.height, height: txtPassword.frame.size.height)
        txtPassword.leftView = leftViewPass
        ///inputusername
        txtUsername = UITextField(frame: CGRect(x: txtPassword.frame.origin.x , y: txtPassword.frame.origin.y - txtPassword.frame.size.height - Common.Size(s: 15), width: txtPassword.bounds.size.width, height: txtPassword.bounds.size.height))
        txtUsername.placeholder = "username"
        txtUsername.font = UIFont.systemFont(ofSize: Common.Size(s: 15))
        txtUsername.borderStyle = UITextBorderStyle.roundedRect
        txtUsername.autocorrectionType = UITextAutocorrectionType.no
        txtUsername.keyboardType = UIKeyboardType.numberPad
        txtUsername.returnKeyType = UIReturnKeyType.done
        txtUsername.clearButtonMode = UITextFieldViewMode.whileEditing;
        txtUsername.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        txtUsername.delegate = self
        scrollview.addSubview(txtUsername)
        txtUsername.leftViewMode = UITextFieldViewMode.always
        let imgUser = UIImageView(frame: CGRect(x: txtUsername.frame.size.height / 4, y: txtUsername.frame.size.height / 4, width: txtUsername.frame.size.height / 2, height: txtUsername.frame.size.height / 2))
        imgUser.image = UIImage(named: "User-50")
        imgUser.contentMode = UIViewContentMode.scaleAspectFit

        let leftViewUser = UIView()
        leftViewUser.addSubview(imgUser)
        leftViewUser.frame = CGRect(x: 0, y: 0, width: txtUsername.frame.size.height, height: txtUsername.frame.size.height)
        txtUsername.leftView = leftViewUser

        let btLogin = UIButton(frame: CGRect(x: txtPassword.frame.origin.x, y: txtPassword.frame.origin.y + txtPassword.frame.size.height + Common.Size(s: 15), width: txtPassword.bounds.size.width, height: txtPassword.bounds.size.height))
        btLogin.backgroundColor = UIColor(netHex:0xFFCC02)
        btLogin.layer.cornerRadius = 5
        btLogin.layer.borderWidth = 1
        btLogin.layer.borderColor = UIColor.white.cgColor
        btLogin.setTitle("Login",for: .normal)
        scrollview.addSubview(btLogin)
        //notification

        let notifyString = ""
        let sizeNotifyString: CGSize = notifyString.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: Common.Size(s: 14))])
        lbNotify = UILabel(frame: CGRect(x: btLogin.frame.origin.x, y: btLogin.frame.origin.y +  btLogin.frame.size.height + 25, width: btLogin.frame.size.width, height: sizeNotifyString.height))
        lbNotify.textAlignment = .center
        lbNotify.textColor = UIColor.red
        lbNotify.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        lbNotify.text = notifyString
        lbNotify.numberOfLines = 3;
        scrollview.addSubview(lbNotify)
        let frameLoading = CGRect(x: UIScreen.main.bounds.size.width/2 - Common.Size(s: 25), y:btLogin.frame.origin.y +  btLogin.frame.size.height + Common.Size(s: 25), width: Common.Size(s: 50), height: Common.Size(s: 50))
        loadingView = NVActivityIndicatorView(frame: frameLoading,
                                              type: .ballClipRotateMultiple)
        scrollview.addSubview(loadingView)

        //version
        let versionString = "Version \(Common.versionApp())"
        let sizeVersionString: CGSize = versionString.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: Common.Size(s: 16))])
        let lbVersion = UILabel(frame: CGRect(x: 0, y: txtUsername.frame.origin.y - sizeVersionString.height -  Common.Size(s:20), width: UIScreen.main.bounds.size.width, height: sizeVersionString.height))
        lbVersion.textAlignment = .center
        lbVersion.textColor = UIColor.white
        lbVersion.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbVersion.text = versionString
        scrollview.addSubview(lbVersion)

        //app name
        let appNameString = "FrameWork Of Jeremy"
        let sizeAppNameString: CGSize = appNameString.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: Common.Size(s:20))])
        let lbApp = UILabel(frame: CGRect(x: 0, y: lbVersion.frame.origin.y - sizeAppNameString.height - Common.Size(s:20), width: UIScreen.main.bounds.size.width, height: sizeAppNameString.height))
        lbApp.textAlignment = .center
        lbApp.textColor = UIColor(netHex:0xF76D2D)
        lbApp.font = UIFont.boldSystemFont(ofSize: Common.Size(s:22))
        lbApp.text = appNameString
        scrollview.addSubview(lbApp)

        //logo image
        let logoWidth:CGFloat = txtUsername.frame.size.width - Common.Size(s:22);
        var logo : UIImageView
        logo  = UIImageView(frame:CGRect(x: Common.Size(s:40), y: lbApp.frame.origin.y - logoWidth / 3.77 -  Common.Size(s:20), width: logoWidth, height: logoWidth / 3.77));
        logo.image = UIImage(named:"logo")

        scrollview.addSubview(logo)
        
        //button login action
        btLogin.addTarget(self, action:#selector(self.actionLogin), for: .touchUpInside)



    }
    func actionForgotPass(sender:UITapGestureRecognizer){
        UIApplication.shared.open(URL(string: Constant.URL_FORGOT_PASSWORD)!, options: [:], completionHandler: nil)


    }
    //action login
    func actionLogin() {
        lbNotify.text = ""
        loadingView.startAnimating()
        let username:String = txtUsername.text!
        let password:String = txtPassword.text!
        if (!username.isEmpty && !password.isEmpty) {
            APIService.login(username: username, password: password,handler: { (user , error) in
                if(error.isEmpty){
                    User.save(user: user!, password: password)
                    self.main()
                    self.loadingView.stopAnimating()
                }else{
                    self.lbNotify.text = error
                    self.loadingView.stopAnimating()
                }
            })
        }else{
            lbNotify.text = "Please enter an username or password"
            loadingView.stopAnimating()
        }
    }
    //main screen
    func main(){

        let mainViewController   = MainViewController()
        let leftMenuViewController = LeftMenuViewController()
        let drawerController     = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
        drawerController.mainViewController = UINavigationController(
            rootViewController: mainViewController
        )
      //  leftMenuViewController.delegate = mainViewController
        drawerController.drawerViewController = leftMenuViewController

        drawerController.drawerWidth = UIScreen.main.bounds.size.width * 80 / 100

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = drawerController
        window?.makeKeyAndVisible()

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
