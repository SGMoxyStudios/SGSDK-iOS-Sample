//
//  ViewController.swift
//  SGSDK_iOS_Sample
//
//  Created by 張又壬 on 2017/3/24.
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
    @IBAction func onInit(_ sender: UIButton) {
        SgSDK.Instance.SetListener(listener: MsgListen)
        SgSDK.Instance.Init(GameKey, AppSecret)
    }
    
    @IBAction func onLogin(_ sender: UIButton) {
        SgSDK.Instance.Login()
    }
    
    @IBAction func onLogout(_ sender: UIButton) {
        SgSDK.Instance.Logout()
        self.setMessage("Logout.")
    }
    
    @IBAction func onGetOpenID(_ sender: UIButton) {
        if let msg = SgSDK.Instance.GetOpenID() {
            setMessage("\(msg)")
        } else {
            setMessage("Please login.")
        }
    }
    
    @IBAction func onGetSessionID(_ sender: UIButton) {
        if let msg = SgSDK.Instance.GetSessionID() {
            setMessage(msg)
        } else {
            setMessage("Please login.")
        }
    }
    
    @IBAction func onGetToken(_ sender: UIButton) {
        if let msg = SgSDK.Instance.GetToken() {
            setMessage(msg)
        } else {
            setMessage("Please login.")
        }
    }
    
    @IBAction func onSignup(_ sender: UIButton) {
        SgSDK.Instance.Signup()
    }
    
    @IBAction func onForgotPassword(_ sender: UIButton) {
        SgSDK.Instance.ForgotPassword()
    }
    
    @IBAction func onChangePassword(_ sender: UIButton) {
        SgSDK.Instance.ChangePassword()
    }
    
    @IBAction func onParentalLock(_ sender: UIButton) {
        SgSDK.Instance.ParentalLock()
    }
    
    @IBAction func onMyKid(_ sender: UIButton) {
        SgSDK.Instance.MyKid()
    }
    
    @IBAction func onMyAccount(_ sender: UIButton) {
        SgSDK.Instance.MyAccount()
    }
    
    @IBAction func onOpenID(_ sender: UIButton) {
        SgSDK.Instance.OpenID() {
            (any) -> Void in
            if let openid = any as? Int {
                self.setMessage("OpenID:\(openid)")
            }
        }
    }
    
    @IBAction func onVerifySession(_ sender: UIButton) {
        SgSDK.Instance.VerifySession(appId: "", session: "", uid: "", signature: "") {
            (any) -> Void in
            if let verify = any as? Verify {
                if verify.Code == SgSDK.eSDKErrorCode.VerifySession_Ok.rawValue {
                    self.setMessage("VerifySession, code: \(verify.Code), msg: \(verify.Msg), Account: \(verify.Account!), OpenID: \(verify.OpenID!), Password: \(verify.Password!), Email: \(verify.EMail!)")
                } else {
                    self.setMessage("Error code: \(verify.Code), msg: \(verify.Msg)")
                }
            }
        }
    }
    
    @IBAction func onVerifyToken(_ sender: UIButton) {
        guard let token = SgSDK.Instance.GetToken() else {
            self.setMessage("Please login.")
            return
        }
        
        SgSDK.Instance.VerifyToken(token: token) {
            (any) -> Void in
            if let verify = any as? Verify {
                if verify.Code == SgSDK.eSDKErrorCode.VerifyToken_Ok.rawValue {
                    self.setMessage("VerifyToken, code: \(verify.Code), msg: \(verify.Msg), Account: \(verify.Account!), OpenID: \(verify.OpenID!), Password: \(verify.Password!), Email: \(verify.EMail!)")
                } else {
                    self.setMessage("Error code: \(verify.Code), msg: \(verify.Msg)")
                }
            }
        }
    }
    
    @IBAction func onGameStart(_ sender: UIButton) {
        SgSDK.Instance.GameStart()
        self.setMessage("Game start.")
    }
    
    @IBAction func onGameStop(_ sender: UIButton) {
        SgSDK.Instance.GameStop()
    }
    
    @IBAction func onIsLogined(_ sender: UIButton) {
        self.setMessage("Is login? \(SgSDK.Instance.IsLogined())")
    }
    
    @IBAction func onChannelID(_ sender: UIButton) {
        self.setMessage("Channel ID: \(SgSDK.Instance.GetChannelID())")
    }
    
    @IBAction func onShowFloatingButton(_ sender: UIButton) {
        SgSDK.Instance.HideFloatingButton()
    }
    
    @IBAction func onLeftTop(_ sender: UIButton) {
        SgSDK.Instance.ShowFloatingButton(place: .LeftTop)
    }
    
    @IBAction func onTop(_ sender: UIButton) {
        SgSDK.Instance.ShowFloatingButton(place: .Top)
    }
    
    @IBAction func onRightTop(_ sender: UIButton) {
        SgSDK.Instance.ShowFloatingButton(place: .RightTop)
    }
    
    @IBAction func onLeft(_ sender: UIButton) {
        SgSDK.Instance.ShowFloatingButton(place: .Left)
    }
    
    @IBAction func onRight(_ sender: UIButton) {
        SgSDK.Instance.ShowFloatingButton(place: .Right)
    }
    
    @IBAction func onLeftBottom(_ sender: UIButton) {
        SgSDK.Instance.ShowFloatingButton(place: .LeftBottom)
    }
    
    @IBAction func onBottom(_ sender: UIButton) {
        SgSDK.Instance.ShowFloatingButton(place: .Bottom)
    }
    
    @IBAction func onRightBottom(_ sender: UIButton) {
        SgSDK.Instance.ShowFloatingButton(place: .RightBottom)
    }
    
    @IBAction func onDestroy(_ sender: UIButton) {
        SgSDK.Instance.Destroy()
        self.setMessage("Destroy SgSDK instance.")
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
