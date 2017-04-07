//
//  ViewController.swift
//  SGSDK_iOS_Sample
//
//  Created by 張又壬 on 2017/3/24.
//  Copyright © 2017年 SmartGames. All rights reserved.
//

import UIKit
import SgSDK
import StoreKit

class ViewController: SlideMenuController {
    
    override func awakeFromNib() {
        if let mainController = self.storyboard?.instantiateViewController(withIdentifier: "main") {
            self.mainViewController = mainController
        }
        
        if let leftController = self.storyboard?.instantiateViewController(withIdentifier: "left") {
            self.leftViewController = leftController
        }
        
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
