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
import SVProgressHUD

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
        setupEvents();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _userNameTextField.becomeFirstResponder()
    }
    
    private func setupNavigation() {
        self.title = "HawkEye NEWS"
        let item = UIBarButtonItem()
        item.bk_init(withTitle: "Sign up", style: .plain) { _ in
            self.navigationController?.pushViewController(RegisterViewController(), animated: true)
        }
        self.navigationItem.rightBarButtonItem = item
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Sign in", style: .plain, target: nil, action: nil)
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
        
        _userNameTextField.text = KeyValueStore.userName
    }
    
    private func setupEvents() {
        _loginButton.bk_(whenTapped: { [weak self] in
            guard let `self` = self else { return }
            guard self.checkInput() else { return }
            AccountManager.shared.login()
        })
    }
    
    private func checkInput() -> Bool {
        if _userNameTextField.text == "" {
            SVProgressHUD.showError(withStatus: "Empty user name")
            return false
        } else if _passwordTextField.text == "" {
            SVProgressHUD.showError(withStatus: "Empty password")
            return false
        }
        
        return true
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
        textField.isSecureTextEntry = true
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
    
    private let _loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.backgroundColor = G.UI.kThemeColor
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage.size(width: 1.0, height: 1.0).color(G.UI.kThemeColor).image, for: .normal)
        return button
    }()
}
