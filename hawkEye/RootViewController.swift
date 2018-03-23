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
    
    private let _loginViewController = LoginViewController()
    private let _homeViewController = HomeViewController()
    
    private var _loginNavigationController: UINavigationController!
    private var _homeNavigationController: UINavigationController!
    
    private var _activeViewController: UINavigationController!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
        _loginNavigationController = UINavigationController(rootViewController: _loginViewController)
        _homeNavigationController = UINavigationController(rootViewController: _homeViewController)
        
        self.addChildViewController(_loginNavigationController)
        self.addChildViewController(_homeNavigationController)
        
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
            self.view.addSubview(_homeNavigationController.view)
            _activeViewController = _homeNavigationController
        } else {
            self.view.addSubview(_loginNavigationController.view)
            _activeViewController = _loginNavigationController
        }
    }
    
    @objc
    private func flipIfNeeded() {
        if AccountManager.shared.isLogin && (_activeViewController === _loginViewController) {
            self.transition(from: _loginNavigationController,
                            to: _homeNavigationController,
                            duration: 1.0,
                            options: [.transitionFlipFromLeft, .curveEaseInOut],
                            animations: nil,
                            completion: { _ in
                self._activeViewController = self._homeNavigationController
            })
        } else if !AccountManager.shared.isLogin && (_activeViewController === _homeViewController) {
            self.transition(from: _loginNavigationController,
                            to: _homeNavigationController,
                            duration: 1.0, options: [.transitionFlipFromLeft, .curveEaseInOut],
                            animations: nil,
                            completion: { _ in
                self._activeViewController = self._loginNavigationController
            })
        }
    }
}

