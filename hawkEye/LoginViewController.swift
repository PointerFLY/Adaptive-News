//
//  LoginViewController.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "Login"
        self.view.backgroundColor = UIColor.cyan
    }
}
