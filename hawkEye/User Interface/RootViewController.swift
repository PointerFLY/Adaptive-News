//
//  RootViewController.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import BlocksKit

class RootViewController: UIViewController {
    
    private var _loginNavigationController: NavigationController!
    private var _homeNavigationController: NavigationController!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(flipIfNeeded), name: NotificationNames.kLoginStatusChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AccountManager.shared.isLogin {
            _homeNavigationController = NavigationController(rootViewController: HomeViewController())
            self.addChildViewController(_homeNavigationController)
            self.view.addSubview(_homeNavigationController.view)
        } else {
            _loginNavigationController = NavigationController(rootViewController: RegisterNextViewController(registeringUser: RegisteringUser()))
            self.addChildViewController(_loginNavigationController)
            self.view.addSubview(_loginNavigationController.view)
        }
    }
    
    @objc
    private func flipIfNeeded() {
        if AccountManager.shared.isLogin && (self.childViewControllers.first! === _loginNavigationController) {
            _homeNavigationController = NavigationController(rootViewController: HomeViewController())
            self.addChildViewController(_homeNavigationController)
            self.transition(from: _loginNavigationController,
                            to: _homeNavigationController,
                            duration: 1.0,
                            options: [.transitionFlipFromLeft, .curveEaseInOut],
                            animations: nil,
                            completion: { _ in
                                self._loginNavigationController.removeFromParentViewController()
                                self._loginNavigationController = nil
            })
        } else if !AccountManager.shared.isLogin && (self.childViewControllers.first === _homeNavigationController) {
            _loginNavigationController = NavigationController(rootViewController: LoginViewController())
            self.addChildViewController(_loginNavigationController)
            self.transition(from: _homeNavigationController,
                            to: _loginNavigationController,
                            duration: 1.0, options: [.transitionFlipFromRight, .curveEaseInOut],
                            animations: nil,
                            completion: { _ in
                                self._homeNavigationController.removeFromParentViewController()
                                self._homeNavigationController = nil
            })
        }
    }
}

