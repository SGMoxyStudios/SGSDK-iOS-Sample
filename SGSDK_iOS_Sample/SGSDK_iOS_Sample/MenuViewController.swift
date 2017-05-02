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
                         "Get Kid Index",
                         "Get Kid Face",
                         "Forgot password",
                         "Change password",
                         "Parental lock",
                         "My kid",
                         "Select kid",
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
                         "Hide floating button",
                         "Left top",
                         "Top",
                         "Right top",
                         "Left",
                         "Right",
                         "Left bottom",
                         "Bottom",
                         "Right bottom",
                         "Is floating button visible",
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
        case GetKidIndex = "Get Kid Index"
        case GetKidFace = "Get Kid Face"
        case ForgotPassword = "Forgot password"
        case ChangePassword = "Change password"
        case ParentalLock = "Parental lock"
        case MyKid = "My kid"
        case SelectKid = "Select kid"
        case MyAccount = "My account"
        case OpenId = "OpenID"
        case VerifySession = "Verify session"
        case LoginByToken = "Login by token"
        case IsLogin = "Is login"
        case ChannelId = "Channel ID"
        case Destroy = "Destroy"
        case GameStart = "Game start"
        case GameStop = "Game stop"
        case HideFloatingButton = "Hide floating button"
        case LeftTop = "Left top"
        case Top = "Top"
        case RightTop = "Right top"
        case Left = "Left"
        case Right = "Right"
        case LeftBottom = "Left bottom"
        case Bottom = "Bottom"
        case RightBottom = "Right bottom"
        case IsFloatingButtonVisible = "Is floating button visible"
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
        case .GetKidIndex:
            onGetKidIndex()
        case .GetKidFace:
            onGetKidFace()
        case .ForgotPassword:
            onForgotPassword()
        case .ChangePassword:
            onChangePassword()
        case .ParentalLock:
            onParentalLock()
        case .MyKid:
            onMyKid()
        case .SelectKid:
            onSelectKid()
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
        case .HideFloatingButton:
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
        case .IsFloatingButtonVisible:
            onIsFloatingButtonVisible()
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
        SGSDK.Instance.SetListener(listener: MsgListener)
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
    
    func onGetKidIndex() {
        if let msg = SGSDK.Instance.GetKidIndex() {
            setMessage("\(msg)")
        } else {
            setMessage("Please login.")
        }
    }
    
    func onGetKidFace() {
        if let msg = SGSDK.Instance.GetKidFace() {
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
    
    func onSelectKid() {
        SGSDK.Instance.SelectKid()
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
        SGSDK.Instance.HideWidget()
    }
    
    func onLeftTop() {
        SGSDK.Instance.ShowWidget(place: .TopLeft)
    }
    
    func onTop() {
        SGSDK.Instance.ShowWidget(place: .Top)
    }
    
    func onRightTop() {
        SGSDK.Instance.ShowWidget(place: .TopRight)
    }
    
    func onLeft() {
        SGSDK.Instance.ShowWidget(place: .Left)
    }
    
    func onRight() {
        SGSDK.Instance.ShowWidget(place: .Right)
    }
    
    func onLeftBottom() {
        SGSDK.Instance.ShowWidget(place: .BottomLeft)
    }
    
    func onBottom() {
        SGSDK.Instance.ShowWidget(place: .Bottom)
    }
    
    func onRightBottom() {
        SGSDK.Instance.ShowWidget(place: .BottomRight)
    }
    
    func onIsFloatingButtonVisible() {
        self.setMessage("Is floating button visible? \(SGSDK.Instance.IsWidgetVisible())")
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
        
        tempPayresponse.Sign = "c8763"
        
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
    
    func MsgListener(result: SGListenerResult) {
        var message = "Code: \(result.Code), Message: \(result.Msg)"
        switch result.Code {
        case 201, 301, 1001, 801, 1501: // Login, Signup, Login by token
            if let data = result.Data {
                let member = data as! SGMamber
                result.SetDataDic(dataDic: member.ToDictionary())
            }
        case 1101:  // SG server validating receipt ok
            if let data = result.Data {
                tempPayresponse = data as! SGPayResponse
                result.SetDataDic(dataDic: tempPayresponse.ToDictionary())
            }
        case 1136:  // appstore transaction ok
            if let data = result.Data {
                let transaction = data as! SKPaymentTransaction
                message.append(", product ID:\(transaction.payment.productIdentifier), Date:\(String(describing: transaction.transactionDate))")
            }
        case 1141:  // Restore
            if let data = result.Data {
                let productIds = data as! [String]
                let dic: [String: Any] = ["ProductIds": productIds]
                result.SetDataDic(dataDic: dic)
            }
        case 1201:  // Get Order
            if let data = result.Data {
                let payresponse = data as! SGPayResponse
                result.SetDataDic(dataDic: payresponse.ToDictionary())
            }
        case 8004:  // Open ID
            if let data = result.Data {
                let openid = data as! String
                let dic:[String: Any] = ["OpenID": openid]
                result.SetDataDic(dataDic: dic)
            }
        default:
            break
        }
        
        if let jsonstr = result.ToJsonString() {
            message = jsonstr
        }
        self.setMessage(message)
    }
    
    private func setMessage(_ msg: String) {
        if let main = self.slideMenuController()?.mainViewController as? MessageViewController {
            main.SetMessage(msg)
        }
    }
}
