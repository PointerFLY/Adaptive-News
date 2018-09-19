//
//  Logger.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import Log
import SVProgressHUD
import RealmSwift

let Log = Logger()

struct G {
    static func setup() {
        UIBarButtonItem.appearance().setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 16)], for: .normal)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setMaximumDismissTimeInterval(1.5)
        
        #if DEBUG
            Log.enabled = true
        #else
            Log.enabled = false
        #endif
        
        _ = try! Realm()
    }
    
    struct UI {
        static let kViewColorDefault = UIColor(hex: "e5e5e5")
        static let kThemeColor = UIColor(hex: "cd2829")
        static let kTextFieldColor = UIColor(hex: "fefefe")
    }
}

