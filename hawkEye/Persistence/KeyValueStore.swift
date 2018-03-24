//
//  UserSettings.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import KeychainAccess
import Log

extension DefaultsKeys {
    static let userName = DefaultsKey<String?>("userName")
    static let token = DefaultsKey<String?>("token")
}

class KeyValueStore {
    
    private static let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    
    private struct KeychainKeys {
        
    }
    
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
            return Defaults[.token]
        }
        set {
            Defaults[.token] = newValue
            Defaults.synchronize()
        }
    }
}
