//
//  NavigationController.swift
//  hawkEye
//
//  Created by PointerFLY on 25/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import SwiftyImage

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.setBackgroundImage(UIImage.size(width: 1.0, height: 1.0).color(G.UI.kThemeColor).image, for: .default)
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)]
    }

}
