//
//  ViewController.swift
//  SgSDKDemo
//
//  Created by 張又壬 on 2017/3/15.
//  Copyright © 2017年 SmartGames. All rights reserved.
//

import UIKit
import SgSDK

class ViewController: UIViewController {
    let GameKey: String = "d7e73390-d7fd-11e6-9074-21c247f06802"
    let AppSecret: String = "d7d7c810-d7ee-11e6-9e86-db4f79aeee86"
    @IBOutlet weak var Message: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func OnInit(_ sender: UIButton) {
        SgSDK.Instance.SetListener(listener: MsgListen)
        SgSDK.Instance.Init(GameKey, AppSecret)
    }
    
    @IBAction func OnLogin(_ sender: UIButton) {
        SgSDK.Instance.Login()
    }
    
    @IBAction func Logout(_ sender: UIButton) {
        SgSDK.Instance.Logout()
    }
    
    @IBAction func OnGetOpenID(_ sender: UIButton) {
        if let msg = SgSDK.Instance.GetOpenID() {
            setMessage("\(msg)")
        } else {
            setMessage("Please login.")
        }
    }

    @IBAction func OnGetSessionID(_ sender: UIButton) {
        if let msg = SgSDK.Instance.GetSessionID() {
            setMessage(msg)
        } else {
            setMessage("Please login.")
        }
    }
    
    @IBAction func OnGetToken(_ sender: UIButton) {
        if let msg = SgSDK.Instance.GetToken() {
            setMessage(msg)
        } else {
            setMessage("Please login.")
        }
    }
    
    @IBAction func OnSignup(_ sender: UIButton) {
        SgSDK.Instance.Signup()
    }
    
    @IBAction func OnForgotPassword(_ sender: UIButton) {
        SgSDK.Instance.ForgotPassword()
    }
    
    @IBAction func OnChangePassword(_ sender: UIButton) {
        SgSDK.Instance.ChangePassword()
    }
    
    @IBAction func OnParentalLock(_ sender: UIButton) {
        SgSDK.Instance.ParentalLock()
    }
    
    @IBAction func OnMyKid(_ sender: UIButton) {
        SgSDK.Instance.MyKid()
    }
    
    @IBAction func OnMyAccount(_ sender: UIButton) {
        SgSDK.Instance.MyAccount()
    }
    
    @IBAction func OnOpenID(_ sender: UIButton) {
        SgSDK.Instance.OpenID() {
            (any) -> Void in
            if let openid = any as? Int {
                print("OpenID:\(openid)")
            }
        }
    }
    
    @IBAction func OnVerifySession(_ sender: UIButton) {
        SgSDK.Instance.VerifySession(appId: "", session: "", uid: "", signature: "") {
            (any) -> Void in
            if let verify = any as? Verify {
                print("VerifySession, Account: \(verify.Account), OpenID: \(verify.OpenID), Password: \(verify.Password), Email: \(verify.EMail)")
            }
        }
    }
    
    @IBAction func OnVerifyToken(_ sender: UIButton) {
        SgSDK.Instance.VerifyToken(token: SgSDK.Instance.GetToken()!) {
            (any) -> Void in
            if let verify = any as? Verify {
                print("VerifyToken, Account: \(verify.Account), OpenID: \(verify.OpenID), Password: \(verify.Password), Email: \(verify.EMail)")
            }
        }
    }
    
    @IBAction func OnGameStart(_ sender: UIButton) {
        SgSDK.Instance.GameStart()
    }
    
    @IBAction func OnGameStop(_ sender: UIButton) {
        SgSDK.Instance.GameStop()
    }
    
    func MsgListen(code: Int, msg: String) {
        self.setMessage("Error code: \(code), msg: \(msg)")
    }
    
    private func setMessage(_ msg: String) {
        DispatchQueue.main.async {
            self.Message.text = msg
        }
    }
}

