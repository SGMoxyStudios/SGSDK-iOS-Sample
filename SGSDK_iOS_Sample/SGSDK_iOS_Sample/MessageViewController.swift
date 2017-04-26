//
//  MessageViewController.swift
//  SGSDK_iOS_Sample
//
//  Created by 張又壬 on 2017/4/7.
//  Copyright © 2017年 SmartGames. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var Message: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Message.text.removeAll()
        SetMessage("SG SDK Demo.")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onMenu(_ sender: UIBarButtonItem) {
        self.slideMenuController()?.openLeft()
    }
    
    @IBAction func onClear(_ sender: UIBarButtonItem) {
        Message.text.removeAll()
    }

    public func SetMessage(_ msg: String) {
        DispatchQueue.main.async {
            self.Message.text.append("\(msg)\n")
            self.Message.scrollRangeToVisible(NSRange(location: 0, length: self.Message.text.characters.count))
        }
    }
}
