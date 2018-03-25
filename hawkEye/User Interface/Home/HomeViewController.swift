//
//  HomeViewController.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "HawkEye NEWS"
        let item = UIBarButtonItem()
        item.bk_init(with: UIImage(named: "btn_me")!, style: .plain) { _ in
            self.navigationController?.pushViewController(ProfileViewController(), animated: true);
        }
        self.navigationItem.rightBarButtonItem = item
    }
    
    private func setupUI() {
        self.view.backgroundColor = G.UI.kViewColorDefault
    }
}
