//
//  MenuViewController.swift
//  SGSDK_iOS_Sample
//
//  Created by 張又壬 on 2017/4/7.
//  Copyright © 2017年 SmartGames. All rights reserved.
//

import UIKit
import SGSDK
import StoreKit

class MenuViewController: UIViewController {
    
    let GameKey: String = "d7e73390-d7fd-11e6-9074-21c247f06802"
    let AppSecret: String = "d7d7c810-d7ee-11e6-9e86-db4f79aeee86"
    
    var productIDs = [String]()
    var tempPayresponse: SGPayResponse!
    
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
                         "Login by token",
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
        case LoginByToken = "Login by token"
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
        case .LoginByToken:
            onLoginByToken()
        case .IsLogin:
            onIsLogin()
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
        SGSDK.Instance.SetListener(listener: MsgListen)
        SGSDK.Instance.Init(GameKey: GameKey, AppSecret: AppSecret)
    }
    
    func onLogin() {
        SGSDK.Instance.Login()
    }
    
    func onLogout() {
        SGSDK.Instance.Logout()
        self.setMessage("Logout.")
    }
    
    func onGetOpenID() {
        if let msg = SGSDK.Instance.GetOpenID() {
            setMessage(msg)
        } else {
            setMessage("Please login.")
        }
    }
    
    func onGetSessionID() {
        if let msg = SGSDK.Instance.GetSessionID() {
            setMessage(msg)
        } else {
            setMessage("Please login.")
        }
    }
    
    func onGetToken() {
        if let msg = SGSDK.Instance.GetToken() {
            setMessage(msg)
        } else {
            setMessage("Please login.")
        }
    }
    
    func onSignup() {
        SGSDK.Instance.Signup()
    }
    
    func onForgotPassword() {
        SGSDK.Instance.ForgotPassword()
    }
    
    func onChangePassword() {
        SGSDK.Instance.ChangePassword()
    }
    
    func onParentalLock() {
        SGSDK.Instance.ParentalLock()
    }
    
    func onMyKid() {
        SGSDK.Instance.MyKid()
    }
    
    func onMyAccount() {
        SGSDK.Instance.MyAccount()
    }
    
    func onOpenID() {
        SGSDK.Instance.OpenID()
    }
    
    func onVerifySession() {
        guard let session = SGSDK.Instance.GetSessionID() else {
            print("Please Login.")
            return
        }
        
        guard let openid = SGSDK.Instance.GetOpenID() else {
            print("Please Login.")
            return
        }
        
        SGSDK.Instance.VerifySession(gameKey: GameKey, sessionId: session, openId: openid, sign: "")
    }
    
    func onLoginByToken() {
        guard let token = SGSDK.Instance.GetToken() else {
            self.setMessage("Please login.")
            return
        }
        
        SGSDK.Instance.LoginByToken(token: token)
    }
    
    func onGameStart() {
        SGSDK.Instance.GameStart()
        self.setMessage("Game start.")
    }
    
    func onGameStop() {
        SGSDK.Instance.GameStop()
    }
    
    func onIsLogin() {
        self.setMessage("Is login? \(SGSDK.Instance.IsLogin())")
    }
    
    func onChannelID() {
        self.setMessage("Channel ID: \(SGSDK.Instance.GetChannelID())")
    }
    
    func onShowFloatingButton() {
        SGSDK.Instance.HideFloatingButton()
    }
    
    func onLeftTop() {
        SGSDK.Instance.ShowFloatingButton(place: .LeftTop)
    }
    
    func onTop() {
        SGSDK.Instance.ShowFloatingButton(place: .Top)
    }
    
    func onRightTop() {
        SGSDK.Instance.ShowFloatingButton(place: .RightTop)
    }
    
    func onLeft() {
        SGSDK.Instance.ShowFloatingButton(place: .Left)
    }
    
    func onRight() {
        SGSDK.Instance.ShowFloatingButton(place: .Right)
    }
    
    func onLeftBottom() {
        SGSDK.Instance.ShowFloatingButton(place: .LeftBottom)
    }
    
    func onBottom() {
        SGSDK.Instance.ShowFloatingButton(place: .Bottom)
    }
    
    func onRightBottom() {
        SGSDK.Instance.ShowFloatingButton(place: .RightBottom)
    }
    
    func onDestroy() {
        SGSDK.Instance.Destroy()
        self.setMessage("Destroy SGSDK instance.")
    }
    
    func onIAPInit() {
        productIDs.append("ConsumbleItem")
        productIDs.append("NonConsumable")
        productIDs.append("AutoSubscription")
        productIDs.append("NonAutoSbuscriptions")
        SGSDK.Instance.IAPInit(productIDs: productIDs)
    }
    
    func onConsumable() {
        SGSDK.Instance.Pay(payRequest: initPayReq(productId: productIDs[0], payMethod: "managed"))
    }
    
    func onNonconsumable() {
        SGSDK.Instance.Pay(payRequest: initPayReq(productId: productIDs[1], payMethod: "managed"))
    }
    
    func onAutoSubscription() {
        SGSDK.Instance.Pay(payRequest: initPayReq(productId: productIDs[2], payMethod: "subscription"))
    }
    
    func onNonAutoSubscription() {
        SGSDK.Instance.Pay(payRequest: initPayReq(productId: productIDs[3], payMethod: "subscription"))
    }
    
    func onGetOrder() {
        guard tempPayresponse != nil else {
            setMessage("Play buy some product first.")
            return
        }
        
        guard let openid = SGSDK.Instance.GetOpenID() else {
            setMessage("Please login.")
            return
        }
        
        SGSDK.Instance.GetOrder(orderId: tempPayresponse.OrderId, gameKey: GameKey, openId: openid, sign: tempPayresponse.Sign)
    }
    
    func onRestore() {
        SGSDK.Instance.RestorePurchase()
    }
    
    private func initPayReq(productId: String, payMethod: String) -> SGPayRequest {
        let req = SGPayRequest()
        req.ProductId = productId
        req.PaymentMethod = payMethod
        req.PaymentChannel = "AppStore"
        req.ServerId = "Server ID"
        req.ServerName = "Server Name"
        req.RoleId = "9487"
        req.RoleName = "C8763"
        req.RoleLevel = 99
        req.Price = Float(30)
        req.ProductName = productId
        
        return req
    }
    
    func MsgListen(result: SGListenResult) {
        var message = "Code: \(result.Code), Message: \(result.Msg)"
        
        switch result.Code {
        case 201, 301, 901, 1001: //Login, Signup, Verify session, Login by token
            if let data = result.Data {
                let member = data as! SGMamber
                message.append("\nAccount: \(member.Account!)\nOpenID: \(member.OpenId!)\nToken: \(member.Token!)\nCreateTime: \(member.CreatTime!)\nLoginTime: \(member.LoginTime!)\nLanguage: \(member.Language!)\nChannel: \(member.Channel!)\nPhone: \(member.Phone!)\nEmail: \(member.EMail!)\nSessionID: \(member.SessionId!)\n")
                if let children = member.Children {
                    for child in children {
                        message.append("Name: \(child.Name!), Sex: \(child.Sex!), Face: \(child.Face!), Birthday: \(child.Birthday!)\n")
                    }
                }
                
            }
        case 1101:  // SG server validating receipt ok
            if let data = result.Data {
                tempPayresponse = data as! SGPayResponse
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
                let payresponse = data as! SGPayResponse
                message.append(", sign: \(payresponse.Sign) ")
            }
        case 8004:
            if let data = result.Data {
                let openid = data as! String
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
