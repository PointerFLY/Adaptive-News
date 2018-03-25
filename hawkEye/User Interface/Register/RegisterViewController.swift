//
//  RegisterViewController.swift
//  hawkEye
//
//  Created by PointerFLY on 25/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
        setupEvents();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _userNameTextField.becomeFirstResponder()
    }
    
    private func setupNavigation() {
        self.title = "HawkEye NEWS"
    }
    
    private func setupUI() {
        self.view.backgroundColor = G.UI.kViewColorDefault
        
        self.view.addSubview(_userNameTextField)
        self.view.addSubview(_passwordTextField)
        self.view.addSubview(_registerButton)
        
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
        _registerButton.snp.makeConstraints { make in
            make.top.equalTo(_passwordTextField.snp.bottom).offset(44)
            make.left.equalTo(_passwordTextField)
            make.right.equalTo(_passwordTextField)
            make.height.equalTo(_passwordTextField)
        }
        
        _userNameTextField.becomeFirstResponder()
    }
    
    private func setupEvents() {
        _registerButton.bk_(whenTapped: {
            AccountManager.shared.register()
        })
    }
    
    private let _userNameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(hex: "#f2f2f2")
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.placeholder = "User Name"
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0))
        let imageView = UIImageView(image: UIImage(named: "icon_username")!)
        imageView.contentMode = .scaleAspectFit
        leftView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12.0)
        }
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private let _passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(hex: "#f2f2f2")
        textField.layer.cornerRadius = 4
        textField.clipsToBounds = true
        textField.placeholder = "Password"
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0))
        let imageView = UIImageView(image: UIImage(named: "icon_password")!)
        imageView.contentMode = .scaleAspectFit
        leftView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12.0)
        }
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        return textField
    }()
    
    private let _registerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.backgroundColor = G.UI.kThemeColor
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage.size(width: 1.0, height: 1.0).color(G.UI.kThemeColor).image, for: .normal)
        return button
    }()
}
