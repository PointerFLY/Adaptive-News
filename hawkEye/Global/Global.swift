//
//  Logger.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import Log

let Log = Logger()

struct G {
    static func setup() {
        UIApplication.shared.statusBarStyle = .lightContent
        
        #if DEBUG
            Log.enabled = true
        #else
            Log.enabled = false
        #endif
        
    }
    
    struct UI {
        static let kViewColorDefault = UIColor(hex: "e5e5e5")
        static let kThemeColor = UIColor(hex: "cd2829")
    }
}

