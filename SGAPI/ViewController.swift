//
//  ViewController.swift
//  SGAPI
//
//  Created by Neo Hsu on 2017/2/9.
//  Copyright © 2017年 Neo Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIWebViewDelegate {
    let GameKey: String = "d7e73390-d7fd-11e6-9074-21c247f06802"
    let AppSecret: String = "d7d7c810-d7ee-11e6-9e86-db4f79aeee86"
    let PrivateKey: String = "azlxEUasGMOf1VoygA9Jvta76pG8QnoC"
    
    var myWebView :UIWebView!
    var myActivityIndicator:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let fullScreenSize = UIScreen.main.bounds.size
        
        // 預設尺寸
        let goWidth = 100.0
        let actionWidth = ( Double(fullScreenSize.width) - goWidth ) / 2
        
        var myButton = UIButton(frame: CGRect(x: 0, y: 20, width: actionWidth, height: actionWidth))
        myButton.setTitle("Init", for: .normal)
        myButton.setTitleColor(UIColor.black, for: .normal)
        myButton.addTarget(self, action: #selector(ViewController.Init), for: .touchUpInside)
        self.view.addSubview(myButton)
        
        myButton = UIButton(frame: CGRect(x: actionWidth, y: 20, width: actionWidth, height: actionWidth))
        myButton.setTitle("Login", for: .normal)
        myButton.setTitleColor(UIColor.black, for: .normal)
        myButton.addTarget(self, action: #selector(ViewController.Login), for: .touchUpInside)
        self.view.addSubview(myButton)
        
        myButton = UIButton(frame: CGRect(x: actionWidth * 2, y: 20,width: actionWidth, height: actionWidth))
        myButton.setTitle("GetID", for: .normal)
        myButton.setTitleColor(UIColor.black, for: .normal)
        myButton.addTarget(self, action: #selector(ViewController.GetID), for: .touchUpInside)
        self.view.addSubview(myButton)
        
        // 建立 UIWebView
        myWebView = UIWebView(frame: CGRect(
            x: 0, y: 60.0 + CGFloat(actionWidth),
            width: fullScreenSize.width,
            height: fullScreenSize.height - 60 - CGFloat(actionWidth)))
        
        // 設置委任對象
        myWebView.delegate = self
        
        // 加入到畫面中
        self.view.addSubview(myWebView)
        
        // 建立環狀進度條
        myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle:.gray)
        
        myActivityIndicator.center = CGPoint(x: fullScreenSize.width * 0.5, y: fullScreenSize.height * 0.5)
        self.view.addSubview(myActivityIndicator);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.    
    }
    
    func Init() {
        let aStr = String(format: "http://gameapi.smartgamesltd.com/init?gamekey=%@&appsecret=%@&privatekey=%@", GameKey, AppSecret, PrivateKey)
        let url = NSURL(string: aStr)
        let urlRequest = NSURLRequest(url: url! as URL)
        myWebView.loadRequest(urlRequest as URLRequest)
    }
    
    func Login() {
        let url = NSURL(string: "http://gameapi.smartgamesltd.com/login")
        let urlRequest = NSURLRequest(url: url! as URL)
        myWebView.loadRequest(urlRequest as URLRequest)
    }
    
    func GetID() {
        let url = NSURL(string: "http://gameapi.smartgamesltd.com/openid")
        let urlRequest = NSURLRequest(url: url! as URL)
        myWebView.loadRequest(urlRequest as URLRequest)
    }
    
    func stop() {
        // 取消讀取
        myWebView.stopLoading()
        
        // 隱藏環狀進度條
        myActivityIndicator.stopAnimating()
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        // 顯示進度條
        myActivityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        // 隱藏進度條
        myActivityIndicator.stopAnimating()
        
        var kind = 0
        var script = "ResultCode()"
        let url: String = (myWebView.request?.url?.path)!
        
        if url.range(of:"init") != nil {
            kind = 1
        } else
        if url.range(of:"login") != nil{
            kind = 2
        } else
        if url.range(of:"openid") != nil{
            kind = 3
            script = "GetOpenID()"
        }
        
        if let returnedString = webView.stringByEvaluatingJavaScript(from: script) {
            print("the result is \(returnedString)")
            if (kind == 3) {
                let alert = UIAlertController(title: "SG ID", message: returnedString, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
}

