//
//  LoginViewController.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import SnapKit
import Hue

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
        setupEvents();
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "Login"
    }
    
    private func setupUI() {
        self.view.backgroundColor = G.UI.kViewColorDefault
        
        self.view.addSubview(_userNameTextField)
        self.view.addSubview(_passwordTextField)
        self.view.addSubview(_loginButton)
        
        _userNameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        _passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(_userNameTextField.snp.bottom).offset(16)
            make.left.equalTo(_userNameTextField)
            make.right.equalTo(_userNameTextField)
            make.height.equalTo(_userNameTextField)
        }
        _loginButton.snp.makeConstraints { make in
            make.top.equalTo(_passwordTextField.snp.bottom).offset(44)
            make.left.equalTo(_passwordTextField)
            make.right.equalTo(_passwordTextField)
            make.height.equalTo(_passwordTextField)
        }
        
        _userNameTextField.becomeFirstResponder()
    }
    
    private func setupEvents() {
        _loginButton.bk_(whenTapped: {
            AccountManager.shared.login()
        })
    }
    
    private let _userNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        return textField
    }()
    
    private let _passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let _loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.backgroundColor = G.UI.kThemeColor
        return button
    }()
}
