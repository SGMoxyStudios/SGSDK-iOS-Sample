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
    
    @IBAction func OnOpenID(_ sender: UIButton) {
        if let msg = SgSDK.Instance.GetOpenID() {
            setMessage("\(msg)")
        } else {
            setMessage("Please login.")
        }
    }

    @IBAction func OnSessionID(_ sender: UIButton) {
        if let msg = SgSDK.Instance.GetSessionID() {
            setMessage(msg)
        } else {
            setMessage("Please login.")
        }
    }
    
    @IBAction func OnToken(_ sender: UIButton) {
        if let msg = SgSDK.Instance.GetToken() {
            setMessage(msg)
        } else {
            setMessage("Please login.")
        }
    }
    
    func MsgListen(code: Int) {
        
        switch(code) {
        case 101:
            self.setMessage("init succeed!")
        case 102:
            self.setMessage("init failed")
        case 200:
            print("show login page.")
        case 201:
            self.setMessage("login succeed!")
        case 202:
            self.setMessage("login failed")
        default:
            self.setMessage("Unknow error")
        }
        
    }
    
    private func setMessage(_ msg: String) {
        DispatchQueue.main.async {
            self.Message.text = msg
        }
    }
}

