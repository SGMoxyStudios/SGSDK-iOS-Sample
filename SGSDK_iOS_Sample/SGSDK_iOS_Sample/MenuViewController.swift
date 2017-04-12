//
//  MenuViewController.swift
//  SGSDK_iOS_Sample
//
//  Created by 張又壬 on 2017/4/7.
//  Copyright © 2017年 SmartGames. All rights reserved.
//

import UIKit
import SgSDK
import StoreKit

class MenuViewController: UIViewController {
    
    let GameKey: String = "d7e73390-d7fd-11e6-9074-21c247f06802"
    let AppSecret: String = "d7d7c810-d7ee-11e6-9e86-db4f79aeee86"
    
    var productIDs = [String]()
    var tempPayresponse: SgSDKPayResponse!
    
    let functionNames = ["------SgSDK------",
                         "Init",
                         "Signup",
                         "Login",
                         "Logout",
                         "Get Open ID",
                         "Get Session ID",
                         "Get Token",
                         "Forgot password",
                         "Change password",
                         "Parental lock",
                         "My kid",
                         "My account",
                         "OpenID",
                         "Verify session",
                         "Verify token",
                         "Is login",
                         "Channel ID",
                         "Destroy",
                         "------統計------",
                         "Game start",
                         "Game stop",
                         "------浮動按鈕------",
                         "Show floating button",
                         "Left top",
                         "Top",
                         "Right top",
                         "Left",
                         "Right",
                         "Left bottom",
                         "Bottom",
                         "Right bottom",
                         "------In-App Purchase------",
                         "IAP init",
                         "Consumable item",
                         "Non consumable item",
                         "Auto renew subscription",
                         "Non auto subscription",
                         "Get order",
                         "Restore"]
    
