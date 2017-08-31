//
//  ViewController.swift
//  SwiftyGuesturesView
//
//  Created by ALmanCoder on 08/31/2017.
//  Copyright (c) 2017 ALmanCoder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - settingGPView
    lazy var settingGPView : GHSettingGPView = {
        let settingGPView = GHSettingGPView()
        self.view.addSubview(settingGPView)
        return settingGPView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingGPView.frame = view.bounds
    }
    
}


