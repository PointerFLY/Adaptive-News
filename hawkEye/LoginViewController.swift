//
//  LoginViewController.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let _userNameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    private let _passwordTextField: UITextField = {
       let textField = UITextField()
        return textField
    }()
    
    private let _loginButton: UIButton = {
        let button = UIButton()
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
        setupEvents();
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "Login"
        self.view.backgroundColor = UIColor.cyan
    }
    
    private func setupUI() {
        self.view.addSubview(_userNameTextField)
        self.view.addSubview(_passwordTextField)
        self.view.addSubview(_loginButton)
        
    }
    
    private func setupEvents() {
        _loginButton.bk_(whenTapped: {
            AccountManager.shared.login()
        })
    }
}