    enum eFunction: String {
        case Init = "Init"
        case SignUp = "Signup"
        case Login = "Login"
        case Logout = "Logout"
        case GetOpenId = "Get Open ID"
        case GetSessionId = "Get Session ID"
        case GetToken = "Get Token"
        case ForgotPassword = "Forgot password"
        case ChangePassword = "Change password"
        case ParentalLock = "Parental lock"
        case MyKid = "My kid"
        case MyAccount = "My account"
        case OpenId = "OpenID"
        case VerifySession = "Verify session"
        case VerifyToken = "Verify token"
        case IsLogin = "Is login"
        case ChannelId = "Channel ID"
        case Destroy = "Destroy"
        case GameStart = "Game start"
        case GameStop = "Game stop"
        case ShowFloatingButton = "Show floating button"
        case LeftTop = "Left top"
        case Top = "Top"
        case RightTop = "Right top"
        case Left = "Left"
        case Right = "Right"
        case LeftBottom = "Left bottom"
        case Bottom = "Bottom"
        case RightBottom = "Right bottom"
        case IAPInit = "IAP init"
        case Consumable = "Consumable item"
        case NonConsumable = "Non consumable item"
        case AutoSubscription = "Auto renew subscription"
        case NonAutoSubscription = "Non auto subscription"
        case GetOrder = "Get order"
        case Restore = "Restore"
        case Unknown = "Unknown"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(_ sender: UIBarButtonItem) {
        self.slideMenuController()?.closeLeft()
    }
    
}

extension MenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functionNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = functionNames[indexPath.row]
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.slideMenuController()?.closeLeft()
        let function = eFunction(rawValue: self.functionNames[indexPath.row]) ?? eFunction.Unknown
        onFunction(function)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension MenuViewController {
    func onFunction(_ name: eFunction) {
        switch name {
        case .Init:
            onInit()
        case .SignUp:
            onSignup()
        case .Login:
            onLogin()
        case .Logout:
            onLogout()
        case .GetOpenId:
            onGetOpenID()
        case .GetSessionId:
            onGetSessionID()
        case .GetToken:
            onGetToken()
        case .ForgotPassword:
            onForgotPassword()
        case .ChangePassword:
            onChangePassword()
        case .ParentalLock:
            onParentalLock()
        case .MyKid:
            onMyKid()
        case .MyAccount:
            onMyAccount()
        case .OpenId:
            onOpenID()
        case .VerifySession:
            onVerifySession()
        case .VerifyToken:
            onVerifyToken()
        case .IsLogin:
            onIsLogined()
        case .ChannelId:
            onChannelID()
        case .Destroy:
            onDestroy()
        case .GameStart:
            onGameStart()
        case .GameStop:
            onGameStop()
        case .ShowFloatingButton:
            onShowFloatingButton()
        case .LeftTop:
            onLeftTop()
        case .Top:
            onTop()
        case .RightTop:
            onRightTop()
        case .Left:
            onLeft()
        case .Right:
            onRight()
        case .LeftBottom:
            onLeftBottom()
        case .Bottom:
            onBottom()
        case .RightBottom:
            onRightBottom()
        case .IAPInit:
            onIAPInit()
        case .Consumable:
            onConsumable()
        case .NonConsumable:
            onNonconsumable()
        case .AutoSubscription:
            onAutoSubscription()
        case .NonAutoSubscription:
            onNonAutoSubscription()
        case .GetOrder:
            onGetOrder()
        case .Restore:
            onRestore()
        default:
            break
        }
    }
    
    func onInit() {
        SgSDK.Instance.SetListener(listener: MsgListen)
        SgSDK.Instance.Init(GameKey, AppSecret)
    }
    
    func onLogin() {
        SgSDK.Instance.Login()
    }
    
    func onLogout() {
        SgSDK.Instance.Logout()
        self.setMessage("Logout.")
    }
    
    func onGetOpenID() {
        if let msg = SgSDK.Instance.GetOpenID() {
            setMessage("\(msg)")
        } else {
            setMessage("Please login.")
        }
    }
    
    func onGetSessionID() {
        if let msg = SgSDK.Instance.GetSessionID() {
            setMessage(msg)
        } else {
            setMessage("Please login.")
        }
    }
    
    func onGetToken() {
        if let msg = SgSDK.Instance.GetToken() {
            setMessage(msg)
        } else {
            setMessage("Please login.")
        }
    }
    
    func onSignup() {
        SgSDK.Instance.Signup()
    }
    
    func onForgotPassword() {
        SgSDK.Instance.ForgotPassword()
    }
    
    func onChangePassword() {
        SgSDK.Instance.ChangePassword()
    }
    
    func onParentalLock() {
        SgSDK.Instance.ParentalLock()
    }
    
    func onMyKid() {
        SgSDK.Instance.MyKid()
    }
    
    func onMyAccount() {
        SgSDK.Instance.MyAccount()
    }
    
    func onOpenID() {
        SgSDK.Instance.OpenID()
    }
    
    func onVerifySession() {
        SgSDK.Instance.VerifySession(appId: "", session: "", uid: "", signature: "")
    }
    
    func onVerifyToken() {
        guard let token = SgSDK.Instance.GetToken() else {
            self.setMessage("Please login.")
            return
        }
        
        SgSDK.Instance.VerifyToken(token: token)
    }
    
    func onGameStart() {
        SgSDK.Instance.GameStart()
        self.setMessage("Game start.")
    }
    
    func onGameStop() {
        SgSDK.Instance.GameStop()
    }
    
    func onIsLogined() {
        self.setMessage("Is login? \(SgSDK.Instance.IsLogined())")
    }
    
    func onChannelID() {
        self.setMessage("Channel ID: \(SgSDK.Instance.GetChannelID())")
    }
    
    func onShowFloatingButton() {
        SgSDK.Instance.HideFloatingButton()
    }
    
    func onLeftTop() {
        SgSDK.Instance.ShowFloatingButton(place: .LeftTop)
    }
    
    func onTop() {
        SgSDK.Instance.ShowFloatingButton(place: .Top)
    }
    
    func onRightTop() {
        SgSDK.Instance.ShowFloatingButton(place: .RightTop)
    }
    
    func onLeft() {
        SgSDK.Instance.ShowFloatingButton(place: .Left)
    }
    
    func onRight() {
        SgSDK.Instance.ShowFloatingButton(place: .Right)
    }
    
    func onLeftBottom() {
        SgSDK.Instance.ShowFloatingButton(place: .LeftBottom)
    }
    
    func onBottom() {
        SgSDK.Instance.ShowFloatingButton(place: .Bottom)
    }
    
    func onRightBottom() {
        SgSDK.Instance.ShowFloatingButton(place: .RightBottom)
    }
    
    func onDestroy() {
        SgSDK.Instance.Destroy()
        self.setMessage("Destroy SgSDK instance.")
    }
    
    func onIAPInit() {
        productIDs.append("ConsumbleItem")
        productIDs.append("NonConsumable")
        productIDs.append("AutoSubscription")
        productIDs.append("NonAutoSbuscriptions")
        SgSDK.Instance.IAPInit(productIDs)
    }
    
    func onConsumable() {
        SgSDK.Instance.Pay(payRequest: initPayReq(productId: productIDs[0], payMethod: "managed"))
    }
    
    func onNonconsumable() {
        SgSDK.Instance.Pay(payRequest: initPayReq(productId: productIDs[1], payMethod: "managed"))
    }
    
    func onAutoSubscription() {
        SgSDK.Instance.Pay(payRequest: initPayReq(productId: productIDs[2], payMethod: "subscription"))
    }
    
    func onNonAutoSubscription() {
        SgSDK.Instance.Pay(payRequest: initPayReq(productId: productIDs[3], payMethod: "subscription"))
    }
    
    func onGetOrder() {
        guard tempPayresponse != nil else {
            setMessage("Play buy some product first.")
            return
        }
        
        SgSDK.Instance.GetOrder(GameKey, tempPayresponse)
    }
    
    func onRestore() {
        SgSDK.Instance.RestorePurchase()
    }
    
    private func initPayReq(productId: String, payMethod: String) -> SgSDKPayRequest {
        let req = SgSDKPayRequest()
        req.ProductId = productId
        req.PaymentMethod = payMethod
        req.PaymentChannel = "AppStore"
        req.ServerId = "Server ID"
        req.ServerName = "Server Name"
        req.RoleId = "9487"
        req.RoleName = "Roger"
        req.RoleLevel = 99
        req.PayNotifyUrl = "PAY_NOTIFY_URL"
        return req
    }
    
    func MsgListen(result: SgSDKResult) {
        var message = "code: \(result.Code), msg: \(result.Msg)"
        
        switch result.Code {
        case 901, 1001:   //Verify session / token
            if let data = result.Data {
                let verify = data as! Verify
                message.append(", Account: \(verify.Account!), OpenID: \(verify.OpenID!), Password: \(verify.Password!), Email: \(verify.EMail!)")
            }
        case 1101:  // SG server validating receipt ok
            if let data = result.Data {
                tempPayresponse = data as! SgSDKPayResponse
                message.append(", receipt: \(tempPayresponse.Receipt) ")
            }
        case 1136:  // appstore transaction ok
            if let data = result.Data {
                let transaction = data as! SKPaymentTransaction
                message.append(", product ID:\(transaction.payment.productIdentifier), Date:\(String(describing: transaction.transactionDate))")
            }
        case 1141: //Restore
            if let data = result.Data {
                let productIds = data as! [String]
                for productId in productIds {
                    message.append(", restore product: \(productId) ")
                }
            }
        case 1201:  //Get Order
            if let data = result.Data {
                let payresponse = data as! SgSDKPayResponse
                message.append(", sign: \(payresponse.Sign) ")
            }
        case 8004:
            if let data = result.Data {
                let openid = data as! Int
                message.append(", open id: \(openid)")
            }
        default:
            break
        }
        
        self.setMessage(message)
    }
    
    private func setMessage(_ msg: String) {
        if let main = self.slideMenuController()?.mainViewController as? MessageViewController {
            main.SetMessage(msg)
        }
    }
}
