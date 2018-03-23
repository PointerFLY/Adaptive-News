//
//  UserSettings.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

extension DefaultsKeys {
    static let userName = DefaultsKey<String?>("userName")
}

class KeyValueStore {	
    
    static var userName: String? {
        get {
            return Defaults[.userName]
        }
        set {
            Defaults[.userName] = newValue
            Defaults.synchronize();
        }
    }
    
    static var token: String? {
        get {
            return nil
        }
        set {
            
        }
    }
}
